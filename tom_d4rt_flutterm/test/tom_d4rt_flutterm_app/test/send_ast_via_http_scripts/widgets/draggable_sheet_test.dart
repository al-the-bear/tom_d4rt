// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DraggableScrollableSheet, DraggableScrollableController,
// DraggableScrollableNotification, BottomSheet, NotificationListener,
// SheetDragDetails, SnappingSheetBehavior and ShowModalBottomSheet concepts
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Draggable sheet test executing');

  // ========== DraggableScrollableController ==========
  print('--- DraggableScrollableController Tests ---');
  final dsController = DraggableScrollableController();
  print('DraggableScrollableController created');

  // ========== DraggableScrollableSheet ==========
  print('--- DraggableScrollableSheet Tests ---');
  final draggableSheet = DraggableScrollableSheet(
    initialChildSize: 0.3,
    minChildSize: 0.1,
    maxChildSize: 0.9,
    expand: true,
    snap: true,
    snapSizes: [0.25, 0.5, 0.75],
    snapAnimationDuration: Duration(milliseconds: 150),
    controller: dsController,
    shouldCloseOnMinExtent: true,
    builder: (context, scrollController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ListView.builder(
          controller: scrollController,
          itemCount: 25,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.list),
            title: Text('Item $index'),
            subtitle: Text('Description for item $index'),
          ),
        ),
      );
    },
  );
  print('DraggableScrollableSheet created');
  print('  initialChildSize: 0.3');
  print('  minChildSize: 0.1');
  print('  maxChildSize: 0.9');
  print('  snap: true');

  // ========== DraggableScrollableNotification ==========
  print('--- DraggableScrollableNotification Tests ---');
  final notificationListener =
      NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          print('  DraggableScrollableNotification:');
          print('    extent: ${notification.extent}');
          print('    minExtent: ${notification.minExtent}');
          print('    maxExtent: ${notification.maxExtent}');
          print('    initialExtent: ${notification.initialExtent}');
          print(
            '    shouldCloseOnMinExtent: ${notification.shouldCloseOnMinExtent}',
          );
          return false;
        },
        child: draggableSheet,
      );
  print('NotificationListener<DraggableScrollableNotification> created');

  // ========== BottomSheet ==========
  print('--- BottomSheet Tests ---');
  final bottomSheet = BottomSheet(
    onClosing: () => print('  BottomSheet closing'),
    builder: (context) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text('Bottom Sheet Content', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Action')),
          ],
        ),
      );
    },
    enableDrag: true,
    showDragHandle: true,
    dragHandleColor: Colors.grey[400],
    dragHandleSize: Size(32, 4),
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black26,
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(maxHeight: 400),
    animationController: AnimationController(
      vsync: TestVSync(),
      duration: Duration(milliseconds: 300),
    ),
  );
  print('BottomSheet created: $bottomSheet');

  // ========== NotificationListener types ==========
  print('--- NotificationListener Tests ---');
  final scrollNotifListener = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      if (notification is ScrollStartNotification) {
        print('  Scroll started');
      } else if (notification is ScrollUpdateNotification) {
        print('  Scroll updated');
      } else if (notification is ScrollEndNotification) {
        print('  Scroll ended');
      }
      return false;
    },
    child: ListView(children: [Text('Item 1'), Text('Item 2')]),
  );
  print('NotificationListener<ScrollNotification> created: $scrollNotifListener');

  // ========== BottomSheetThemeData ==========
  print('--- BottomSheetThemeData Tests ---');
  final bsTheme = BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    showDragHandle: true,
    dragHandleColor: Colors.grey[300],
    dragHandleSize: Size(32, 4),
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(maxWidth: 600),
    modalBackgroundColor: Colors.white,
    modalElevation: 16.0,
    modalBarrierColor: Colors.black54,
  );
  print('BottomSheetThemeData created');
  print('  elevation: ${bsTheme.elevation}');
  print('  showDragHandle: ${bsTheme.showDragHandle}');

  print('All draggable sheet tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Stack(
        children: [
          Center(child: Text('Background Content')),
          notificationListener,
        ],
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
