// ignore_for_file: avoid_print
// D4rt test script: Tests ScaffoldFeatureController from material
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
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
              Icon(Icons.code, color: Colors.teal.shade300, size: 18),
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

Widget buildVisualScaffoldDemo() {
  print('Building visual scaffold layout demo');
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
          'Scaffold Feature Control Areas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldFeatureController manages features that overlay on the Scaffold body',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.menu, color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Text(
                        'AppBar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 44,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.grey.shade100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.layers, color: Colors.grey.shade400, size: 32),
                        SizedBox(height: 8),
                        Text(
                          'Body Content',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '(Features overlay here)',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                left: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white, size: 18),
                      SizedBox(width: 12),
                      Text(
                        'SnackBar Area',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'DISMISS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 8,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bottom Sheet Area',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 68,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade400,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withAlpha(80),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 6),
            Text('SnackBar', style: TextStyle(fontSize: 11)),
            SizedBox(width: 16),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey.shade400),
              ),
            ),
            SizedBox(width: 6),
            Text('Bottom Sheet', style: TextStyle(fontSize: 11)),
            SizedBox(width: 16),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(width: 6),
            Text('FAB', style: TextStyle(fontSize: 11)),
          ],
        ),
      ],
    ),
  );
}

Widget buildBottomSheetAreasDemo() {
  print('Building bottom sheet areas demo');
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
          'Bottom Sheet Control Areas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldFeatureController manages persistent and modal bottom sheets',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Persistent',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 28,
                      left: 8,
                      right: 8,
                      bottom: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'Body',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Stays visible',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Modal',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 28,
                      left: 8,
                      right: 8,
                      bottom: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300.withAlpha(100),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Body',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '(obscured)',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(40),
                              blurRadius: 6,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Blocks interaction',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.purple.shade700,
                              ),
                            ),
                          ],
                        ),
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
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Both types return ScaffoldFeatureController for programmatic control',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSnackbarAreasDemo() {
  print('Building snackbar areas demo');
  
  List<Map<String, dynamic>> snackbarTypes = [
    {
      'name': 'Fixed',
      'desc': 'Anchored at bottom',
      'color': Colors.grey.shade800,
      'behavior': 'SnackBarBehavior.fixed',
    },
    {
      'name': 'Floating',
      'desc': 'Elevation above FAB',
      'color': Colors.teal.shade600,
      'behavior': 'SnackBarBehavior.floating',
    },
  ];
  
  List<Widget> snackbarWidgets = [];
  int i = 0;
  for (i = 0; i < snackbarTypes.length; i = i + 1) {
    Map<String, dynamic> info = snackbarTypes[i];
    snackbarWidgets.add(
      Expanded(
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    info['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: (info['color'] as Color),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: i == 1 ? 16 : 0,
                left: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: info['color'] as Color,
                    borderRadius: i == 1 
                        ? BorderRadius.circular(6) 
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          info['desc'] as String,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Text(
                        'ACTION',
                        style: TextStyle(
                          color: Colors.amber.shade300,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (i == 1)
                Positioned(
                  right: 12,
                  bottom: 56,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    if (i < snackbarTypes.length - 1) {
      snackbarWidgets.add(SizedBox(width: 12));
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
          'SnackBar Control Areas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldFeatureController provides close() to dismiss SnackBars',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(children: snackbarWidgets),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SnackBar Positioning',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.arrow_downward, size: 14, color: Colors.grey.shade600),
                  SizedBox(width: 6),
                  Text(
                    'Fixed: Full width, no margin',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.open_with, size: 14, color: Colors.grey.shade600),
                  SizedBox(width: 6),
                  Text(
                    'Floating: Margin around, clears FAB',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFeatureControllerConceptDemo() {
  print('Building feature controller concept demo');
  
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
          'ScaffoldFeatureController<T, U> Type Definition',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Generic controller for scaffold-managed features',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Type Parameters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.indigo.shade700,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                          fontFamily: 'monospace',
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
                          'Widget Type',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          'The widget being controlled (SnackBar, BottomSheet)',
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
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'U',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                          fontFamily: 'monospace',
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
                          'Reason Type',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          'Closure reason (SnackBarClosedReason, etc)',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Common Specializations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        buildTypeSpecializationRow(
          'ScaffoldFeatureController<SnackBar, SnackBarClosedReason>',
          'For SnackBars',
          Colors.grey.shade700,
        ),
        SizedBox(height: 6),
        buildTypeSpecializationRow(
          'ScaffoldFeatureController<PersistentBottomSheetController, void>',
          'For persistent bottom sheets',
          Colors.blue.shade600,
        ),
        SizedBox(height: 6),
        buildTypeSpecializationRow(
          'ScaffoldFeatureController<BottomSheet, void>',
          'For modal bottom sheets',
          Colors.purple.shade600,
        ),
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
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Type-safe closure handling via closed Future<U>',
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

Widget buildTypeSpecializationRow(String type, String desc, Color dotColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade800,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildControllerLifecycleDemo() {
  print('Building controller lifecycle demo');
  
  List<Map<String, dynamic>> lifecycleSteps = [
    {
      'step': '1',
      'title': 'Creation',
      'desc': 'Scaffold creates controller when feature is shown',
      'icon': Icons.play_circle_outline,
      'color': Colors.green,
    },
    {
      'step': '2',
      'title': 'Active',
      'desc': 'Controller manages feature visibility and state',
      'icon': Icons.settings,
      'color': Colors.blue,
    },
    {
      'step': '3',
      'title': 'setState()',
      'desc': 'Optional: Update feature without recreating',
      'icon': Icons.refresh,
      'color': Colors.orange,
    },
    {
      'step': '4',
      'title': 'close()',
      'desc': 'Programmatically dismiss the feature',
      'icon': Icons.close,
      'color': Colors.red,
    },
    {
      'step': '5',
      'title': 'closed Future',
      'desc': 'Completes with reason when feature is dismissed',
      'icon': Icons.check_circle_outline,
      'color': Colors.purple,
    },
  ];
  
  List<Widget> stepWidgets = [];
  int i = 0;
  for (i = 0; i < lifecycleSteps.length; i = i + 1) {
    Map<String, dynamic> step = lifecycleSteps[i];
    MaterialColor stepColor = step['color'] as MaterialColor;
    
    stepWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: stepColor.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: stepColor.shade300),
              ),
              child: Center(
                child: Text(
                  step['step'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: stepColor.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: stepColor.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                step['icon'] as IconData,
                color: stepColor.shade600,
                size: 20,
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
                      fontSize: 13,
                      color: stepColor.shade700,
                    ),
                  ),
                  Text(
                    step['desc'] as String,
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
    );
    
    if (i < lifecycleSteps.length - 1) {
      stepWidgets.add(
        Padding(
          padding: EdgeInsets.only(left: 18),
          child: Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
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
          'Controller Lifecycle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'From creation to dismissal, the controller manages the entire feature lifecycle',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget buildControllerMethodsDemo() {
  print('Building controller methods demo');
  
  List<Map<String, dynamic>> methods = [
    {
      'name': 'close()',
      'returns': 'void',
      'desc': 'Dismisses the feature and triggers the closed Future',
      'icon': Icons.cancel_outlined,
      'color': Colors.red,
    },
    {
      'name': 'setState(VoidCallback)',
      'returns': 'void',
      'desc': 'Rebuilds the feature widget with new state',
      'icon': Icons.autorenew,
      'color': Colors.blue,
    },
    {
      'name': 'closed',
      'returns': 'Future<U>',
      'desc': 'Completes when feature is dismissed, with closure reason',
      'icon': Icons.hourglass_bottom,
      'color': Colors.green,
    },
  ];
  
  List<Widget> methodWidgets = [];
  int i = 0;
  for (i = 0; i < methods.length; i = i + 1) {
    Map<String, dynamic> method = methods[i];
    MaterialColor methodColor = method['color'] as MaterialColor;
    
    methodWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: methodColor.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: methodColor.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: methodColor.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                method['icon'] as IconData,
                color: methodColor.shade600,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: methodColor.shade800,
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
                          method['returns'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    method['desc'] as String,
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
          'Controller Methods & Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Available operations on ScaffoldFeatureController',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: methodWidgets),
      ],
    ),
  );
}

Widget buildUsageExamplesDemo() {
  print('Building usage examples demo');
  
  String snackbarExample = '''ScaffoldMessenger.of(context)
  .showSnackBar(SnackBar(
    content: Text('Message'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {},
    ),
  ));''';
  
  String bottomSheetExample = '''Scaffold.of(context)
  .showBottomSheet((ctx) => Container(
    height: 200,
    child: Center(
      child: Text('Bottom Sheet'),
    ),
  ));''';
  
  String closeExample = '''final controller = ScaffoldMessenger
  .of(context).showSnackBar(...);

// Later, to dismiss:
controller.close();''';
  
  String closedFutureExample = '''controller.closed.then((reason) {
  if (reason == SnackBarClosedReason
        .action) {
    // Handle action tap
  }
});''';
  
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
          'Usage Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Common patterns for working with ScaffoldFeatureController',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        buildCodeSnippet('Show SnackBar', snackbarExample),
        buildCodeSnippet('Show Bottom Sheet', bottomSheetExample),
        buildCodeSnippet('Close Feature', closeExample),
        buildCodeSnippet('Handle Closure Reason', closedFutureExample),
      ],
    ),
  );
}

Widget buildClosedReasonDemo() {
  print('Building closed reason demo');
  
  List<Map<String, dynamic>> reasons = [
    {'name': 'action', 'desc': 'User tapped the action button', 'icon': Icons.touch_app},
    {'name': 'dismiss', 'desc': 'User dismissed via swipe', 'icon': Icons.swipe},
    {'name': 'swipe', 'desc': 'User swiped to dismiss', 'icon': Icons.gesture},
    {'name': 'hide', 'desc': 'Hidden by ScaffoldMessenger', 'icon': Icons.visibility_off},
    {'name': 'remove', 'desc': 'Removed by caller', 'icon': Icons.delete_outline},
    {'name': 'timeout', 'desc': 'Duration expired', 'icon': Icons.timer_off},
  ];
  
  List<Widget> reasonWidgets = [];
  int i = 0;
  for (i = 0; i < reasons.length; i = i + 1) {
    Map<String, dynamic> reason = reasons[i];
    reasonWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(reason['icon'] as IconData, size: 16, color: Colors.grey.shade600),
            SizedBox(width: 10),
            Text(
              reason['name'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                reason['desc'] as String,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
          'SnackBarClosedReason Values',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Possible values returned by the closed Future for SnackBars',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: reasonWidgets),
      ],
    ),
  );
}

Widget buildInteractionDiagramDemo() {
  print('Building interaction diagram demo');
  
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
          'Component Interaction',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'How ScaffoldFeatureController fits in the architecture',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildComponentBox('User Code', Colors.blue, Icons.code),
                ],
              ),
              SizedBox(height: 8),
              Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildComponentBox('ScaffoldMessenger', Colors.teal, Icons.message),
                ],
              ),
              SizedBox(height: 8),
              Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildComponentBox('ScaffoldFeatureController', Colors.orange, Icons.settings_remote),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.subdirectory_arrow_right, color: Colors.grey.shade400, size: 16),
                  SizedBox(width: 4),
                  _buildComponentBox('SnackBar', Colors.grey, Icons.notifications, small: true),
                  SizedBox(width: 12),
                  Icon(Icons.subdirectory_arrow_right, color: Colors.grey.shade400, size: 16),
                  SizedBox(width: 4),
                  _buildComponentBox('BottomSheet', Colors.indigo, Icons.view_agenda, small: true),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComponentBox(String name, MaterialColor color, IconData icon, {bool small = false}) {
  double size = small ? 80.0 : 120.0;
  double iconSize = small ? 18.0 : 24.0;
  double fontSize = small ? 9.0 : 11.0;
  double padding = small ? 6.0 : 10.0;
  
  return Container(
    width: size,
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color.shade700, size: iconSize),
        SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildBestPracticesDemo() {
  print('Building best practices demo');
  
  List<Map<String, dynamic>> practices = [
    {
      'title': 'Store controller reference',
      'desc': 'Keep the returned controller if you need to close programmatically',
      'good': true,
    },
    {
      'title': 'Handle closed Future',
      'desc': 'Use the Future to respond to user actions or cleanup',
      'good': true,
    },
    {
      'title': 'Use ScaffoldMessenger',
      'desc': 'Prefer ScaffoldMessenger over Scaffold.of for SnackBars',
      'good': true,
    },
    {
      'title': 'Avoid calling after dispose',
      'desc': 'Don\'t call close() after widget is disposed',
      'good': false,
    },
  ];
  
  List<Widget> practiceWidgets = [];
  int i = 0;
  for (i = 0; i < practices.length; i = i + 1) {
    Map<String, dynamic> practice = practices[i];
    bool isGood = practice['good'] as bool;
    
    practiceWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isGood ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isGood ? Colors.green.shade200 : Colors.red.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isGood ? Icons.check_circle : Icons.warning,
              color: isGood ? Colors.green.shade600 : Colors.red.shade600,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    practice['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isGood ? Colors.green.shade800 : Colors.red.shade800,
                    ),
                  ),
                  Text(
                    practice['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: isGood ? Colors.green.shade700 : Colors.red.shade700,
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
          'Best Practices',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Recommendations for working with ScaffoldFeatureController',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: practiceWidgets),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldFeatureController deep demo executing');
  print('Testing scaffold feature controller concepts');
  print('Sections: Visual scaffold, bottom sheets, snackbars, type definitions, lifecycle');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade600, Colors.teal.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.settings_remote, color: Colors.white, size: 36),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ScaffoldFeatureController',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Controller for Scaffold features like bottom sheets and snackbars',
                      style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        buildSectionHeader('Visual Scaffold Layout'),
        buildInfoCard('Purpose', 'Manages overlay features on the Scaffold widget'),
        buildInfoCard('Features Controlled', 'SnackBars, persistent bottom sheets, modal bottom sheets'),
        buildInfoCard('Type', 'Generic class ScaffoldFeatureController<T, U>'),
        buildVisualScaffoldDemo(),
        
        buildSectionHeader('Bottom Sheet Areas'),
        buildBottomSheetAreasDemo(),
        buildCodeSnippet(
          'Persistent Bottom Sheet',
          'final controller = Scaffold.of(context).showBottomSheet(\n'
          '  (ctx) => Container(\n'
          '    height: 200,\n'
          '    child: Text(\'Content\'),\n'
          '  ),\n'
          ');',
        ),
        
        buildSectionHeader('SnackBar Areas'),
        buildSnackbarAreasDemo(),
        buildClosedReasonDemo(),
        
        buildSectionHeader('Feature Controller Concept'),
        buildFeatureControllerConceptDemo(),
        buildControllerMethodsDemo(),
        
        buildSectionHeader('Controller Lifecycle'),
        buildControllerLifecycleDemo(),
        buildInteractionDiagramDemo(),
        
        buildSectionHeader('Usage & Best Practices'),
        buildUsageExamplesDemo(),
        buildBestPracticesDemo(),
        
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
              Icon(Icons.info_outline, color: Colors.teal.shade700, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ScaffoldFeatureController is the unified interface for controlling any '
                  'Scaffold-managed overlay feature, providing close() and closed Future.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24),
      ],
    ),
  );
}
