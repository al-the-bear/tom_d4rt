// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AppBar widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppBar test executing');

  // Test basic AppBar with title
  final basicAppBar = AppBar(title: Text('Basic AppBar'));
  print('Basic AppBar with title created');

  // Test AppBar with leading widget
  final withLeading = AppBar(
    leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    title: Text('With Leading'),
  );
  print('AppBar with leading IconButton created');

  // Test AppBar with actions
  final withActions = AppBar(
    title: Text('With Actions'),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ],
  );
  print('AppBar with actions created');

  // Test AppBar with custom colors
  final customColors = AppBar(
    title: Text('Custom Colors'),
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
  );
  print('AppBar with custom colors created');

  // Test AppBar with elevation
  final withElevation = AppBar(
    title: Text('Elevated'),
    elevation: 8.0,
    shadowColor: Colors.black,
  );
  print('AppBar with elevation=8.0 created');

  // Test AppBar with centerTitle
  final centerTitle = AppBar(title: Text('Centered'), centerTitle: true);
  print('AppBar with centerTitle=true created');

  // Test AppBar with automaticallyImplyLeading
  final noImply = AppBar(
    title: Text('No Implied Leading'),
    automaticallyImplyLeading: false,
  );
  print('AppBar with automaticallyImplyLeading=false created');

  // Test AppBar with bottom
  final withBottom = AppBar(
    title: Text('With Bottom'),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Container(
        height: 48.0,
        color: Colors.blue.shade700,
        child: Center(
          child: Text('Bottom Widget', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('AppBar with bottom widget created');

  // Test AppBar with flexibleSpace
  final withFlexibleSpace = AppBar(
    title: Text('Flexible Space'),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
  print('AppBar with flexibleSpace gradient created');

  // Test AppBar with toolbarHeight
  final customHeight = AppBar(title: Text('Tall AppBar'), toolbarHeight: 80.0);
  print('AppBar with toolbarHeight=80.0 created');

  // Test AppBar with shape
  final withShape = AppBar(
    title: Text('Shaped'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
    ),
  );
  print('AppBar with rounded bottom shape created');

  print('AppBar test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(height: 56.0, child: basicAppBar),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withLeading),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withActions),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: customColors),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: centerTitle),
      SizedBox(height: 4.0),
      Container(height: 104.0, child: withBottom),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withFlexibleSpace),
      SizedBox(height: 4.0),
      Container(height: 80.0, child: customHeight),
    ],
  );
}
