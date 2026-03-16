// D4rt test script: Tests Scrollbar, RefreshIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scrollbar/RefreshIndicator test executing');

  // ========== SCROLLBAR ==========
  print('--- Scrollbar Tests ---');

  // Test basic Scrollbar
  final scrollBasic = Scrollbar(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.red,
            child: Center(
              child: Text('Item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.blue,
            child: Center(
              child: Text('Item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.green,
            child: Center(
              child: Text('Item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            child: Center(
              child: Text('Item 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.purple,
            child: Center(
              child: Text('Item 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar basic created');

  // Test Scrollbar with thumbVisibility=true
  final scrollThumbVisible = Scrollbar(
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Always visible 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(
                'Always visible 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text(
                'Always visible 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.teal,
            child: Center(
              child: Text(
                'Always visible 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.orange,
            child: Center(
              child: Text(
                'Always visible 5',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.purple,
            child: Center(
              child: Text(
                'Always visible 6',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with thumbVisibility=true created');

  // Test Scrollbar with thickness
  final scrollThick = Scrollbar(
    thickness: 12.0,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.indigo,
            child: Center(
              child: Text('Thick 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.amber,
            child: Center(
              child: Text('Thick 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.cyan,
            child: Center(
              child: Text('Thick 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.brown,
            child: Center(
              child: Text('Thick 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.pink,
            child: Center(
              child: Text('Thick 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with thickness=12 created');

  // Test Scrollbar with radius
  final scrollRadius = Scrollbar(
    radius: Radius.circular(10.0),
    thumbVisibility: true,
    thickness: 8.0,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.deepOrange,
            child: Center(
              child: Text('Radius 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.deepPurple,
            child: Center(
              child: Text('Radius 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text('Radius 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lightGreen,
            child: Center(
              child: Text('Radius 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lime,
            child: Center(
              child: Text('Radius 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with radius=10 created');

  // Test Scrollbar with interactive=true
  final scrollInteractive = Scrollbar(
    interactive: true,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.red,
            child: Center(
              child: Text(
                'Interactive 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Interactive 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.green,
            child: Center(
              child: Text(
                'Interactive 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            child: Center(
              child: Text(
                'Interactive 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.purple,
            child: Center(
              child: Text(
                'Interactive 5',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with interactive=true created');

  // ========== REFRESHINDICATOR ==========
  print('--- RefreshIndicator Tests ---');

  // Test basic RefreshIndicator
  final refreshBasic = RefreshIndicator(
    onRefresh: () {
      print('Refreshing...');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh 1')),
        ListTile(title: Text('Pull to refresh 2')),
        ListTile(title: Text('Pull to refresh 3')),
        ListTile(title: Text('Pull to refresh 4')),
      ],
    ),
  );
  print('RefreshIndicator basic created');

  // Test RefreshIndicator with color
  final refreshColored = RefreshIndicator(
    color: Colors.red,
    onRefresh: () {
      print('Red refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 1'),
        ),
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 2'),
        ),
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 3'),
        ),
      ],
    ),
  );
  print('RefreshIndicator with color=red created');

  // Test RefreshIndicator with backgroundColor
  final refreshBg = RefreshIndicator(
    backgroundColor: Colors.black,
    color: Colors.white,
    onRefresh: () {
      print('Dark refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Dark bg 1')),
        ListTile(title: Text('Dark bg 2')),
        ListTile(title: Text('Dark bg 3')),
      ],
    ),
  );
  print('RefreshIndicator with backgroundColor=black created');

  // Test RefreshIndicator with displacement
  final refreshDisplaced = RefreshIndicator(
    displacement: 60.0,
    onRefresh: () {
      print('Displaced refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Displacement 60 - item 1')),
        ListTile(title: Text('Displacement 60 - item 2')),
        ListTile(title: Text('Displacement 60 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with displacement=60 created');

  // Test RefreshIndicator with strokeWidth
  final refreshStroke = RefreshIndicator(
    strokeWidth: 4.0,
    color: Colors.green,
    onRefresh: () {
      print('Thick stroke refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Stroke width 4 - item 1')),
        ListTile(title: Text('Stroke width 4 - item 2')),
        ListTile(title: Text('Stroke width 4 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with strokeWidth=4 created');

  // Test RefreshIndicator with edgeOffset
  final refreshEdge = RefreshIndicator(
    edgeOffset: 50.0,
    onRefresh: () {
      print('Edge offset refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Edge offset 50 - item 1')),
        ListTile(title: Text('Edge offset 50 - item 2')),
        ListTile(title: Text('Edge offset 50 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with edgeOffset=50 created');

  print('All Scrollbar/RefreshIndicator tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Scrollbar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollBasic),
        SizedBox(height: 8.0),
        Text(
          'Thumb always visible:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 180.0, child: scrollThumbVisible),
        SizedBox(height: 8.0),
        Text('Thickness=12:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollThick),
        SizedBox(height: 8.0),
        Text('Radius=10:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollRadius),
        SizedBox(height: 8.0),
        Text('Interactive:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollInteractive),
        SizedBox(height: 16.0),
        Text(
          '=== RefreshIndicator Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: refreshBasic),
        SizedBox(height: 8.0),
        Text('Color=red:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshColored),
        SizedBox(height: 8.0),
        Text('Dark background:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshBg),
        SizedBox(height: 8.0),
        Text('Displacement=60:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshDisplaced),
        SizedBox(height: 8.0),
        Text('Stroke width=4:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshStroke),
        SizedBox(height: 8.0),
        Text('Edge offset=50:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshEdge),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Scrollbar adds scrollbar indicator to scrollable widgets'),
        Text('• thumbVisibility=true keeps scrollbar always visible'),
        Text('• thickness controls scrollbar width'),
        Text('• radius rounds scrollbar thumb corners'),
        Text('• RefreshIndicator adds pull-to-refresh to scrollable lists'),
        Text('• displacement controls how far indicator drops'),
      ],
    ),
  );
}
