// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Scaffold widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scaffold test executing');

  // Note: Scaffold is a Material widget, but also used as widgets.Scaffold
  // Testing core Scaffold properties

  // Test basic Scaffold with body
  final basicScaffold = Container(
    height: 200.0,
    child: Scaffold(body: Center(child: Text('Basic Scaffold Body'))),
  );
  print('Basic Scaffold with body created');

  // Test Scaffold with AppBar
  final withAppBar = Container(
    height: 200.0,
    child: Scaffold(
      appBar: AppBar(title: Text('Scaffold AppBar')),
      body: Center(child: Text('Body with AppBar')),
    ),
  );
  print('Scaffold with AppBar created');

  // Test Scaffold with FAB
  final withFab = Container(
    height: 200.0,
    child: Scaffold(
      body: Center(child: Text('With FAB')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ),
  );
  print('Scaffold with FloatingActionButton created');

  // Test Scaffold with bottomNavigationBar
  final withBottomNav = Container(
    height: 200.0,
    child: Scaffold(
      body: Center(child: Text('With Bottom Nav')),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    ),
  );
  print('Scaffold with BottomNavigationBar created');

  // Test Scaffold with Drawer
  final withDrawer = Container(
    height: 200.0,
    child: Scaffold(
      appBar: AppBar(title: Text('With Drawer')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Drawer Header')),
            ListTile(title: Text('Item 1')),
          ],
        ),
      ),
      body: Center(child: Text('Has Drawer')),
    ),
  );
  print('Scaffold with Drawer created');

  // Test Scaffold with backgroundColor
  final withBackground = Container(
    height: 150.0,
    child: Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Center(child: Text('Custom Background')),
    ),
  );
  print('Scaffold with backgroundColor created');

  // Test Scaffold with extendBody
  final withExtendBody = Container(
    height: 180.0,
    child: Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Extended Body'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(color: Colors.blue.shade100),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.blue.withOpacity(0.5),
      ),
    ),
  );
  print('Scaffold with extendBody=true created');

  // Test Scaffold with floatingActionButtonLocation
  final withFabLocation = Container(
    height: 150.0,
    child: Scaffold(
      body: Center(child: Text('FAB Center End')),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ),
  );
  print('Scaffold with FAB location created');

  print('Scaffold test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Basic Scaffold:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicScaffold,
        SizedBox(height: 8.0),
        Text('With AppBar:', style: TextStyle(fontWeight: FontWeight.bold)),
        withAppBar,
        SizedBox(height: 8.0),
        Text('With FAB:', style: TextStyle(fontWeight: FontWeight.bold)),
        withFab,
        SizedBox(height: 8.0),
        Text('With Background:', style: TextStyle(fontWeight: FontWeight.bold)),
        withBackground,
      ],
    ),
  );
}
