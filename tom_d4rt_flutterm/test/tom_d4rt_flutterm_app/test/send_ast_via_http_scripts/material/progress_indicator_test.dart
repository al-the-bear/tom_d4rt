// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ProgressIndicator from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blue.shade700,
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

Widget buildCodeBlock(String code) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.green.shade300,
      ),
    ),
  );
}

Widget buildLinearProgressBasic(String label, double value, Color color) {
  print('Building linear progress indicator: $label with value: $value');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        LinearProgressIndicator(
          value: value,
          backgroundColor: color.withAlpha(50),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
        ),
        SizedBox(height: 8),
        Text(
          'LinearProgressIndicator with value: $value',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildCircularProgressBasic(
  String label,
  double value,
  Color color,
  double strokeWidth,
) {
  print('Building circular progress indicator: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: color.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: strokeWidth,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Progress: ${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Stroke Width: ${strokeWidth}px',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildValuePropertyDemo() {
  print('Building value property demonstration');
  List<double> values = [0.0, 0.25, 0.5, 0.75, 1.0];
  List<String> labels = ['Empty', 'Quarter', 'Half', 'Three-quarters', 'Full'];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < values.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                value: values[i],
                backgroundColor: Colors.blue.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                strokeWidth: 4,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labels[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    'value: ${values[i]}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(values[i] * 100).toInt()}%',
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
        Text(
          'Value Property Range (0.0 to 1.0)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The value property represents progress from 0% to 100%',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildColorShowcase() {
  print('Building color showcase for progress indicators');
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  List<String> colorNames = [
    'Blue',
    'Green',
    'Red',
    'Orange',
    'Purple',
    'Teal',
  ];
  List<double> progressValues = [0.8, 0.6, 0.45, 0.7, 0.55, 0.9];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < colors.length; c = c + 1) {
    colorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[c].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors[c].shade200),
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
                    color: colors[c],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  colorNames[c],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colors[c].shade800,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  '${(progressValues[c] * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colors[c].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progressValues[c],
              backgroundColor: colors[c].shade100,
              valueColor: AlwaysStoppedAnimation<Color>(colors[c].shade600),
              minHeight: 6,
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
          'Color Customization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Use valueColor and backgroundColor to style indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildBackgroundColorDemo() {
  print('Building background color demonstration');

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
          'Background Color Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'Light Background',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.65,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
          minHeight: 8,
        ),
        SizedBox(height: 16),
        Text(
          'Colored Background',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.55,
          backgroundColor: Colors.pink.shade100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade700),
          minHeight: 8,
        ),
        SizedBox(height: 16),
        Text(
          'Transparent Background',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(6),
          ),
          child: LinearProgressIndicator(
            value: 0.75,
            backgroundColor: Colors.white.withAlpha(40),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            minHeight: 8,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Contrasting Background',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.45,
          backgroundColor: Colors.amber.shade100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
          minHeight: 8,
        ),
      ],
    ),
  );
}

Widget buildSemanticLabelDemo() {
  print('Building semantic label demonstration');

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
          'Semantic Labels for Accessibility',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Progress indicators should have semantic labels for screen readers',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.download, color: Colors.green.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'File Download Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.67,
                semanticsLabel: 'File download progress',
                semanticsValue: '67%',
                backgroundColor: Colors.green.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green.shade600,
                ),
                minHeight: 6,
              ),
              SizedBox(height: 6),
              Text(
                'semanticsLabel: "File download progress"',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.upload, color: Colors.blue.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Upload Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.42,
                semanticsLabel: 'Upload progress',
                semanticsValue: '42%',
                backgroundColor: Colors.blue.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                minHeight: 6,
              ),
              SizedBox(height: 6),
              Text(
                'semanticsLabel: "Upload progress"',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: 0.85,
                  semanticsLabel: 'Installation progress',
                  semanticsValue: '85%',
                  backgroundColor: Colors.orange.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orange.shade700,
                  ),
                  strokeWidth: 4,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Installation Progress',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    Text(
                      'Circular with semantic label: 85%',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildLinearProgressShowcase() {
  print('Building linear progress indicator showcase');

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
          'LinearProgressIndicator Implementation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Horizontal progress bar showing completion status',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Default Height (4px)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.6,
          backgroundColor: Colors.blue.shade100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        SizedBox(height: 16),
        Text(
          'Custom Height (8px)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.75,
          backgroundColor: Colors.green.shade100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          minHeight: 8,
        ),
        SizedBox(height: 16),
        Text(
          'Thick Progress Bar (12px)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: 0.45,
          backgroundColor: Colors.purple.shade100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          minHeight: 12,
        ),
        SizedBox(height: 16),
        Text(
          'Extra Thick (20px)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.55,
            backgroundColor: Colors.red.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            minHeight: 20,
          ),
        ),
      ],
    ),
  );
}

Widget buildCircularProgressShowcase() {
  print('Building circular progress indicator showcase');

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
          'CircularProgressIndicator Implementation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Circular arc showing progress percentage',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: 0.25,
                    backgroundColor: Colors.blue.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '25%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: 0.50,
                    backgroundColor: Colors.green.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '50%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.orange.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    strokeWidth: 4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '75%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.teal.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    strokeWidth: 4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '100%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildIndeterminateDemo() {
  print('Building indeterminate vs determinate demonstration');

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
          'Indeterminate vs Determinate Progress',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Use indeterminate when progress amount is unknown',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Determinate (value: 0.7)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.7,
                backgroundColor: Colors.blue.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                minHeight: 6,
              ),
              SizedBox(height: 6),
              Text(
                'Shows exact progress percentage',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Indeterminate (value: null)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                backgroundColor: Colors.purple.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.purple.shade600,
                ),
                minHeight: 6,
              ),
              SizedBox(height: 6),
              Text(
                'Animates continuously - progress unknown',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.green.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 4,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Circular Determinate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'value: 0.65 (65% complete)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                strokeWidth: 4,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Circular Indeterminate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'value: null (spinning animation)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildStrokeWidthDemo() {
  print('Building stroke width demonstration');
  List<double> strokeWidths = [2.0, 4.0, 6.0, 8.0, 10.0, 12.0];

  List<Widget> strokeItems = [];
  int s = 0;
  for (s = 0; s < strokeWidths.length; s = s + 1) {
    strokeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: 0.6,
                backgroundColor: Colors.indigo.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                strokeWidth: strokeWidths[s],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'strokeWidth: ${strokeWidths[s]}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Thickness of the circular indicator arc',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${strokeWidths[s].toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
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
        Text(
          'Custom Stroke Width',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'CircularProgressIndicator strokeWidth property',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: strokeItems),
      ],
    ),
  );
}

Widget buildAnimationBehaviorDemo() {
  print('Building animation behavior demonstration');

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
          'Animation Behavior',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Progress indicators animate smoothly between values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.animation, color: Colors.cyan.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'AlwaysStoppedAnimation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.cyan.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan.shade700),
                minHeight: 6,
              ),
              SizedBox(height: 6),
              Text(
                'AlwaysStoppedAnimation<Color>(Colors.cyan)',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.rotate_right,
                    color: Colors.deepPurple.shade700,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Indeterminate Animation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepPurple,
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.deepPurple.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.deepPurple,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Both circular and linear animate when value is null',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Tip',
          'Use AnimationController for custom color transitions',
        ),
        buildInfoCard(
          'Note',
          'Indeterminate indicators run continuously until disposed',
        ),
      ],
    ),
  );
}

Widget buildInteractiveShowcase() {
  print('Building interactive progress showcase');

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
          'Interactive Progress Showcase',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Common use cases for progress indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.cloud_download, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Downloading File...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.73,
                  backgroundColor: Colors.white.withAlpha(80),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 10,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '73% complete',
                    style: TextStyle(
                      color: Colors.white.withAlpha(220),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '7.3 MB / 10 MB',
                    style: TextStyle(
                      color: Colors.white.withAlpha(220),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: 0.88,
                            backgroundColor: Colors.green.shade100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.shade600,
                            ),
                            strokeWidth: 7,
                          ),
                        ),
                        Text(
                          '88%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Battery Level',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: 0.45,
                            backgroundColor: Colors.orange.shade100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange.shade600,
                            ),
                            strokeWidth: 7,
                          ),
                        ),
                        Text(
                          '45%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Storage Used',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.shade700,
                  ),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loading content...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Indeterminate progress indicator',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProgressStepsDemo() {
  print('Building progress steps demonstration');
  List<String> stepLabels = [
    'Account',
    'Personal',
    'Address',
    'Payment',
    'Confirm',
  ];
  List<IconData> stepIcons = [
    Icons.person,
    Icons.badge,
    Icons.location_on,
    Icons.payment,
    Icons.check,
  ];
  int currentStep = 3;

  List<Widget> stepWidgets = [];
  int st = 0;
  for (st = 0; st < stepLabels.length; st = st + 1) {
    bool isCompleted = st < currentStep;
    bool isCurrent = st == currentStep;

    Color stepColor = Colors.grey.shade400;
    if (isCompleted) {
      stepColor = Colors.green.shade600;
    } else if (isCurrent) {
      stepColor = Colors.blue.shade600;
    }

    stepWidgets.add(
      Expanded(
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted ? stepColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: stepColor, width: 2),
              ),
              child: Icon(
                isCompleted ? Icons.check : stepIcons[st],
                size: 18,
                color: isCompleted ? Colors.white : stepColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              stepLabels[st],
              style: TextStyle(
                fontSize: 10,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCompleted
                    ? Colors.green.shade700
                    : isCurrent
                    ? Colors.blue.shade700
                    : Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    if (st < stepLabels.length - 1) {
      stepWidgets.add(
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 17),
              Container(
                height: 2,
                color: st < currentStep
                    ? Colors.green.shade400
                    : Colors.grey.shade300,
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      );
    }
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
          'Multi-Step Progress',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Combine progress indicators with step visualization',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20),
        Row(children: stepWidgets),
        SizedBox(height: 16),
        LinearProgressIndicator(
          value: currentStep / (stepLabels.length - 1),
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 6,
        ),
        SizedBox(height: 8),
        Text(
          'Step ${currentStep + 1} of ${stepLabels.length}: ${stepLabels[currentStep]}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget buildRefreshIndicatorDemo() {
  print('Building refresh indicator demonstration');

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
          'RefreshProgressIndicator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Used in pull-to-refresh interactions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RefreshProgressIndicator(
                    value: 0.3,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 2.5,
                  ),
                ),
                SizedBox(height: 8),
                Text('30%', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RefreshProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 2.5,
                  ),
                ),
                SizedBox(height: 8),
                Text('60%', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RefreshProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 2.5,
                  ),
                ),
                SizedBox(height: 8),
                Text('Loading', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Note',
          'RefreshProgressIndicator is used by RefreshIndicator widget',
        ),
      ],
    ),
  );
}

Widget buildLoadingOverlayDemo() {
  print('Building loading overlay demonstration');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loading Overlay Pattern',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Common UX pattern: overlay content while loading',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 16),
              Container(
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 14,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      height: 12,
                                      width: 150,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 10,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 10,
                            width: 200,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                                strokeWidth: 4,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProgressWithText() {
  print('Building progress with text demonstration');
  List<double> progressValues = [0.15, 0.45, 0.78, 0.95];
  List<String> statusLabels = [
    'Starting',
    'Processing',
    'Finalizing',
    'Almost done',
  ];
  List<MaterialColor> progressColors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
  ];

  List<Widget> items = [];
  int p = 0;
  for (p = 0; p < progressValues.length; p = p + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: progressColors[p].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: progressColors[p].shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  statusLabels[p],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: progressColors[p].shade800,
                  ),
                ),
                Text(
                  '${(progressValues[p] * 100).toInt()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: progressColors[p].shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressValues[p],
              backgroundColor: progressColors[p].shade100,
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColors[p].shade600,
              ),
              minHeight: 8,
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
          'Progress with Status Text',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Combine progress indicators with descriptive labels',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildCircularWithCenterText() {
  print('Building circular progress with center text');

  Widget buildCircularWithLabel(double value, Color color, String label) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: value,
                backgroundColor: color.withAlpha(50),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: 8,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ],
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
          'Circular Progress with Center Text',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Stack progress indicator with percentage display',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCircularWithLabel(0.35, Colors.red, 'CPU'),
            buildCircularWithLabel(0.62, Colors.blue, 'Memory'),
            buildCircularWithLabel(0.89, Colors.green, 'Disk'),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ProgressIndicator deep demo starting');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ProgressIndicator Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'ProgressIndicator (abstract)'),
            buildInfoCard(
              'Purpose',
              'Base class for circular and linear progress indicators',
            ),
            buildInfoCard(
              'Subclasses',
              'LinearProgressIndicator, CircularProgressIndicator',
            ),
            buildInfoCard(
              'Key Property',
              'value: null for indeterminate, 0.0-1.0 for determinate',
            ),
            buildInfoCard('Package', 'package:flutter/material.dart'),

            buildSectionHeader('2. Value Property (0.0-1.0)'),
            buildValuePropertyDemo(),
            buildInfoCard(
              'Determinate',
              'Set value between 0.0 and 1.0 to show exact progress',
            ),
            buildInfoCard(
              'Indeterminate',
              'Set value to null for continuous animation',
            ),

            buildSectionHeader('3. Color and Background Color'),
            buildColorShowcase(),
            buildBackgroundColorDemo(),

            buildSectionHeader('4. Semantic Label'),
            buildSemanticLabelDemo(),
            buildInfoCard(
              'Accessibility',
              'Always provide semanticsLabel for screen readers',
            ),

            buildSectionHeader('5. LinearProgressIndicator'),
            buildLinearProgressShowcase(),
            buildLinearProgressBasic('Blue Progress', 0.6, Colors.blue),
            buildLinearProgressBasic('Green Task', 0.85, Colors.green),
            buildLinearProgressBasic('Orange Warning', 0.35, Colors.orange),

            buildSectionHeader('6. CircularProgressIndicator'),
            buildCircularProgressShowcase(),
            buildCircularProgressBasic('Download', 0.72, Colors.indigo, 5.0),
            buildCircularProgressBasic('Upload', 0.45, Colors.teal, 4.0),
            buildCircularProgressBasic(
              'Processing',
              0.58,
              Colors.deepOrange,
              6.0,
            ),

            buildSectionHeader('7. Indeterminate vs Determinate'),
            buildIndeterminateDemo(),
            buildInfoCard(
              'Use Determinate',
              'When you know the completion percentage',
            ),
            buildInfoCard(
              'Use Indeterminate',
              'When operation duration is unknown',
            ),

            buildSectionHeader('8. Custom Stroke Width'),
            buildStrokeWidthDemo(),
            buildInfoCard(
              'Default',
              'strokeWidth: 4.0 is the default for CircularProgressIndicator',
            ),

            buildSectionHeader('9. Animation Behavior'),
            buildAnimationBehaviorDemo(),
            buildProgressWithText(),

            buildSectionHeader('10. Interactive Progress Showcase'),
            buildInteractiveShowcase(),
            buildCircularWithCenterText(),
            buildProgressStepsDemo(),
            buildRefreshIndicatorDemo(),
            buildLoadingOverlayDemo(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('ProgressIndicator deep demo completed');
  return result;
}
