// D4rt test script: Tests CupertinoMenuAnchor, CupertinoMenuItem, CupertinoMenuDivider, CupertinoMenuLargeDivider, CupertinoMenuTitle from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino menu widgets test executing');

  // ========== CUPERTINOMENUANCHOR ==========
  print('--- CupertinoMenuAnchor Tests ---');

  // Test basic CupertinoMenuAnchor with CupertinoMenuItems
  final basicMenuAnchor = CupertinoMenuAnchor(
    menuChildren: [
      CupertinoMenuItem(
        child: Text('Item 1'),
        onPressed: () {
          print('Item 1 pressed');
        },
      ),
      CupertinoMenuItem(
        child: Text('Item 2'),
        onPressed: () {
          print('Item 2 pressed');
        },
      ),
      CupertinoMenuItem(
        child: Text('Item 3'),
        onPressed: () {
          print('Item 3 pressed');
        },
      ),
    ],
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return CupertinoButton(
        child: Text('Open Menu'),
        onPressed: () {
          controller.open();
        },
      );
    },
  );
  print('Basic CupertinoMenuAnchor created');

  // ========== CUPERTINOMENUITEM ==========
  print('--- CupertinoMenuItem Tests ---');

  // Test CupertinoMenuItem with leading icon
  final iconMenuItem = CupertinoMenuItem(
    leading: Icon(CupertinoIcons.star),
    child: Text('Starred Item'),
    onPressed: () {
      print('Starred item pressed');
    },
  );
  print('CupertinoMenuItem with leading icon created');

  // Test CupertinoMenuItem with trailing
  final trailingMenuItem = CupertinoMenuItem(
    trailing: Icon(CupertinoIcons.chevron_right),
    child: Text('More Options'),
    onPressed: () {},
  );
  print('CupertinoMenuItem with trailing created');

  // Test disabled CupertinoMenuItem
  final disabledMenuItem = CupertinoMenuItem(
    child: Text('Disabled Item'),
    onPressed: null,
  );
  print('Disabled CupertinoMenuItem created');

  // ========== CUPERTINOMENUDIVIDER ==========
  print('--- CupertinoMenuDivider Tests ---');

  // Test CupertinoMenuDivider
  final menuDivider = CupertinoMenuDivider();
  print('CupertinoMenuDivider created');

  // ========== CUPERTINOMENULARGEDIVIDER ==========
  print('--- CupertinoMenuLargeDivider Tests ---');

  // Test CupertinoMenuLargeDivider
  final largeDivider = CupertinoMenuLargeDivider();
  print('CupertinoMenuLargeDivider created');

  // ========== CUPERTINOMENUTITLE ==========
  print('--- CupertinoMenuTitle Tests ---');

  // Test CupertinoMenuTitle
  final menuTitle = CupertinoMenuTitle(
    child: Text('Section Title'),
  );
  print('CupertinoMenuTitle created');

  // ========== COMBINED MENU ==========
  print('--- Combined Menu Test ---');

  // Test full menu with all widget types
  final fullMenuAnchor = CupertinoMenuAnchor(
    menuChildren: [
      CupertinoMenuTitle(child: Text('Actions')),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.doc),
        child: Text('New Document'),
        onPressed: () {},
      ),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.folder),
        child: Text('Open Folder'),
        onPressed: () {},
      ),
      CupertinoMenuDivider(),
      CupertinoMenuTitle(child: Text('Edit')),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.scissors),
        child: Text('Cut'),
        onPressed: () {},
      ),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.doc_on_clipboard),
        child: Text('Copy'),
        onPressed: () {},
      ),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.doc_on_doc),
        child: Text('Paste'),
        onPressed: () {},
      ),
      CupertinoMenuLargeDivider(),
      CupertinoMenuItem(
        leading: Icon(CupertinoIcons.trash),
        child: Text('Delete'),
        isDestructiveAction: true,
        onPressed: () {},
      ),
    ],
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return CupertinoButton(
        child: Text('Full Menu'),
        onPressed: () {
          controller.open();
        },
      );
    },
  );
  print('Full CupertinoMenuAnchor with all types created');

  print('All Cupertino menu widget tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Menu Widgets Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cupertino Menu Widgets:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text('Basic Menu:'),
              SizedBox(height: 8.0),
              basicMenuAnchor,
              SizedBox(height: 16.0),
              Text('Full Menu:'),
              SizedBox(height: 8.0),
              fullMenuAnchor,
              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoMenuAnchor'),
              Text('• CupertinoMenuItem'),
              Text('• CupertinoMenuDivider'),
              Text('• CupertinoMenuLargeDivider'),
              Text('• CupertinoMenuTitle'),
            ],
          ),
        ),
      ),
    ),
  );
}
