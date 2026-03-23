// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PersistentBottomSheetController from material
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
        Container(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
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

Widget buildCodeSnippet(String title, String code) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: Colors.indigo.shade300, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            code,
            style: TextStyle(
              color: Colors.green.shade300,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBasicBottomSheetDemo() {
  print('Building basic bottom sheet demo');
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
          'Basic Persistent Bottom Sheet',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'A persistent bottom sheet remains visible while the user interacts with the main content.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Main Content Area',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Persistent Bottom Sheet',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
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
  );
}

Widget buildControllerMethodsDemo() {
  print('Building controller methods demo');
  List<String> methodNames = ['close()', 'setState(VoidCallback fn)', 'closed'];
  List<String> methodDescs = [
    'Closes the bottom sheet and removes it from the scaffold',
    'Rebuilds the bottom sheet with updated state',
    'Future that completes when the sheet is closed',
  ];
  List<IconData> methodIcons = [Icons.close, Icons.refresh, Icons.check_circle];
  List<MaterialColor> methodColors = [Colors.red, Colors.blue, Colors.green];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < methodNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: methodColors[i].withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: methodColors[i].withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: methodColors[i].withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(methodIcons[i], color: methodColors[i], size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodNames[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: methodColors[i].shade700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    methodDescs[i],
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
        Text(
          'Controller Methods',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Available methods on PersistentBottomSheetController',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildSetStateCallbackDemo() {
  print('Building setState callback demo');
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
          'Using setState Callback',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The setState method allows dynamic updates to the bottom sheet content without closing and reopening it.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        buildCodeSnippet(
          'setState Example',
          'PersistentBottomSheetController controller;\n\n'
              'controller = scaffoldKey.currentState\n'
              '  .showBottomSheet((context) {\n'
              '    return Container(\n'
              '      child: Text(counter.toString()),\n'
              '    );\n'
              '  });\n\n'
              'controller.setState(() {\n'
              '  counter = counter + 1;\n'
              '});',
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
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The setState callback triggers a rebuild of the sheet builder function.',
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

Widget buildScrollableContentDemo() {
  print('Building scrollable content demo');
  List<String> items = [
    'Item 1 - First entry',
    'Item 2 - Second entry',
    'Item 3 - Third entry',
    'Item 4 - Fourth entry',
    'Item 5 - Fifth entry',
    'Item 6 - Sixth entry',
  ];

  List<Widget> listItems = [];
  int i = 0;
  for (i = 0; i < items.length; i = i + 1) {
    listItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: (i % 2 == 0) ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(items[i], style: TextStyle(fontSize: 13)),
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
          'Scrollable Content in Bottom Sheet',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Bottom sheets can contain scrollable content like ListView or SingleChildScrollView.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(children: listItems),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSheetStylingDemo() {
  print('Building sheet styling demo');
  List<String> styleNames = ['Elevated', 'Flat', 'Rounded', 'Accent'];
  List<Color> bgColors = [
    Colors.white,
    Colors.grey.shade100,
    Colors.indigo.shade50,
    Colors.amber.shade50,
  ];
  List<double> elevations = [16.0, 0.0, 8.0, 4.0];
  List<Color> borderColors = [
    Colors.transparent,
    Colors.grey.shade300,
    Colors.indigo.shade200,
    Colors.amber.shade300,
  ];

  List<Widget> styleCards = [];
  int s = 0;
  for (s = 0; s < styleNames.length; s = s + 1) {
    styleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Material(
          elevation: elevations[s],
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColors[s],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColors[s]),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.style,
                    color: Colors.indigo.shade700,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        styleNames[s],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Elevation: ${elevations[s].toInt()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Style ${s + 1}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.indigo.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          'Sheet Styling Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different elevation and color styles for bottom sheets',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleCards),
      ],
    ),
  );
}

Widget buildSheetActionsDemo() {
  print('Building sheet actions demo');
  List<String> actionLabels = ['Save', 'Share', 'Delete', 'Cancel'];
  List<IconData> actionIcons = [
    Icons.save,
    Icons.share,
    Icons.delete,
    Icons.cancel,
  ];
  List<MaterialColor> actionColors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.grey,
  ];

  List<Widget> actionButtons = [];
  int a = 0;
  for (a = 0; a < actionLabels.length; a = a + 1) {
    actionButtons.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Material(
            color: actionColors[a].shade100,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Icon(
                      actionIcons[a],
                      color: actionColors[a].shade700,
                      size: 24,
                    ),
                    SizedBox(height: 4),
                    Text(
                      actionLabels[a],
                      style: TextStyle(
                        fontSize: 12,
                        color: actionColors[a].shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          'Sheet with Action Buttons',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Bottom sheets often include action buttons for user interaction.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choose an Action',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(children: actionButtons),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultipleSheetExamples() {
  print('Building multiple sheet examples');
  List<String> sheetTypes = [
    'Settings Sheet',
    'Filter Sheet',
    'Details Sheet',
    'Form Sheet',
  ];
  List<String> sheetDescs = [
    'Configure app preferences and options',
    'Filter and sort data with multiple criteria',
    'Display detailed information about an item',
    'Collect user input through form fields',
  ];
  List<IconData> sheetIcons = [
    Icons.settings,
    Icons.filter_list,
    Icons.info,
    Icons.edit,
  ];
  List<MaterialColor> sheetColors = [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.pink,
  ];

  List<Widget> examples = [];
  int e = 0;
  for (e = 0; e < sheetTypes.length; e = e + 1) {
    examples.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sheetColors[e].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sheetColors[e].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: sheetColors[e].shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                sheetIcons[e],
                color: sheetColors[e].shade700,
                size: 26,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sheetTypes[e],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: sheetColors[e].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    sheetDescs[e],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: sheetColors[e].shade400),
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
          'Common Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different types of persistent bottom sheets in apps',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: examples),
      ],
    ),
  );
}

Widget buildSheetAnimationInfo() {
  print('Building sheet animation info');
  List<String> animProps = [
    'animationController',
    'Animation Duration',
    'Animation Curve',
    'Entry Animation',
    'Exit Animation',
  ];
  List<String> animValues = [
    'Controls the sheet slide animation',
    'Default: 250 milliseconds',
    'Curves.linear or custom curves',
    'Slides up from bottom of screen',
    'Slides down and fades out',
  ];

  List<Widget> animItems = [];
  int i = 0;
  for (i = 0; i < animProps.length; i = i + 1) {
    Color rowBg = (i % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    animItems.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: rowBg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              child: Text(
                animProps[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                animValues[i],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.animation, color: Colors.indigo.shade700, size: 20),
              SizedBox(width: 8),
              Text(
                'Sheet Animation Properties',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
        Column(children: animItems),
      ],
    ),
  );
}

Widget buildInteractiveDemoSection() {
  print('Building interactive demo section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade600, Colors.purple.shade600],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              'Interactive Demonstration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'In a real app, you would call Scaffold.of(context).showBottomSheet() to display a persistent bottom sheet and receive a PersistentBottomSheetController.',
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(220)),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Steps to use:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              _buildStepItem(
                1,
                'Get ScaffoldState via GlobalKey or Scaffold.of()',
              ),
              _buildStepItem(2, 'Call showBottomSheet() with a builder'),
              _buildStepItem(3, 'Store the returned controller'),
              _buildStepItem(4, 'Use controller.setState() to update content'),
              _buildStepItem(5, 'Call controller.close() when done'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Show Sheet',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withAlpha(80)),
                ),
                child: Center(
                  child: Text(
                    'Close Sheet',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStepItem(int number, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(230)),
          ),
        ),
      ],
    ),
  );
}

Widget buildControllerLifecycleDemo() {
  print('Building controller lifecycle demo');
  List<String> phases = [
    'Creation',
    'Active',
    'Updating',
    'Closing',
    'Disposed',
  ];
  List<String> phaseDescs = [
    'Controller returned from showBottomSheet()',
    'Sheet is visible and interactive',
    'setState() called to update content',
    'close() called, animation starts',
    'Sheet removed, closed Future completes',
  ];
  List<IconData> phaseIcons = [
    Icons.add_circle,
    Icons.play_circle,
    Icons.sync,
    Icons.arrow_circle_down,
    Icons.check_circle,
  ];
  List<MaterialColor> phaseColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.grey,
  ];

  List<Widget> timeline = [];
  int p = 0;
  for (p = 0; p < phases.length; p = p + 1) {
    timeline.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: phaseColors[p].shade100,
                  shape: BoxShape.circle,
                  border: Border.all(color: phaseColors[p], width: 2),
                ),
                child: Icon(phaseIcons[p], color: phaseColors[p], size: 20),
              ),
              if (p < phases.length - 1)
                Container(width: 2, height: 30, color: Colors.grey.shade300),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: phaseColors[p].shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: phaseColors[p].shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phases[p],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: phaseColors[p].shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    phaseDescs[p],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
        Text(
          'Controller Lifecycle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Stages of a PersistentBottomSheetController',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: timeline),
      ],
    ),
  );
}

Widget buildBestPractices() {
  print('Building best practices');
  List<String> tips = [
    'Store controller reference for later use',
    'Use setState() sparingly for performance',
    'Handle closed Future for cleanup',
    'Consider draggable scrollable sheets for complex content',
    'Use constraints for consistent sheet height',
  ];
  List<IconData> tipIcons = [
    Icons.bookmark,
    Icons.speed,
    Icons.cleaning_services,
    Icons.expand,
    Icons.height,
  ];

  List<Widget> tipCards = [];
  int t = 0;
  for (t = 0; t < tips.length; t = t + 1) {
    tipCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(tipIcons[t], color: Colors.green.shade700, size: 18),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                tips[t],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
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
            Icon(Icons.lightbulb, color: Colors.amber.shade600, size: 24),
            SizedBox(width: 8),
            Text(
              'Best Practices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: tipCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PersistentBottomSheetController deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PersistentBottomSheetController Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'PersistentBottomSheetController'),
            buildInfoCard(
              'Purpose',
              'Controls a persistent bottom sheet shown via Scaffold.showBottomSheet()',
            ),
            buildInfoCard('Package', 'package:flutter/material.dart'),
            buildInfoCard(
              'Key Methods',
              'close(), setState(VoidCallback), closed (Future)',
            ),
            buildInfoCard(
              'Behavior',
              'Sheet remains visible while user interacts with main content',
            ),

            buildSectionHeader('2. Basic Persistent Bottom Sheet'),
            buildBasicBottomSheetDemo(),

            buildSectionHeader('3. Controller Methods'),
            buildControllerMethodsDemo(),
            buildCodeSnippet(
              'close() Example',
              'PersistentBottomSheetController controller;\n\n'
                  'void closeSheet() {\n'
                  '  controller.close();\n'
                  '}',
            ),

            buildSectionHeader('4. setState Callback Usage'),
            buildSetStateCallbackDemo(),

            buildSectionHeader('5. Scrollable Content'),
            buildScrollableContentDemo(),

            buildSectionHeader('6. Sheet Styling'),
            buildSheetStylingDemo(),

            buildSectionHeader('7. Sheet with Actions'),
            buildSheetActionsDemo(),

            buildSectionHeader('8. Multiple Sheet Examples'),
            buildMultipleSheetExamples(),

            buildSectionHeader('9. Sheet Animations'),
            buildSheetAnimationInfo(),
            buildControllerLifecycleDemo(),

            buildSectionHeader('10. Interactive Demonstration'),
            buildInteractiveDemoSection(),
            buildBestPractices(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PersistentBottomSheetController deep demo completed');
  return result;
}
