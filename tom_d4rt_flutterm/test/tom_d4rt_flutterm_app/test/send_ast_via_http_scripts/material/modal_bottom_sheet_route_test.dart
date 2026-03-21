// D4rt test script: Tests ModalBottomSheetRoute from material
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
        fontSize: 18,
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

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
    ),
  );
}

Widget buildBottomSheetPreview(
  String label,
  Color backgroundColor,
  double height,
  BorderRadius borderRadius,
  Color barrierColor,
) {
  print('Building bottom sheet preview: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: barrierColor.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Text(
                    'Barrier: ${barrierColor.toString().substring(6, 16)}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 0,
                child: Container(
                  height: height * 0.8,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: borderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(40),
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Sheet Content',
                          style: TextStyle(
                            fontSize: 12,
                            color: backgroundColor.computeLuminance() > 0.5
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: backgroundColor.withAlpha(60),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Height: ${height.toInt()}',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Radius: ${borderRadius.topLeft.x.toInt()}',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSheetHeightDemo() {
  print('Building sheet height demonstration');
  List<String> heightLabels = [
    'Small (25%)',
    'Medium (50%)',
    'Large (75%)',
    'Full Screen',
  ];
  List<double> heights = [60.0, 100.0, 130.0, 160.0];
  List<Color> colors = [
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.purple.shade300,
    Colors.orange.shade300,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < heightLabels.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors[i].withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors[i]),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: heights[i] * 0.4,
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heightLabels[i],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  'isScrollControlled: ${i >= 2}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sheet Height Options',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...items,
      ],
    ),
  );
}

Widget buildScrollableContentDemo() {
  print('Building scrollable content demonstration');
  List<Widget> listItems = [];
  int j = 0;
  for (j = 1; j <= 8; j = j + 1) {
    listItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$j',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Scrollable list item number $j',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
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
            Icon(Icons.list, color: Colors.indigo, size: 20),
            SizedBox(width: 8),
            Text(
              'Scrollable Sheet Content',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'DraggableScrollableSheet integration',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                ...listItems,
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBackgroundColorDemo() {
  print('Building background color demonstration');
  List<Color> bgColors = [
    Colors.white,
    Colors.grey.shade100,
    Colors.blue.shade50,
    Colors.amber.shade50,
    Colors.green.shade50,
    Colors.purple.shade50,
  ];
  List<String> colorNames = [
    'White (Default)',
    'Light Grey',
    'Light Blue',
    'Light Amber',
    'Light Green',
    'Light Purple',
  ];

  List<Widget> colorItems = [];
  int k = 0;
  for (k = 0; k < bgColors.length; k = k + 1) {
    colorItems.add(
      Container(
        width: 90,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColors[k],
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 6),
            Text(
              colorNames[k],
              style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Background Color Options',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: colorItems),
        ),
      ],
    ),
  );
}

Widget buildShapeDemo() {
  print('Building shape demonstration');
  List<BorderRadius> shapes = [
    BorderRadius.zero,
    BorderRadius.vertical(top: Radius.circular(8)),
    BorderRadius.vertical(top: Radius.circular(16)),
    BorderRadius.vertical(top: Radius.circular(24)),
    BorderRadius.vertical(top: Radius.circular(32)),
  ];
  List<String> shapeNames = [
    'Square',
    'Small (8px)',
    'Medium (16px)',
    'Large (24px)',
    'Extra Large (32px)',
  ];

  List<Widget> shapeItems = [];
  int m = 0;
  for (m = 0; m < shapes.length; m = m + 1) {
    shapeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: shapes[m],
                border: Border.all(color: Colors.indigo.shade300),
              ),
              child: Center(
                child: Icon(
                  Icons.expand_less,
                  color: Colors.indigo.shade600,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shapeNames[m],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    'RoundedRectangleBorder',
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
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sheet Shape / Border Radius',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...shapeItems,
      ],
    ),
  );
}

Widget buildBarrierColorDemo() {
  print('Building barrier color demonstration');
  List<Color> barrierColors = [
    Colors.black54,
    Colors.black87,
    Colors.black26,
    Colors.blue.shade900.withAlpha(120),
    Colors.purple.shade900.withAlpha(120),
    Colors.transparent,
  ];
  List<String> barrierNames = [
    'Default (black54)',
    'Dark (black87)',
    'Light (black26)',
    'Blue Tinted',
    'Purple Tinted',
    'Transparent',
  ];

  List<Widget> barrierItems = [];
  int n = 0;
  for (n = 0; n < barrierColors.length; n = n + 1) {
    barrierItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: barrierColors[n],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
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
                    barrierNames[n],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    'barrierColor parameter',
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
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Barrier Color Options',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...barrierItems,
      ],
    ),
  );
}

Widget buildDismissibleDemo() {
  print('Building dismissible demonstration');
  List<Map<String, dynamic>> dismissModes = [
    {
      'label': 'Dismissible (Default)',
      'isDismissible': true,
      'enableDrag': true,
      'icon': Icons.swipe_down,
      'color': Colors.green,
    },
    {
      'label': 'Non-Dismissible',
      'isDismissible': false,
      'enableDrag': false,
      'icon': Icons.lock,
      'color': Colors.red,
    },
    {
      'label': 'Tap Dismiss Only',
      'isDismissible': true,
      'enableDrag': false,
      'icon': Icons.touch_app,
      'color': Colors.orange,
    },
    {
      'label': 'Drag Dismiss Only',
      'isDismissible': false,
      'enableDrag': true,
      'icon': Icons.swipe,
      'color': Colors.blue,
    },
  ];

  List<Widget> modeItems = [];
  int p = 0;
  for (p = 0; p < dismissModes.length; p = p + 1) {
    Map<String, dynamic> mode = dismissModes[p];
    Color modeColor = mode['color'] as Color;
    modeItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: modeColor.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: modeColor.withAlpha(100)),
        ),
        child: Row(
          children: [
            Icon(mode['icon'] as IconData, color: modeColor, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode['label'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    'isDismissible: ${mode['isDismissible']}, enableDrag: ${mode['enableDrag']}',
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
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dismissible Behavior',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...modeItems,
      ],
    ),
  );
}

Widget buildActionsSheetDemo() {
  print('Building actions sheet demonstration');
  List<Map<String, dynamic>> actions = [
    {'label': 'Share', 'icon': Icons.share, 'color': Colors.blue},
    {'label': 'Copy Link', 'icon': Icons.link, 'color': Colors.teal},
    {'label': 'Edit', 'icon': Icons.edit, 'color': Colors.orange},
    {'label': 'Delete', 'icon': Icons.delete, 'color': Colors.red},
    {'label': 'Archive', 'icon': Icons.archive, 'color': Colors.purple},
    {'label': 'Pin', 'icon': Icons.push_pin, 'color': Colors.green},
  ];

  List<Widget> actionItems = [];
  int q = 0;
  for (q = 0; q < actions.length; q = q + 1) {
    Map<String, dynamic> action = actions[q];
    Color actionColor = action['color'] as Color;
    actionItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('Action tapped: ${action['label']}');
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: actionColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action['icon'] as IconData,
                      color: actionColor,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    action['label'] as String,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
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
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        SizedBox(height: 12),
        Text(
          'Quick Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Select an action to perform',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        ...actionItems,
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              print('Cancel pressed');
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Cancel'),
          ),
        ),
      ],
    ),
  );
}

Widget buildMultiStepFlowDemo() {
  print('Building multi-step flow demonstration');
  List<Map<String, dynamic>> steps = [
    {
      'step': 1,
      'title': 'Select Category',
      'subtitle': 'Choose a category for your item',
      'icon': Icons.category,
      'status': 'completed',
    },
    {
      'step': 2,
      'title': 'Add Details',
      'subtitle': 'Fill in the required information',
      'icon': Icons.edit_note,
      'status': 'current',
    },
    {
      'step': 3,
      'title': 'Review',
      'subtitle': 'Check your submission',
      'icon': Icons.preview,
      'status': 'pending',
    },
    {
      'step': 4,
      'title': 'Confirm',
      'subtitle': 'Submit your request',
      'icon': Icons.check_circle,
      'status': 'pending',
    },
  ];

  List<Widget> stepItems = [];
  int r = 0;
  for (r = 0; r < steps.length; r = r + 1) {
    Map<String, dynamic> step = steps[r];
    String status = step['status'] as String;
    Color stepColor = status == 'completed'
        ? Colors.green
        : status == 'current'
            ? Colors.blue
            : Colors.grey;
    bool isCompleted = status == 'completed';
    bool isCurrent = status == 'current';

    stepItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCurrent ? Colors.blue.shade200 : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted ? stepColor : stepColor.withAlpha(30),
                shape: BoxShape.circle,
                border: Border.all(color: stepColor, width: 2),
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check, color: Colors.white, size: 18)
                    : Text(
                        '${step['step']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: stepColor,
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
                    step['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isCurrent ? Colors.blue.shade700 : Colors.black87,
                    ),
                  ),
                  Text(
                    step['subtitle'] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              step['icon'] as IconData,
              color: stepColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
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
            Icon(Icons.linear_scale, color: Colors.indigo, size: 20),
            SizedBox(width: 8),
            Text(
              'Multi-Step Bottom Sheet Flow',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Navigate between steps within a sheet',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        ...stepItems,
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  print('Back pressed');
                },
                child: Text('Back'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print('Next pressed');
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildRouteParametersTable() {
  print('Building route parameters table');
  List<Map<String, String>> params = [
    {'name': 'builder', 'type': 'WidgetBuilder', 'desc': 'Builds the sheet content'},
    {'name': 'capturedThemes', 'type': 'CapturedThemes?', 'desc': 'Inherited themes'},
    {'name': 'isScrollControlled', 'type': 'bool', 'desc': 'Full height sheets'},
    {'name': 'barrierLabel', 'type': 'String?', 'desc': 'Accessibility label'},
    {'name': 'barrierOnTapHint', 'type': 'String?', 'desc': 'Tap hint for a11y'},
    {'name': 'backgroundColor', 'type': 'Color?', 'desc': 'Sheet background'},
    {'name': 'elevation', 'type': 'double?', 'desc': 'Shadow elevation'},
    {'name': 'shape', 'type': 'ShapeBorder?', 'desc': 'Sheet shape'},
    {'name': 'clipBehavior', 'type': 'Clip?', 'desc': 'Clipping behavior'},
    {'name': 'constraints', 'type': 'BoxConstraints?', 'desc': 'Size constraints'},
    {'name': 'modalBarrierColor', 'type': 'Color?', 'desc': 'Barrier overlay color'},
    {'name': 'isDismissible', 'type': 'bool', 'desc': 'Can dismiss by tapping'},
    {'name': 'enableDrag', 'type': 'bool', 'desc': 'Can dismiss by dragging'},
    {'name': 'showDragHandle', 'type': 'bool?', 'desc': 'Show drag handle'},
    {'name': 'settings', 'type': 'RouteSettings?', 'desc': 'Route settings'},
    {'name': 'transitionAnimationController', 'type': 'AnimationController?', 'desc': 'Custom animation'},
    {'name': 'anchorPoint', 'type': 'Offset?', 'desc': 'Anchor for animation'},
    {'name': 'useSafeArea', 'type': 'bool', 'desc': 'Respect safe area insets'},
  ];

  List<Widget> paramRows = [];
  int s = 0;
  for (s = 0; s < params.length; s = s + 1) {
    Map<String, String> param = params[s];
    paramRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: s % 2 == 0 ? Colors.grey.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                param['name']!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                param['type']!,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.purple.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                param['desc']!,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(Icons.table_chart, color: Colors.indigo, size: 18),
              SizedBox(width: 8),
              Text(
                'ModalBottomSheetRoute Parameters',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          color: Colors.grey.shade200,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Parameter',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  'Type',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        ...paramRows,
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ModalBottomSheetRoute deep demo test executing');
  print('Testing ModalBottomSheetRoute - Route for showing modal bottom sheets');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('ModalBottomSheetRoute Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview of ModalBottomSheetRoute'),
          buildDescriptionBox(
            'ModalBottomSheetRoute is a Route subclass used internally by showModalBottomSheet() '
            'to display a modal material design bottom sheet. It provides customization options '
            'for appearance, behavior, and accessibility. The route creates a barrier overlay '
            'and animates the sheet from the bottom of the screen.',
          ),
          buildInfoCard('Class', 'ModalBottomSheetRoute<T>'),
          buildInfoCard('Extends', 'PopupRoute<T>'),
          buildInfoCard('Package', 'package:flutter/material.dart'),
          buildInfoCard('Primary Use', 'Displaying modal bottom sheets with customizable behavior'),

          buildSectionHeader('2. Bottom Sheet Appearance'),
          buildBottomSheetPreview(
            'Default Appearance',
            Colors.white,
            100,
            BorderRadius.vertical(top: Radius.circular(16)),
            Colors.black54,
          ),
          buildBottomSheetPreview(
            'Custom Styled Sheet',
            Colors.blue.shade50,
            120,
            BorderRadius.vertical(top: Radius.circular(24)),
            Colors.black87,
          ),

          buildSectionHeader('3. Different Sheet Heights'),
          buildSheetHeightDemo(),
          buildDescriptionBox(
            'Set isScrollControlled to true for full-screen sheets that can exceed 50% '
            'of screen height. Use DraggableScrollableSheet for user-resizable sheets.',
          ),

          buildSectionHeader('4. Sheet with Scrollable Content'),
          buildScrollableContentDemo(),
          buildDescriptionBox(
            'Combine ModalBottomSheetRoute with DraggableScrollableSheet to create '
            'scrollable, resizable bottom sheets that users can drag to expand or collapse.',
          ),

          buildSectionHeader('5. Sheet Background Color'),
          buildBackgroundColorDemo(),
          buildInfoCard('Parameter', 'backgroundColor: Color?'),
          buildInfoCard('Default', 'Theme bottomSheetTheme.backgroundColor or Surface'),

          buildSectionHeader('6. Sheet Shape / Border Radius'),
          buildShapeDemo(),
          buildInfoCard('Parameter', 'shape: ShapeBorder?'),
          buildInfoCard('Common', 'RoundedRectangleBorder with BorderRadius.vertical'),

          buildSectionHeader('7. Barrier Color Demonstration'),
          buildBarrierColorDemo(),
          buildInfoCard('Parameter', 'modalBarrierColor: Color?'),
          buildInfoCard('Default', 'Colors.black54'),

          buildSectionHeader('8. Dismissible vs Non-Dismissible'),
          buildDismissibleDemo(),
          buildDescriptionBox(
            'Control how users can dismiss the sheet: by tapping the barrier '
            '(isDismissible), by dragging down (enableDrag), or require explicit action.',
          ),

          buildSectionHeader('9. Bottom Sheet with Actions'),
          buildActionsSheetDemo(),
          buildDescriptionBox(
            'Action sheets present a list of options or actions. Each action can include '
            'an icon, label, and callback. Include a cancel button for user-initiated dismissal.',
          ),

          buildSectionHeader('10. Multi-Step Bottom Sheet Flow'),
          buildMultiStepFlowDemo(),
          buildDescriptionBox(
            'Multi-step flows guide users through a process within a single bottom sheet. '
            'Use Navigator or state management to transition between steps while keeping '
            'the sheet open. Show progress indicators and provide navigation controls.',
          ),

          buildSectionHeader('Route Parameters Reference'),
          buildRouteParametersTable(),

          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ModalBottomSheetRoute deep demo completed successfully',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    ),
  );
}
