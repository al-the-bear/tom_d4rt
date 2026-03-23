// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshProgressIndicator from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildRefreshIndicatorCard(
  String label,
  String description,
  double value,
  Color indicatorColor,
  Color backgroundColor,
  double strokeWidth,
) {
  print('Building refresh indicator card: $label');
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
          width: 48,
          height: 48,
          child: RefreshProgressIndicator(
            value: value,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
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
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                'Progress: ${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 13,
                  color: indicatorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBasicIndicatorsSection() {
  print('Building basic indicators section');
  List<double> values = [0.0, 0.15, 0.25, 0.5, 0.75, 0.9, 1.0];
  List<String> labels = [
    'Empty (0%)',
    'Just Started (15%)',
    'Quarter (25%)',
    'Half (50%)',
    'Three-quarters (75%)',
    'Almost Done (90%)',
    'Complete (100%)',
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < values.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: RefreshProgressIndicator(
                value: values[i],
                backgroundColor: Colors.teal.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labels[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'value: ${values[i]}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(values[i] * 100).toInt()}%',
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
        Text(
          'Value Property Range (0.0 to 1.0)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RefreshProgressIndicator shows progress for pull-to-refresh operations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildColorThemesSection() {
  print('Building color themes section');
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.indigo,
  ];
  List<String> colorNames = [
    'Blue Theme',
    'Green Theme',
    'Red Theme',
    'Orange Theme',
    'Purple Theme',
    'Cyan Theme',
    'Pink Theme',
    'Indigo Theme',
  ];
  List<double> progressValues = [0.8, 0.6, 0.45, 0.7, 0.55, 0.9, 0.35, 0.65];

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
        child: Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: RefreshProgressIndicator(
                value: progressValues[c],
                backgroundColor: colors[c].shade100,
                valueColor: AlwaysStoppedAnimation<Color>(colors[c].shade700),
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    colorNames[c],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colors[c].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Progress: ${(progressValues[c] * 100).toInt()}%',
                    style: TextStyle(fontSize: 11, color: colors[c].shade600),
                  ),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors[c],
                shape: BoxShape.circle,
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
          'Color Themes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RefreshProgressIndicator supports custom colors via valueColor property',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildStrokeWidthSection() {
  print('Building stroke width section');
  List<double> strokeWidths = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0];

  List<Widget> strokeCards = [];
  int s = 0;
  for (s = 0; s < strokeWidths.length; s = s + 1) {
    strokeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: RefreshProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.deepPurple.shade100,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade600),
                strokeWidth: strokeWidths[s],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stroke Width: ${strokeWidths[s]}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Thicker strokes create bolder appearance',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${strokeWidths[s]}px',
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
        Text(
          'Stroke Width Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Adjust strokeWidth to change the thickness of the indicator',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: strokeCards),
      ],
    ),
  );
}

Widget buildSemanticLabelsSection() {
  print('Building semantic labels section');

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
          'RefreshProgressIndicator supports semanticsLabel and semanticsValue',
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
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: RefreshProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.blue.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                  semanticsLabel: 'Refreshing content',
                  semanticsValue: '50%',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'With Semantic Label',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'semanticsLabel: "Refreshing content"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                    Text(
                      'semanticsValue: "50%"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.accessibility, color: Colors.blue.shade700, size: 24),
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
              SizedBox(
                width: 44,
                height: 44,
                child: RefreshProgressIndicator(
                  value: 0.75,
                  backgroundColor: Colors.green.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                  semanticsLabel: 'Loading new data',
                  semanticsValue: '75%',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Loading Label',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'semanticsLabel: "Loading new data"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                    Text(
                      'semanticsValue: "75%"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.accessibility, color: Colors.green.shade700, size: 24),
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
                width: 44,
                height: 44,
                child: RefreshProgressIndicator(
                  value: 0.25,
                  backgroundColor: Colors.orange.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
                  semanticsLabel: 'Syncing with server',
                  semanticsValue: '25%',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sync Progress Label',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'semanticsLabel: "Syncing with server"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                    Text(
                      'semanticsValue: "25%"',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.accessibility,
                color: Colors.orange.shade700,
                size: 24,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonWithCircularSection() {
  print('Building comparison with CircularProgressIndicator section');

  List<double> compareValues = [0.25, 0.5, 0.75];

  List<Widget> comparisonRows = [];
  int v = 0;
  for (v = 0; v < compareValues.length; v = v + 1) {
    comparisonRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: RefreshProgressIndicator(
                      value: compareValues[v],
                      backgroundColor: Colors.teal.shade100,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.teal.shade600),
                      strokeWidth: 2.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${(compareValues[v] * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Circular',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: CircularProgressIndicator(
                      value: compareValues[v],
                      backgroundColor: Colors.blue.shade100,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                      strokeWidth: 4,
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
        Text(
          'Comparison: Refresh vs Circular',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'RefreshProgressIndicator extends CircularProgressIndicator with pull-to-refresh styling',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: comparisonRows),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade700),
                  SizedBox(width: 8),
                  Text(
                    'Key Differences',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '- RefreshProgressIndicator has a subtle elevation shadow',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 4),
              Text(
                '- Default strokeWidth is 2.5 vs CircularProgressIndicator 4.0',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 4),
              Text(
                '- Designed for use inside RefreshIndicator widget',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSizeVariationsSection() {
  print('Building size variations section');
  List<double> sizes = [24, 32, 40, 48, 56, 64, 80];

  List<Widget> sizeItems = [];
  int sz = 0;
  for (sz = 0; sz < sizes.length; sz = sz + 1) {
    sizeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: SizedBox(
                width: sizes[sz],
                height: sizes[sz],
                child: RefreshProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.indigo.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.indigo.shade600),
                  strokeWidth: 2.5,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${sizes[sz].toInt()}x${sizes[sz].toInt()} pixels',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Wrapped in SizedBox for sizing',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.indigo.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${sizes[sz].toInt()}px',
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
        Text(
          'Size Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Control size by wrapping in SizedBox or Container',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sizeItems),
      ],
    ),
  );
}

Widget buildBackgroundColorsSection() {
  print('Building background colors section');

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
        SizedBox(height: 4),
        Text(
          'The backgroundColor property controls the track color',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: RefreshProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.grey.shade700),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Light Grey Background',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'backgroundColor: Colors.grey.shade300',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.pink.shade200),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: RefreshProgressIndicator(
                  value: 0.7,
                  backgroundColor: Colors.pink.shade200,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.pink.shade700),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pink Background',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'backgroundColor: Colors.pink.shade200',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: RefreshProgressIndicator(
                  value: 0.55,
                  backgroundColor: Colors.white.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semi-Transparent on Dark',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'backgroundColor: Colors.white.withAlpha(50)',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              SizedBox(
                width: 48,
                height: 48,
                child: RefreshProgressIndicator(
                  value: 0.45,
                  backgroundColor: Colors.amber.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contrasting Colors',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Amber background with deep orange indicator',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: RefreshProgressIndicator(
                  value: 0.8,
                  backgroundColor: Colors.white.withAlpha(70),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On Gradient Background',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'White indicator on colorful gradient',
                      style: TextStyle(fontSize: 11, color: Colors.white70),
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

Widget buildIndeterminateSection() {
  print('Building indeterminate indicators section');

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
          'Indeterminate Mode',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'When value is null, the indicator shows indeterminate animation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: RefreshProgressIndicator(
                  backgroundColor: Colors.teal.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Indeterminate (value: null)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Continuous spinning animation',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.loop, color: Colors.teal.shade700),
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
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: RefreshProgressIndicator(
                  backgroundColor: Colors.blue.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thicker Indeterminate',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'strokeWidth: 3 for heavier appearance',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.loop, color: Colors.blue.shade700),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUseCasesSection() {
  print('Building use cases section');

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
          'Common Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Icon(Icons.refresh, color: Colors.green.shade700, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pull-to-Refresh',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Primary use inside RefreshIndicator widget',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: RefreshProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.green.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.sync, color: Colors.blue.shade700, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Synchronization',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Show sync progress with server',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: RefreshProgressIndicator(
                  value: 0.7,
                  backgroundColor: Colors.blue.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.cloud_download, color: Colors.orange.shade700, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content Loading',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Loading new content from network',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: RefreshProgressIndicator(
                  value: 0.35,
                  backgroundColor: Colors.orange.shade100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RefreshProgressIndicator deep demo executing');
  print('Widget: RefreshProgressIndicator');
  print('Package: flutter/material.dart');
  print('Description: Material Design circular progress indicator for pull-to-refresh');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('RefreshProgressIndicator Demo'),
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoCard(
            'Widget',
            'RefreshProgressIndicator',
          ),
          buildInfoCard(
            'Package',
            'flutter/material.dart',
          ),
          buildInfoCard(
            'Parent',
            'CircularProgressIndicator',
          ),
          buildInfoCard(
            'Purpose',
            'Circular progress indicator used within pull-to-refresh interactions',
          ),
          buildSectionHeader('Basic Indicators at Various Values'),
          buildBasicIndicatorsSection(),
          buildSectionHeader('Color Themes'),
          buildColorThemesSection(),
          buildSectionHeader('Stroke Width Variations'),
          buildStrokeWidthSection(),
          buildSectionHeader('Semantic Labels'),
          buildSemanticLabelsSection(),
          buildSectionHeader('Comparison with CircularProgressIndicator'),
          buildComparisonWithCircularSection(),
          buildSectionHeader('Size Variations'),
          buildSizeVariationsSection(),
          buildSectionHeader('Background Colors'),
          buildBackgroundColorsSection(),
          buildSectionHeader('Indeterminate Mode'),
          buildIndeterminateSection(),
          buildSectionHeader('Common Use Cases'),
          buildUseCasesSection(),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.teal.shade700),
                    SizedBox(width: 8),
                    Text(
                      'Demo Complete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'This demo showcases RefreshProgressIndicator with various values, colors, stroke widths, sizes, semantic labels, and background variations.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}
