// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BottomAppBar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomAppBar test executing');

  // Test basic BottomAppBar
  final barBasic = BottomAppBar(
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu pressed');
          },
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('Search pressed');
          },
        ),
      ],
    ),
  );
  print('Basic BottomAppBar created');

  // Test BottomAppBar with color
  final barColored = BottomAppBar(
    color: Colors.blue,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            print('Home pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          onPressed: () {
            print('Favorite pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with color=blue created');

  // Test BottomAppBar with elevation
  final barElevated = BottomAppBar(
    elevation: 12.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            print('Person pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            print('Settings pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with elevation=12 created');

  // Test BottomAppBar with shape (CircularNotchedRectangle)
  final barNotched = BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 8.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu pressed');
          },
        ),
        SizedBox(width: 48.0),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            print('More pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with CircularNotchedRectangle and notchMargin=8 created');

  // Test BottomAppBar with clipBehavior
  final barClipped = BottomAppBar(
    clipBehavior: Clip.antiAlias,
    color: Colors.green,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.star, color: Colors.white),
          onPressed: () {
            print('Star pressed');
          },
        ),
        Text('Clipped', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
  print('BottomAppBar with clipBehavior=antiAlias created');

  // Test BottomAppBar with surfaceTintColor
  final barSurfaceTint = BottomAppBar(
    surfaceTintColor: Colors.purple,
    elevation: 4.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.palette, color: Colors.purple),
        SizedBox(width: 8.0),
        Text('Surface tint'),
      ],
    ),
  );
  print('BottomAppBar with surfaceTintColor=purple created');

  // Test BottomAppBar with notchMargin variations
  final barWideNotch = BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 16.0,
    color: Colors.orange,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            print('Back pressed');
          },
        ),
        SizedBox(width: 56.0),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: () {
            print('Forward pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with wide notchMargin=16 created');

  // Test BottomAppBar with padding
  final barPadded = BottomAppBar(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    height: 70.0,
    color: Colors.teal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home, color: Colors.white),
            Text('Home', style: TextStyle(color: Colors.white, fontSize: 10.0)),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            Text(
              'Search',
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, color: Colors.white),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
      ],
    ),
  );
  print('BottomAppBar with padding and height created');

  // Test BottomAppBar with all properties combined
  final barFull = BottomAppBar(
    color: Colors.indigo,
    elevation: 8.0,
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    clipBehavior: Clip.antiAlias,
    surfaceTintColor: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.dashboard, color: Colors.white),
          onPressed: () {
            print('Dashboard pressed');
          },
        ),
        SizedBox(width: 40.0),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            print('Notifications pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with all properties created');

  print('All BottomAppBar tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== BottomAppBar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        barBasic,
        SizedBox(height: 8.0),
        Text('Colored (blue):', style: TextStyle(fontWeight: FontWeight.bold)),
        barColored,
        SizedBox(height: 8.0),
        Text('Elevated:', style: TextStyle(fontWeight: FontWeight.bold)),
        barElevated,
        SizedBox(height: 8.0),
        Text('Notched shape:', style: TextStyle(fontWeight: FontWeight.bold)),
        barNotched,
        SizedBox(height: 8.0),
        Text('Clipped:', style: TextStyle(fontWeight: FontWeight.bold)),
        barClipped,
        SizedBox(height: 8.0),
        Text('Surface tint:', style: TextStyle(fontWeight: FontWeight.bold)),
        barSurfaceTint,
        SizedBox(height: 8.0),
        Text('Wide notch:', style: TextStyle(fontWeight: FontWeight.bold)),
        barWideNotch,
        SizedBox(height: 8.0),
        Text(
          'Padded with height:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        barPadded,
        SizedBox(height: 8.0),
        Text('Full properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        barFull,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• BottomAppBar sits at bottom of Scaffold'),
        Text('• shape with CircularNotchedRectangle creates FAB notch'),
        Text('• notchMargin controls gap around the notch'),
        Text('• elevation controls shadow depth'),
        Text('• clipBehavior controls clipping of the shape'),
        Text('• surfaceTintColor tints the surface for Material 3'),
      ],
    ),
  );
}
