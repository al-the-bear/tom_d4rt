// D4rt test script: Tests MouseTracker from rendering
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseTracker test executing');

  // ========== MouseTracker basics ==========
  print('--- MouseTracker basics ---');
  // MouseTracker is typically created and managed by the rendering binding
  // We can test the interface and concepts
  print('  MouseTracker manages mouse pointer state');
  print('  Tracks which render objects the mouse is over');
  print('  Handles mouse enter/exit events');

  // ========== MouseTrackerAnnotation ==========
  print('--- MouseTrackerAnnotation ---');
  int enterCount = 0;
  int exitCount = 0;
  int hoverCount = 0;
  
  final annotation1 = MouseTrackerAnnotation(
    onEnter: (event) {
      enterCount++;
      print('  onEnter called: pointer ${event.pointer}');
    },
    onExit: (event) {
      exitCount++;
      print('  onExit called: pointer ${event.pointer}');
    },
    onHover: (event) {
      hoverCount++;
      print('  onHover called');
    },
  );
  print('  annotation1 created: ${annotation1.runtimeType}');

  // ========== MouseTrackerAnnotation with cursor ==========
  print('--- MouseTrackerAnnotation with cursor ---');
  final annotationWithCursor = MouseTrackerAnnotation(
    cursor: SystemMouseCursors.click,
    onEnter: (event) => print('  entered clickable region'),
    onExit: (event) => print('  exited clickable region'),
  );
  print('  cursor: ${annotationWithCursor.cursor}');

  // ========== Different cursor types ==========
  print('--- Different cursor types ---');
  final cursors = [
    ('basic', SystemMouseCursors.basic),
    ('click', SystemMouseCursors.click),
    ('text', SystemMouseCursors.text),
    ('grab', SystemMouseCursors.grab),
    ('grabbing', SystemMouseCursors.grabbing),
    ('resizeColumn', SystemMouseCursors.resizeColumn),
    ('resizeRow', SystemMouseCursors.resizeRow),
    ('move', SystemMouseCursors.move),
    ('noDrop', SystemMouseCursors.noDrop),
    ('forbidden', SystemMouseCursors.forbidden),
  ];
  for (final (name, cursor) in cursors) {
    final ann = MouseTrackerAnnotation(cursor: cursor);
    print('  $name cursor: ${ann.cursor}');
  }

  // ========== validForMouseTracker property ==========
  print('--- validForMouseTracker property ---');
  final validAnnotation = MouseTrackerAnnotation(
    onEnter: (_) {},
    validForMouseTracker: true,
  );
  print('  validForMouseTracker: true - ${validAnnotation.runtimeType}');

  // ========== PointerEnterEvent ==========
  print('--- PointerEnterEvent ---');
  final enterEvent = PointerEnterEvent(
    position: Offset(100.0, 100.0),
    localPosition: Offset(50.0, 50.0),
  );
  print('  PointerEnterEvent position: ${enterEvent.position}');
  print('  PointerEnterEvent localPosition: ${enterEvent.localPosition}');

  // ========== PointerExitEvent ==========
  print('--- PointerExitEvent ---');
  final exitEvent = PointerExitEvent(
    position: Offset(200.0, 200.0),
    localPosition: Offset(100.0, 100.0),
  );
  print('  PointerExitEvent position: ${exitEvent.position}');
  print('  PointerExitEvent localPosition: ${exitEvent.localPosition}');

  // ========== PointerHoverEvent ==========
  print('--- PointerHoverEvent ---');
  final hoverEvent = PointerHoverEvent(
    position: Offset(150.0, 150.0),
    delta: Offset(5.0, 5.0),
  );
  print('  PointerHoverEvent position: ${hoverEvent.position}');
  print('  PointerHoverEvent delta: ${hoverEvent.delta}');

  // ========== Multiple annotations ==========
  print('--- Multiple annotations ---');
  final annotations = List.generate(5, (i) {
    return MouseTrackerAnnotation(
      cursor: i.isEven ? SystemMouseCursors.click : SystemMouseCursors.text,
      onEnter: (e) => print('  annotation $i entered'),
      onExit: (e) => print('  annotation $i exited'),
    );
  });
  print('  created ${annotations.length} annotations');
  for (int i = 0; i < annotations.length; i++) {
    print('  annotation $i cursor: ${annotations[i].cursor}');
  }

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  annotation1.runtimeType: ${annotation1.runtimeType}');
  print('  enterEvent.runtimeType: ${enterEvent.runtimeType}');
  print('  exitEvent.runtimeType: ${exitEvent.runtimeType}');
  print('  hoverEvent.runtimeType: ${hoverEvent.runtimeType}');

  print('MouseTracker test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('MouseTracker Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('MouseTracker: Manages mouse pointer state'),
          Text('MouseTrackerAnnotation: ${annotation1.runtimeType}'),
          SizedBox(height: 8.0),
          Text('Cursor types tested:'),
          ...cursors.take(5).map((c) => Text('  - ${c.$1}')),
          SizedBox(height: 8.0),
          Text('Events:'),
          Text('  PointerEnterEvent: ${enterEvent.position}'),
          Text('  PointerExitEvent: ${exitEvent.position}'),
          Text('  PointerHoverEvent: ${hoverEvent.position}'),
          SizedBox(height: 8.0),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              color: Color(0xFF2196F3),
              padding: EdgeInsets.all(16.0),
              child: Text('Hover me!',
                  style: TextStyle(color: Color(0xFFFFFFFF))),
            ),
          ),
        ],
      ),
    ),
  );
}
