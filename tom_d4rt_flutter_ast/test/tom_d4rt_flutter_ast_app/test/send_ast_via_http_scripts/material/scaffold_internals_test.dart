// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScaffoldState from material
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

Widget buildScaffoldStateClassInfo() {
  print('Building ScaffoldState class info');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade300, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.dashboard_customize, color: Colors.teal.shade700, size: 32),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ScaffoldState',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'State class for Scaffold widget',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Extends', 'State<Scaffold>'),
        buildInfoCard('Package', 'package:flutter/material.dart'),
        buildInfoCard('Purpose', 'Manages Scaffold lifecycle and drawer/sheet interactions'),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Features',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.menu_open, color: Colors.teal.shade600, size: 18),
                  SizedBox(width: 8),
                  Text('Drawer and EndDrawer control', style: TextStyle(fontSize: 13)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.view_agenda, color: Colors.teal.shade600, size: 18),
                  SizedBox(width: 8),
                  Text('BottomSheet management', style: TextStyle(fontSize: 13)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.notifications_active, color: Colors.teal.shade600, size: 18),
                  SizedBox(width: 8),
                  Text('SnackBar display (via ScaffoldMessenger)', style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFullyPopulatedScaffold() {
  print('Building fully populated scaffold visualization');
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
          'Scaffold with All Slots Populated',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 420,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade400, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Drawer indicator (left)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                width: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                    border: Border(
                      right: BorderSide(color: Colors.orange.shade300, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chevron_right, color: Colors.orange.shade700, size: 24),
                      SizedBox(height: 4),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'drawer',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // EndDrawer indicator (right)
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    border: Border(
                      left: BorderSide(color: Colors.purple.shade300, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chevron_left, color: Colors.purple.shade700, size: 24),
                      SizedBox(height: 4),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          'endDrawer',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Main content area
              Positioned(
                top: 0,
                bottom: 0,
                left: 60,
                right: 60,
                child: Column(
                  children: [
                    // AppBar area
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Icon(Icons.menu, color: Colors.white, size: 22),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'appBar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: Colors.white, size: 22),
                          SizedBox(width: 8),
                          Icon(Icons.more_horiz, color: Colors.white, size: 22),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                    // Body area
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.web_asset, size: 48, color: Colors.grey.shade400),
                              SizedBox(height: 8),
                              Text(
                                'body',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Main content area',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Persistent footer buttons
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        border: Border(
                          top: BorderSide(color: Colors.blue.shade200),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, color: Colors.blue.shade600, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'persistentFooterButtons',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // BottomNavigationBar area
                    Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.home, color: Colors.teal, size: 22),
                              Text('Home', style: TextStyle(fontSize: 10, color: Colors.teal)),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.explore, color: Colors.grey.shade600, size: 22),
                              Text('Explore', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person, color: Colors.grey.shade600, size: 22),
                              Text('Profile', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // FAB indicator
              Positioned(
                right: 76,
                bottom: 80,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withAlpha(100),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 20),
                      Text(
                        'FAB',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSlotChip('appBar', Colors.teal),
            _buildSlotChip('body', Colors.grey),
            _buildSlotChip('drawer', Colors.orange),
            _buildSlotChip('endDrawer', Colors.purple),
            _buildSlotChip('floatingActionButton', Colors.pink),
            _buildSlotChip('bottomNavigationBar', Colors.blueGrey),
            _buildSlotChip('persistentFooterButtons', Colors.blue),
            _buildSlotChip('bottomSheet', Colors.indigo),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSlotChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget buildMethodsVisualization() {
  print('Building methods visualization');
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
            Icon(Icons.code, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'ScaffoldState Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildMethodCard(
          'openDrawer()',
          'Opens the drawer if one is present',
          Icons.menu_open,
          Colors.orange,
          'void openDrawer()',
          'Opens the Drawer (if any). This method checks if a drawer exists before attempting to open.',
        ),
        SizedBox(height: 12),
        _buildMethodCard(
          'openEndDrawer()',
          'Opens the end drawer if one is present',
          Icons.menu,
          Colors.purple,
          'void openEndDrawer()',
          'Opens the EndDrawer (if any). Typically revealed by swiping from right edge.',
        ),
        SizedBox(height: 12),
        _buildMethodCard(
          'showBottomSheet()',
          'Shows a material design bottom sheet',
          Icons.view_agenda,
          Colors.indigo,
          'PersistentBottomSheetController showBottomSheet(...)',
          'Displays a persistent bottom sheet anchored to the scaffold. Returns controller.',
        ),
        SizedBox(height: 12),
        _buildMethodCard(
          'closeDrawer()',
          'Closes the drawer if it is open',
          Icons.close,
          Colors.orange.shade700,
          'void closeDrawer()',
          'Closes the Drawer if currently open. Safe to call when drawer is already closed.',
        ),
        SizedBox(height: 12),
        _buildMethodCard(
          'closeEndDrawer()',
          'Closes the end drawer if it is open',
          Icons.close,
          Colors.purple.shade700,
          'void closeEndDrawer()',
          'Closes the EndDrawer if currently open. Safe to call when drawer is already closed.',
        ),
      ],
    ),
  );
}

Widget _buildMethodCard(
  String name,
  String brief,
  IconData icon,
  Color color,
  String signature,
  String description,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    brief,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildDrawerStates() {
  print('Building drawer states visualization');
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
            Icon(Icons.toggle_on, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Drawer State Properties',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildStateCard(
          'isDrawerOpen',
          'bool',
          'Whether the Scaffold drawer is currently open',
          Colors.orange,
          [
            _buildStateRow('Drawer closed', false, Colors.grey),
            _buildStateRow('Drawer open', true, Colors.orange),
          ],
        ),
        SizedBox(height: 12),
        _buildStateCard(
          'isEndDrawerOpen',
          'bool',
          'Whether the Scaffold end drawer is currently open',
          Colors.purple,
          [
            _buildStateRow('EndDrawer closed', false, Colors.grey),
            _buildStateRow('EndDrawer open', true, Colors.purple),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade800, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'State Access Pattern',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Use Scaffold.of(context) to get ScaffoldState, then check isDrawerOpen or isEndDrawerOpen.',
                      style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
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

Widget _buildStateCard(
  String property,
  String type,
  String description,
  Color color,
  List<Widget> stateRows,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                property,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stateRows),
      ],
    ),
  );
}

Widget _buildStateRow(String label, bool value, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.grey,
          size: 18,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: value ? Colors.green.shade700 : Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

Widget buildBodyAreaVisualization() {
  print('Building body area visualization');
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
            Icon(Icons.web_asset, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Body Area Configuration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildBodyConfigRow('extendBody', 'Body extends behind appBar', Icons.expand, Colors.blue),
        SizedBox(height: 8),
        _buildBodyConfigRow('extendBodyBehindAppBar', 'Body extends behind appBar and status bar', Icons.vertical_align_top, Colors.green),
        SizedBox(height: 8),
        _buildBodyConfigRow('resizeToAvoidBottomInset', 'Body resizes when keyboard shows', Icons.keyboard, Colors.orange),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // StatusBar area
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 24,
                child: Container(
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Text(
                      'Status Bar Area',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ),
                ),
              ),
              // AppBar area
              Positioned(
                top: 24,
                left: 0,
                right: 0,
                height: 44,
                child: Container(
                  color: Colors.teal,
                  child: Center(
                    child: Text(
                      'AppBar Area',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Body area - normal
              Positioned(
                top: 68,
                bottom: 56,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue.shade200, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Body Content',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Normal positioning',
                          style: TextStyle(fontSize: 11, color: Colors.blue.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // BottomNav area
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 56,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home, color: Colors.teal, size: 20),
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      Icon(Icons.person, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Primary Scrollable', 'Scaffold body automatically gets PrimaryScrollController'),
        buildInfoCard('SafeArea Integration', 'Body respects system UI overlays by default'),
      ],
    ),
  );
}

Widget _buildBodyConfigRow(String property, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAppBarAreaVisualization() {
  print('Building appBar area visualization');
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
            Icon(Icons.web_asset_outlined, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'AppBar Area Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                height: 24,
                color: Colors.teal.shade800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 12),
                    SizedBox(width: 8),
                    Text(
                      'System Status Bar',
                      style: TextStyle(fontSize: 10, color: Colors.white70),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.battery_full, color: Colors.white, size: 12),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.menu, color: Colors.white, size: 22),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AppBar Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Subtitle text',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: 22),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.more_vert, color: Colors.white, size: 22),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildAppBarSection('leading', 'Widget shown before title (usually menu icon or back arrow)', Colors.orange),
        SizedBox(height: 8),
        _buildAppBarSection('title', 'Primary content of the app bar (typically Text widget)', Colors.blue),
        SizedBox(height: 8),
        _buildAppBarSection('actions', 'List of widgets shown after the title (toolbar buttons)', Colors.green),
        SizedBox(height: 8),
        _buildAppBarSection('bottom', 'Widget shown below the app bar (e.g., TabBar)', Colors.purple),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AppBar Interaction with ScaffoldState',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.teal.shade600, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AppBar leading widget can trigger Scaffold.of(context).openDrawer()',
                      style: TextStyle(fontSize: 12, color: Colors.teal.shade700),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.teal.shade600, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'automaticallyImplyLeading defaults to showing drawer icon when drawer exists',
                      style: TextStyle(fontSize: 12, color: Colors.teal.shade700),
                    ),
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

Widget _buildAppBarSection(String name, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
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
                  color: color,
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

Widget buildBottomSheetVisualization() {
  print('Building bottomSheet visualization');
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
            Icon(Icons.view_agenda_outlined, color: Colors.indigo.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'BottomSheet via ScaffoldState',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Background scaffold
              Positioned.fill(
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      color: Colors.indigo,
                      child: Center(
                        child: Text(
                          'AppBar',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: Text(
                            'Scaffold Body',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom sheet overlay
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(40),
                        blurRadius: 12,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Persistent BottomSheet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Shown via ScaffoldState.showBottomSheet()',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Action Button',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildBottomSheetTypeCard(
          'Persistent BottomSheet',
          'Uses ScaffoldState.showBottomSheet()',
          'Remains visible while user interacts with other parts of app. Returns PersistentBottomSheetController.',
          Colors.indigo,
        ),
        SizedBox(height: 8),
        _buildBottomSheetTypeCard(
          'Modal BottomSheet',
          'Uses showModalBottomSheet()',
          'Shows as modal dialog. Does not use ScaffoldState directly. Blocks interaction with content below.',
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget _buildBottomSheetTypeCard(String title, String method, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_quilt, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            method,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.grey.shade700,
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

Widget buildScaffoldAccessPatterns() {
  print('Building scaffold access patterns');
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
            Icon(Icons.account_tree, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Accessing ScaffoldState',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildAccessPatternCard(
          'Scaffold.of(context)',
          'Returns the ScaffoldState from the closest Scaffold ancestor',
          'ScaffoldState state = Scaffold.of(context);',
          Colors.blue,
          'Throws error if no Scaffold ancestor found',
        ),
        SizedBox(height: 12),
        _buildAccessPatternCard(
          'Scaffold.maybeOf(context)',
          'Returns the ScaffoldState or null if not found',
          'ScaffoldState? state = Scaffold.maybeOf(context);',
          Colors.green,
          'Safe alternative that returns null instead of throwing',
        ),
        SizedBox(height: 12),
        _buildAccessPatternCard(
          'GlobalKey<ScaffoldState>',
          'Direct access via GlobalKey when you have reference',
          'final key = GlobalKey<ScaffoldState>();\nkey.currentState?.openDrawer();',
          Colors.orange,
          'Useful when context is not available or from outside widget tree',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.red.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Common Mistake',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Calling Scaffold.of(context) with context from same build method that creates Scaffold will fail. Use Builder widget or pass context from descendant.',
                      style: TextStyle(fontSize: 12, color: Colors.red.shade700),
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

Widget _buildAccessPatternCard(
  String title,
  String description,
  String code,
  Color color,
  String note,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.info_outline, color: color, size: 14),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                note,
                style: TextStyle(fontSize: 11, color: color, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldState deep demo executing');
  print('Class: ScaffoldState');
  print('Package: material');
  print('Description: State class for Scaffold widget that manages drawers and bottom sheets');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildScaffoldStateClassInfo(),
        buildSectionHeader('1. Scaffold with All Slots Populated'),
        buildFullyPopulatedScaffold(),
        buildSectionHeader('2. ScaffoldState Methods'),
        buildMethodsVisualization(),
        buildSectionHeader('3. Drawer State Properties'),
        buildDrawerStates(),
        buildSectionHeader('4. Body Area Configuration'),
        buildBodyAreaVisualization(),
        buildSectionHeader('5. AppBar Area Details'),
        buildAppBarAreaVisualization(),
        buildSectionHeader('6. BottomSheet via ScaffoldState'),
        buildBottomSheetVisualization(),
        buildSectionHeader('7. Accessing ScaffoldState'),
        buildScaffoldAccessPatterns(),
        SizedBox(height: 24),
        Center(
          child: Text(
            'ScaffoldState Deep Demo Complete',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
