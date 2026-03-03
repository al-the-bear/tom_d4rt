// D4rt test script: Tests CupertinoPulldownButton, CupertinoPulldownMenuItem, CupertinoPulldownMenuDivider, CupertinoPulldownMenuTitle from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino pulldown test executing');

  // ========== CUPERTINOPULLDOWNBUTTON ==========
  print('--- CupertinoPulldownButton Tests ---');

  // Test basic CupertinoPulldownButton
  final basicPulldown = CupertinoPulldownButton(
    itemBuilder: (BuildContext context) => [
      CupertinoPulldownMenuItem(
        title: Text('Option A'),
        onTap: () {
          print('Option A selected');
        },
      ),
      CupertinoPulldownMenuItem(
        title: Text('Option B'),
        onTap: () {
          print('Option B selected');
        },
      ),
      CupertinoPulldownMenuItem(
        title: Text('Option C'),
        onTap: () {
          print('Option C selected');
        },
      ),
    ],
    child: Text('Select Option'),
  );
  print('Basic CupertinoPulldownButton created');

  // ========== CUPERTINOPULLDOWNMENUITEM ==========
  print('--- CupertinoPulldownMenuItem Tests ---');

  // Test CupertinoPulldownMenuItem with icon
  final iconPulldownItem = CupertinoPulldownMenuItem(
    title: Text('Settings'),
    icon: Icon(CupertinoIcons.settings),
    onTap: () {},
  );
  print('CupertinoPulldownMenuItem with icon created');

  // Test disabled CupertinoPulldownMenuItem
  final disabledPulldownItem = CupertinoPulldownMenuItem(
    title: Text('Disabled Option'),
    enabled: false,
    onTap: () {},
  );
  print('Disabled CupertinoPulldownMenuItem created');

  // ========== CUPERTINOPULLDOWNMENUDIVIDER ==========
  print('--- CupertinoPulldownMenuDivider Tests ---');

  final pulldownDivider = CupertinoPulldownMenuDivider();
  print('CupertinoPulldownMenuDivider created');

  // ========== CUPERTINOPULLDOWNMENUTITLE ==========
  print('--- CupertinoPulldownMenuTitle Tests ---');

  final pulldownTitle = CupertinoPulldownMenuTitle(title: Text('Category'));
  print('CupertinoPulldownMenuTitle created');

  // ========== FULL PULLDOWN MENU ==========
  print('--- Full Pulldown Menu Test ---');

  // Test pulldown with all item types
  final fullPulldown = CupertinoPulldownButton(
    itemBuilder: (BuildContext context) => [
      CupertinoPulldownMenuTitle(title: Text('File Operations')),
      CupertinoPulldownMenuItem(
        title: Text('New File'),
        icon: Icon(CupertinoIcons.doc),
        onTap: () {},
      ),
      CupertinoPulldownMenuItem(
        title: Text('Open File'),
        icon: Icon(CupertinoIcons.folder_open),
        onTap: () {},
      ),
      CupertinoPulldownMenuDivider(),
      CupertinoPulldownMenuTitle(title: Text('Edit Operations')),
      CupertinoPulldownMenuItem(
        title: Text('Undo'),
        icon: Icon(CupertinoIcons.arrow_uturn_left),
        onTap: () {},
      ),
      CupertinoPulldownMenuItem(
        title: Text('Redo'),
        icon: Icon(CupertinoIcons.arrow_uturn_right),
        onTap: () {},
      ),
      CupertinoPulldownMenuDivider(),
      CupertinoPulldownMenuItem(
        title: Text('Delete'),
        icon: Icon(CupertinoIcons.trash),
        isDestructiveAction: true,
        onTap: () {},
      ),
    ],
    child: Text('Actions'),
  );
  print('Full CupertinoPulldownButton created');

  // Test pulldown without icon
  final simplePulldown = CupertinoPulldownButton(
    itemBuilder: (BuildContext context) => [
      CupertinoPulldownMenuItem(title: Text('Small'), onTap: () {}),
      CupertinoPulldownMenuItem(title: Text('Medium'), onTap: () {}),
      CupertinoPulldownMenuItem(title: Text('Large'), onTap: () {}),
    ],
    child: Text('Size'),
  );
  print('Simple CupertinoPulldownButton created');

  print('All Cupertino pulldown tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Pulldown Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cupertino Pulldown Menus:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text('Basic Pulldown:'),
              SizedBox(height: 8.0),
              basicPulldown,
              SizedBox(height: 16.0),
              Text('Full Pulldown:'),
              SizedBox(height: 8.0),
              fullPulldown,
              SizedBox(height: 16.0),
              Text('Simple Pulldown:'),
              SizedBox(height: 8.0),
              simplePulldown,
              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoPulldownButton'),
              Text('• CupertinoPulldownMenuItem'),
              Text('• CupertinoPulldownMenuDivider'),
              Text('• CupertinoPulldownMenuTitle'),
            ],
          ),
        ),
      ),
    ),
  );
}
