// D4rt test script: Tests CupertinoContextMenu, CupertinoContextMenuAction, CupertinoScrollbar from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino context menu test executing');

  // ========== CUPERTINOCONTEXTMENU ==========
  print('--- CupertinoContextMenu Tests ---');

  // Test basic CupertinoContextMenu
  final basicContextMenu = CupertinoContextMenu(
    child: Container(
      width: 100.0,
      height: 100.0,
      color: CupertinoColors.systemBlue,
      child: Center(
        child: Text('Hold me', style: TextStyle(color: CupertinoColors.white)),
      ),
    ),
    actions: [
      CupertinoContextMenuAction(child: Text('Action 1'), onPressed: () {}),
      CupertinoContextMenuAction(child: Text('Action 2'), onPressed: () {}),
    ],
  );
  print('Basic CupertinoContextMenu created');

  // Test CupertinoContextMenu with enableHapticFeedback
  final hapticContextMenu = CupertinoContextMenu(
    enableHapticFeedback: true,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: CupertinoColors.systemGreen,
    ),
    actions: [
      CupertinoContextMenuAction(child: Text('With Haptic'), onPressed: () {}),
    ],
  );
  print('CupertinoContextMenu with enableHapticFeedback created');

  // Test CupertinoContextMenu without haptic feedback
  final noHapticContextMenu = CupertinoContextMenu(
    enableHapticFeedback: false,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: CupertinoColors.systemOrange,
    ),
    actions: [
      CupertinoContextMenuAction(child: Text('No Haptic'), onPressed: () {}),
    ],
  );
  print('CupertinoContextMenu with enableHapticFeedback=false created');

  // Test CupertinoContextMenu with previewBuilder
  final previewContextMenu = CupertinoContextMenu.builder(
    actions: [
      CupertinoContextMenuAction(
        child: Text('Preview Action'),
        onPressed: () {},
      ),
    ],
    builder: (context, animation) {
      return Container(
        width: 150.0,
        height: 150.0,
        color: CupertinoColors.systemPurple.withOpacity(animation.value),
        child: Center(child: Text('Preview')),
      );
    },
  );
  print('CupertinoContextMenu.builder created');

  // ========== CUPERTINOCONTEXTMENUACTION ==========
  print('--- CupertinoContextMenuAction Tests ---');

  // Test basic CupertinoContextMenuAction
  final basicAction = CupertinoContextMenuAction(
    child: Text('Action'),
    onPressed: () {
      print('Action pressed');
    },
  );
  print('Basic CupertinoContextMenuAction created');

  // Test CupertinoContextMenuAction with isDefaultAction
  final defaultAction = CupertinoContextMenuAction(
    isDefaultAction: true,
    child: Text('Default Action'),
    onPressed: () {},
  );
  print('CupertinoContextMenuAction with isDefaultAction created');

  // Test CupertinoContextMenuAction with isDestructiveAction
  final destructiveAction = CupertinoContextMenuAction(
    isDestructiveAction: true,
    child: Text('Delete'),
    onPressed: () {},
  );
  print('CupertinoContextMenuAction with isDestructiveAction created');

  // Test CupertinoContextMenuAction with trailingIcon
  final trailingAction = CupertinoContextMenuAction(
    trailingIcon: CupertinoIcons.share,
    child: Text('Share'),
    onPressed: () {},
  );
  print('CupertinoContextMenuAction with trailingIcon created');

  // ========== CUPERTINOSCROLLBAR ==========
  print('--- CupertinoScrollbar Tests ---');

  // Test basic CupertinoScrollbar
  final basicScrollbar = CupertinoScrollbar(
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    ),
  );
  print('Basic CupertinoScrollbar created');

  // Test CupertinoScrollbar with controller
  final controlledScrollbar = CupertinoScrollbar(
    controller: ScrollController(),
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Controlled Item $index')),
    ),
  );
  print('CupertinoScrollbar with controller created');

  // Test CupertinoScrollbar with thumbVisibility
  final visibleScrollbar = CupertinoScrollbar(
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Visible Item $index')),
    ),
  );
  print('CupertinoScrollbar with thumbVisibility created');

  // Test CupertinoScrollbar with thickness
  final thickScrollbar = CupertinoScrollbar(
    thickness: 10.0,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Thick Item $index')),
    ),
  );
  print('CupertinoScrollbar with thickness created');

  // Test CupertinoScrollbar with thicknessWhileDragging
  final draggingScrollbar = CupertinoScrollbar(
    thicknessWhileDragging: 12.0,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Dragging Item $index')),
    ),
  );
  print('CupertinoScrollbar with thicknessWhileDragging created');

  // Test CupertinoScrollbar with radius
  final radiusScrollbar = CupertinoScrollbar(
    radius: Radius.circular(4.0),
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Radius Item $index')),
    ),
  );
  print('CupertinoScrollbar with radius created');

  // Test CupertinoScrollbar with radiusWhileDragging
  final radiusDraggingScrollbar = CupertinoScrollbar(
    radiusWhileDragging: Radius.circular(8.0),
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('RadiusDragging Item $index')),
    ),
  );
  print('CupertinoScrollbar with radiusWhileDragging created');

  // Test CupertinoScrollbar with scrollbarOrientation
  final orientedScrollbar = CupertinoScrollbar(
    scrollbarOrientation: ScrollbarOrientation.left,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Left Item $index')),
    ),
  );
  print('CupertinoScrollbar with scrollbarOrientation created');

  // Test CupertinoScrollbar with notificationPredicate
  final predicateScrollbar = CupertinoScrollbar(
    notificationPredicate: (notification) => true,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) =>
          ListTile(title: Text('Predicate Item $index')),
    ),
  );
  print('CupertinoScrollbar with notificationPredicate created');

  print('Cupertino context menu test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Context Menu & Scrollbar'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Context Menu (long press):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoContextMenu(
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBlue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Blue',
                              style: TextStyle(color: CupertinoColors.white),
                            ),
                          ),
                        ),
                        actions: [
                          CupertinoContextMenuAction(
                            child: Text('Copy'),
                            onPressed: () {},
                          ),
                          CupertinoContextMenuAction(
                            trailingIcon: CupertinoIcons.share,
                            child: Text('Share'),
                            onPressed: () {},
                          ),
                          CupertinoContextMenuAction(
                            isDestructiveAction: true,
                            child: Text('Delete'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      CupertinoContextMenu(
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGreen,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Green',
                              style: TextStyle(color: CupertinoColors.white),
                            ),
                          ),
                        ),
                        actions: [
                          CupertinoContextMenuAction(
                            isDefaultAction: true,
                            child: Text('Default'),
                            onPressed: () {},
                          ),
                          CupertinoContextMenuAction(
                            child: Text('Another'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Scrollbar List:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: CupertinoScrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('Scrollable Item ${index + 1}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
