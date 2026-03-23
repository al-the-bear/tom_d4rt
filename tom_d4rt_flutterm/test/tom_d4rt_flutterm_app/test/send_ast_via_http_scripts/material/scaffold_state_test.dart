// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScaffoldState from material - state class providing access to Scaffold features
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

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
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
        color: Colors.greenAccent.shade200,
      ),
    ),
  );
}

Widget buildScaffoldOfUsageSection() {
  print('Building Scaffold.of usage section');
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
          'Using Scaffold.of(context)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Scaffold.of returns the ScaffoldState from the closest Scaffold ancestor in the widget tree.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'ScaffoldState state = Scaffold.of(context);\n'
          'state.openDrawer();\n'
          'state.openEndDrawer();\n'
          'state.showBottomSheet((context) => MySheet());',
        ),
        SizedBox(height: 12),
        _buildUsageNote(
          Icons.warning_amber_rounded,
          'Important',
          'The BuildContext must be from a widget that is a descendant of a Scaffold widget.',
          Colors.orange,
        ),
        SizedBox(height: 8),
        _buildUsageNote(
          Icons.lightbulb_outline,
          'Tip',
          'Use Builder widget to get a context that is below the Scaffold in the widget tree.',
          Colors.teal,
        ),
        SizedBox(height: 12),
        Text(
          'Example with Builder:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildCodeBlock(
          'Scaffold(\n'
          '  body: Builder(\n'
          '    builder: (BuildContext context) {\n'
          '      return ElevatedButton(\n'
          '        onPressed: () {\n'
          '          Scaffold.of(context).openDrawer();\n'
          '        },\n'
          '        child: Text("Open Drawer"),\n'
          '      );\n'
          '    },\n'
          '  ),\n'
          '  drawer: Drawer(...),\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _buildUsageNote(IconData icon, String title, String message, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                message,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMaybeOfSection() {
  print('Building Scaffold.maybeOf section');
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
          'Using Scaffold.maybeOf(context)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Returns null instead of throwing an exception when no Scaffold ancestor is found.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'ScaffoldState? state = Scaffold.maybeOf(context);\n'
          'if (state != null) {\n'
          '  state.openDrawer();\n'
          '} else {\n'
          '  print("No Scaffold found");\n'
          '}',
        ),
        SizedBox(height: 12),
        _buildComparisonTable(),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  List<List<String>> rows = [
    ['Method', 'Null Return', 'Throws Exception'],
    ['Scaffold.of', 'No', 'Yes (if not found)'],
    ['Scaffold.maybeOf', 'Yes', 'No'],
  ];

  List<Widget> tableRows = [];
  int r = 0;
  for (r = 0; r < rows.length; r = r + 1) {
    bool isHeader = r == 0;
    tableRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isHeader ? Colors.indigo.shade100 : Colors.grey.shade50,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                rows[r][0],
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Text(
                rows[r][1],
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                rows[r][2],
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(children: tableRows),
    ),
  );
}

Widget buildGlobalKeyPatternSection() {
  print('Building GlobalKey<ScaffoldState> pattern section');
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
          'GlobalKey<ScaffoldState> Pattern',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'An alternative approach when you need access to ScaffoldState from outside the widget tree.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'class MyPage extends StatefulWidget {\n'
          '  State<MyPage> createState() => _MyPageState();\n'
          '}\n'
          '\n'
          'class _MyPageState extends State<MyPage> {\n'
          '  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();\n'
          '\n'
          '  Widget build(BuildContext context) {\n'
          '    return Scaffold(\n'
          '      key: _scaffoldKey,\n'
          '      drawer: Drawer(...),\n'
          '      body: Container(...),\n'
          '    );\n'
          '  }\n'
          '\n'
          '  void openDrawerProgrammatically() {\n'
          '    _scaffoldKey.currentState?.openDrawer();\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 12),
        _buildKeyAdvantages(),
      ],
    ),
  );
}

Widget _buildKeyAdvantages() {
  List<String> advantages = [
    'Access ScaffoldState from anywhere in the StatefulWidget',
    'No need for Builder widget or context considerations',
    'Can call methods before widget tree builds completely',
    'Works well with callbacks and external events',
    'Useful for state management integration',
  ];

  List<Widget> items = [];
  int a = 0;
  for (a = 0; a < advantages.length; a = a + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${a + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                advantages[a],
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Advantages of GlobalKey Approach:',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Column(children: items),
    ],
  );
}

Widget buildDrawerControlSection() {
  print('Building drawer control section');
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
          'Drawer Control Methods',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildMethodCard(
          'openDrawer()',
          'Opens the left drawer if one is defined in the Scaffold.',
          'scaffoldState.openDrawer();',
          Colors.blue,
          Icons.chevron_right,
        ),
        _buildMethodCard(
          'openEndDrawer()',
          'Opens the right drawer (endDrawer) if one is defined.',
          'scaffoldState.openEndDrawer();',
          Colors.green,
          Icons.chevron_left,
        ),
        _buildMethodCard(
          'closeDrawer()',
          'Closes the currently open drawer.',
          'scaffoldState.closeDrawer();',
          Colors.orange,
          Icons.close,
        ),
        _buildMethodCard(
          'closeEndDrawer()',
          'Closes the currently open end drawer.',
          'scaffoldState.closeEndDrawer();',
          Colors.red,
          Icons.close,
        ),
      ],
    ),
  );
}

Widget _buildMethodCard(
  String methodName,
  String description,
  String code,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            SizedBox(width: 12),
            Text(
              methodName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.greenAccent.shade200,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDrawerStateChecks() {
  print('Building drawer state checks');
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
          'Drawer State Checking',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldState provides properties to check current drawer states.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        _buildStateCheckRow(
          'isDrawerOpen',
          'Returns true if the left drawer is currently open.',
          Colors.blue,
        ),
        _buildStateCheckRow(
          'isEndDrawerOpen',
          'Returns true if the end drawer (right) is currently open.',
          Colors.green,
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'void toggleDrawer() {\n'
          '  ScaffoldState state = Scaffold.of(context);\n'
          '  if (state.isDrawerOpen) {\n'
          '    state.closeDrawer();\n'
          '  } else {\n'
          '    state.openDrawer();\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

Widget _buildStateCheckRow(String property, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            property,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBottomSheetControlSection() {
  print('Building bottom sheet control section');
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
          'Bottom Sheet Control',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldState provides methods to show persistent and modal bottom sheets.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        _buildBottomSheetMethodCard(
          'showBottomSheet',
          'Displays a persistent bottom sheet that stays until explicitly closed.',
          'PersistentBottomSheetController controller =\n'
          '  scaffoldState.showBottomSheet(\n'
          '    (context) => Container(\n'
          '      height: 200,\n'
          '      color: Colors.white,\n'
          '      child: Center(\n'
          '        child: Text("Persistent Sheet"),\n'
          '      ),\n'
          '    ),\n'
          '  );',
          Colors.purple,
        ),
        SizedBox(height: 8),
        _buildBottomSheetNote(
          'Note',
          'showBottomSheet returns a PersistentBottomSheetController which can be used to close the sheet programmatically.',
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget _buildBottomSheetMethodCard(
  String methodName,
  String description,
  String code,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.expand_less, color: color, size: 28),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
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
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.greenAccent.shade200,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomSheetNote(String title, String message, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '$title: $message',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildBottomSheetControllerSection() {
  print('Building bottom sheet controller section');
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
          'PersistentBottomSheetController',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The controller returned by showBottomSheet provides methods and notifications.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'PersistentBottomSheetController controller =\n'
          '  scaffoldState.showBottomSheet(\n'
          '    (context) => MyBottomSheetWidget(),\n'
          '  );\n'
          '\n'
          '// Close the sheet programmatically\n'
          'controller.close();\n'
          '\n'
          '// Listen for when the sheet is closed\n'
          'controller.closed.then((value) {\n'
          '  print("Bottom sheet was closed");\n'
          '});',
        ),
        SizedBox(height: 12),
        _buildControllerProperties(),
      ],
    ),
  );
}

Widget _buildControllerProperties() {
  List<String> propNames = ['close()', 'closed', 'setState()'];
  List<String> propDescs = [
    'Method to close the bottom sheet',
    'Future that completes when sheet is closed',
    'Method to trigger rebuild of sheet content',
  ];
  List<IconData> propIcons = [Icons.close, Icons.check_circle, Icons.refresh];

  List<Widget> items = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(propIcons[p], color: Colors.purple, size: 20),
            SizedBox(width: 10),
            Text(
              propNames[p],
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade700,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Controller Members:',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Column(children: items),
    ],
  );
}

Widget buildHasDrawerPropertiesSection() {
  print('Building hasDrawer/hasEndDrawer properties section');
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
          'hasDrawer / hasEndDrawer Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Check if drawers are defined in the Scaffold before attempting to open them.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        _buildPropertyRow(
          'hasDrawer',
          'Returns true if the Scaffold has a drawer property set.',
          Colors.teal,
          true,
        ),
        _buildPropertyRow(
          'hasEndDrawer',
          'Returns true if the Scaffold has an endDrawer property set.',
          Colors.amber.shade700,
          true,
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'void safeOpenDrawer() {\n'
          '  ScaffoldState state = Scaffold.of(context);\n'
          '  if (state.hasDrawer) {\n'
          '    state.openDrawer();\n'
          '  } else {\n'
          '    print("No drawer available!");\n'
          '  }\n'
          '}\n'
          '\n'
          'void safeOpenEndDrawer() {\n'
          '  ScaffoldState state = Scaffold.of(context);\n'
          '  if (state.hasEndDrawer) {\n'
          '    state.openEndDrawer();\n'
          '  } else {\n'
          '    print("No end drawer available!");\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(
  String property,
  String description,
  Color color,
  bool hasValue,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            hasValue ? Icons.check : Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUseCasesSection() {
  print('Building use cases section');
  List<String> useCases = [
    'Opening drawer from custom navigation buttons',
    'Showing persistent bottom sheet for content details',
    'Toggling drawers based on app state',
    'Programmatically closing drawers on navigation',
    'Integrating with state management solutions',
    'Handling deep links that require drawer actions',
  ];
  List<IconData> useCaseIcons = [
    Icons.menu,
    Icons.expand_less,
    Icons.swap_horiz,
    Icons.close,
    Icons.account_tree,
    Icons.link,
  ];
  List<Color> useCaseColors = [
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.indigo,
  ];

  List<Widget> items = [];
  int u = 0;
  for (u = 0; u < useCases.length; u = u + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: useCaseColors[u].withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: useCaseColors[u].withAlpha(40)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: useCaseColors[u].withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(useCaseIcons[u], color: useCaseColors[u], size: 22),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                useCases[u],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          'Common Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildScaffoldMessengerNote() {
  print('Building ScaffoldMessenger note');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info, color: Colors.amber.shade800, size: 24),
            SizedBox(width: 10),
            Text(
              'Note: SnackBars and ScaffoldMessenger',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'SnackBar functionality has been moved to ScaffoldMessenger. Use ScaffoldMessenger.of(context) instead of Scaffold.of(context) for showing SnackBars.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          '// Old approach (deprecated)\n'
          '// Scaffold.of(context).showSnackBar(...);\n'
          '\n'
          '// New approach\n'
          'ScaffoldMessenger.of(context).showSnackBar(\n'
          '  SnackBar(content: Text("Hello!")),\n'
          ');',
        ),
      ],
    ),
  );
}

Widget buildScaffoldStatePropertiesTable() {
  print('Building ScaffoldState properties table');
  List<String> propNames = [
    'isDrawerOpen',
    'isEndDrawerOpen',
    'hasDrawer',
    'hasEndDrawer',
    'hasAppBar',
    'hasFloatingActionButton',
  ];
  List<String> propTypes = [
    'bool',
    'bool',
    'bool',
    'bool',
    'bool',
    'bool',
  ];
  List<String> propDescs = [
    'True if left drawer is currently open',
    'True if right drawer is currently open',
    'True if Scaffold has drawer defined',
    'True if Scaffold has endDrawer defined',
    'True if Scaffold has appBar defined',
    'True if Scaffold has FAB defined',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Text(
                propTypes[p],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            color: Colors.indigo.shade700,
            child: Text(
              'ScaffoldState Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Column(children: rows),
        ],
      ),
    ),
  );
}

Widget buildScaffoldStateMethodsTable() {
  print('Building ScaffoldState methods table');
  List<String> methNames = [
    'openDrawer()',
    'openEndDrawer()',
    'closeDrawer()',
    'closeEndDrawer()',
    'showBottomSheet()',
    'showBodyScrim()',
  ];
  List<String> methReturns = [
    'void',
    'void',
    'void',
    'void',
    'PersistentBottomSheetController',
    'void',
  ];
  List<String> methDescs = [
    'Opens the left drawer',
    'Opens the right drawer',
    'Closes the left drawer',
    'Closes the right drawer',
    'Shows persistent bottom sheet',
    'Shows/hides scrim over body',
  ];

  List<Widget> rows = [];
  int m = 0;
  for (m = 0; m < methNames.length; m = m + 1) {
    Color bg = (m % 2 == 0) ? Colors.green.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Text(
                methNames[m],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                methReturns[m],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                methDescs[m],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            color: Colors.green.shade700,
            child: Text(
              'ScaffoldState Methods',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Column(children: rows),
        ],
      ),
    ),
  );
}

Widget buildBestPracticesSection() {
  print('Building best practices section');
  List<String> practices = [
    'Always check hasDrawer before calling openDrawer to avoid runtime errors',
    'Use GlobalKey approach when accessing ScaffoldState from outside the build context',
    'Prefer Scaffold.maybeOf for graceful handling when Scaffold might not exist',
    'Use ScaffoldMessenger for SnackBars instead of ScaffoldState',
    'Close drawers explicitly when navigating to prevent UI inconsistencies',
    'Use Builder widget when you need immediate access to ScaffoldState in body',
  ];

  List<Widget> items = [];
  int b = 0;
  for (b = 0; b < practices.length; b = b + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 16),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                practices[b],
                style: TextStyle(fontSize: 13),
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
          'Best Practices',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldState deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ScaffoldState Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'ScaffoldState'),
            buildInfoCard(
              'Purpose',
              'State class that provides access to Scaffold features like drawers and bottom sheets',
            ),
            buildInfoCard('Access Via', 'Scaffold.of(context) or GlobalKey<ScaffoldState>'),
            buildInfoCard(
              'Key Methods',
              'openDrawer, openEndDrawer, closeDrawer, closeEndDrawer, showBottomSheet',
            ),

            buildSectionHeader('2. Scaffold.of Usage'),
            buildScaffoldOfUsageSection(),
            buildMaybeOfSection(),

            buildSectionHeader('3. GlobalKey<ScaffoldState> Pattern'),
            buildGlobalKeyPatternSection(),

            buildSectionHeader('4. Drawer Control'),
            buildDrawerControlSection(),
            buildDrawerStateChecks(),

            buildSectionHeader('5. Bottom Sheet Control'),
            buildBottomSheetControlSection(),
            buildBottomSheetControllerSection(),

            buildSectionHeader('6. hasDrawer & hasEndDrawer'),
            buildHasDrawerPropertiesSection(),

            buildSectionHeader('7. Common Use Cases'),
            buildUseCasesSection(),

            buildSectionHeader('8. ScaffoldMessenger Note'),
            buildScaffoldMessengerNote(),

            buildSectionHeader('9. Properties Reference'),
            buildScaffoldStatePropertiesTable(),

            buildSectionHeader('10. Methods Reference'),
            buildScaffoldStateMethodsTable(),

            buildSectionHeader('11. Best Practices'),
            buildBestPracticesSection(),

            buildSectionHeader('12. Summary'),
            buildInfoCard(
              'Tip 1',
              'ScaffoldState is the gateway to programmatic Scaffold control',
            ),
            buildInfoCard(
              'Tip 2',
              'Use Scaffold.of or GlobalKey pattern based on your context needs',
            ),
            buildInfoCard(
              'Tip 3',
              'Check hasDrawer/hasEndDrawer before opening drawers',
            ),
            buildInfoCard(
              'Tip 4',
              'showBottomSheet returns a controller for programmatic control',
            ),
            buildInfoCard(
              'Tip 5',
              'Use ScaffoldMessenger for SnackBars, not ScaffoldState',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('ScaffoldState deep demo completed');
  return result;
}
