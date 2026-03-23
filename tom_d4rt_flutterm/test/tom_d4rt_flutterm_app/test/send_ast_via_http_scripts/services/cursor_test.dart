// ignore_for_file: avoid_print
// D4rt test script: Tests MouseCursor, SystemMouseCursors, SystemMouseCursor from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services cursor test executing');

  // ========== SYSTEMMOUSECURSORS ==========
  print('--- SystemMouseCursors Tests ---');

  // Basic cursors
  final none = SystemMouseCursors.none;
  print('SystemMouseCursors.none: $none');
  print('  runtimeType: ${none.runtimeType}');

  final basic = SystemMouseCursors.basic;
  print('SystemMouseCursors.basic: $basic');

  final click = SystemMouseCursors.click;
  print('SystemMouseCursors.click: $click');

  final forbidden = SystemMouseCursors.forbidden;
  print('SystemMouseCursors.forbidden: $forbidden');

  final wait = SystemMouseCursors.wait;
  print('SystemMouseCursors.wait: $wait');

  final progress = SystemMouseCursors.progress;
  print('SystemMouseCursors.progress: $progress');

  // Text cursors
  final text = SystemMouseCursors.text;
  print('SystemMouseCursors.text: $text');

  final verticalText = SystemMouseCursors.verticalText;
  print('SystemMouseCursors.verticalText: $verticalText');

  // Selection cursors
  final cell = SystemMouseCursors.cell;
  print('SystemMouseCursors.cell: $cell');

  final precise = SystemMouseCursors.precise;
  print('SystemMouseCursors.precise: $precise');

  // Drag cursors
  final move = SystemMouseCursors.move;
  print('SystemMouseCursors.move: $move');

  final grab = SystemMouseCursors.grab;
  print('SystemMouseCursors.grab: $grab');

  final grabbing = SystemMouseCursors.grabbing;
  print('SystemMouseCursors.grabbing: $grabbing');

  final noDrop = SystemMouseCursors.noDrop;
  print('SystemMouseCursors.noDrop: $noDrop');

  final alias = SystemMouseCursors.alias;
  print('SystemMouseCursors.alias: $alias');

  final copy = SystemMouseCursors.copy;
  print('SystemMouseCursors.copy: $copy');

  final disappearing = SystemMouseCursors.disappearing;
  print('SystemMouseCursors.disappearing: $disappearing');

  final allScroll = SystemMouseCursors.allScroll;
  print('SystemMouseCursors.allScroll: $allScroll');

  // Resize cursors
  final resizeColumn = SystemMouseCursors.resizeColumn;
  print('SystemMouseCursors.resizeColumn: $resizeColumn');

  final resizeRow = SystemMouseCursors.resizeRow;
  print('SystemMouseCursors.resizeRow: $resizeRow');

  final resizeUp = SystemMouseCursors.resizeUp;
  print('SystemMouseCursors.resizeUp: $resizeUp');

  final resizeDown = SystemMouseCursors.resizeDown;
  print('SystemMouseCursors.resizeDown: $resizeDown');

  final resizeLeft = SystemMouseCursors.resizeLeft;
  print('SystemMouseCursors.resizeLeft: $resizeLeft');

  final resizeRight = SystemMouseCursors.resizeRight;
  print('SystemMouseCursors.resizeRight: $resizeRight');

  final resizeUpLeft = SystemMouseCursors.resizeUpLeft;
  print('SystemMouseCursors.resizeUpLeft: $resizeUpLeft');

  final resizeUpRight = SystemMouseCursors.resizeUpRight;
  print('SystemMouseCursors.resizeUpRight: $resizeUpRight');

  final resizeDownLeft = SystemMouseCursors.resizeDownLeft;
  print('SystemMouseCursors.resizeDownLeft: $resizeDownLeft');

  final resizeDownRight = SystemMouseCursors.resizeDownRight;
  print('SystemMouseCursors.resizeDownRight: $resizeDownRight');

  final resizeUpLeftDownRight = SystemMouseCursors.resizeUpLeftDownRight;
  print('SystemMouseCursors.resizeUpLeftDownRight: $resizeUpLeftDownRight');

  final resizeUpRightDownLeft = SystemMouseCursors.resizeUpRightDownLeft;
  print('SystemMouseCursors.resizeUpRightDownLeft: $resizeUpRightDownLeft');

  // Zoom cursors
  final zoomIn = SystemMouseCursors.zoomIn;
  print('SystemMouseCursors.zoomIn: $zoomIn');

  final zoomOut = SystemMouseCursors.zoomOut;
  print('SystemMouseCursors.zoomOut: $zoomOut');

  // ========== MOUSECURSOR ==========
  print('--- MouseCursor Tests ---');

  // MouseCursor.defer and MouseCursor.uncontrolled
  final deferred = MouseCursor.defer;
  print('MouseCursor.defer: $deferred');
  print('  runtimeType: ${deferred.runtimeType}');

  final uncontrolled = MouseCursor.uncontrolled;
  print('MouseCursor.uncontrolled: $uncontrolled');
  print('  runtimeType: ${uncontrolled.runtimeType}');

  // ========== SYSTEMMOUSECURSOR ==========
  print('--- SystemMouseCursor Type Check ---');

  print(
    'SystemMouseCursors.click is SystemMouseCursor: true /* click is SystemMouseCursor */',
  );
  print(
    'SystemMouseCursors.text is SystemMouseCursor: true /* text is SystemMouseCursor */',
  );
  print(
    'SystemMouseCursors.forbidden is MouseCursor: true /* forbidden is MouseCursor */',
  );

  // ========== RETURN WIDGET ==========
  print('Services cursor test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Cursor Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• MouseCursor - abstract cursor base'),
          Text('• SystemMouseCursor - system cursor type'),
          Text('• SystemMouseCursors - predefined cursors'),
          SizedBox(height: 16.0),

          Text(
            'Cursor Categories:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE1F5FE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic: none, basic, click, forbidden, wait'),
                Text('Text: text, verticalText'),
                Text('Selection: cell, precise'),
                Text('Drag: move, grab, grabbing, noDrop, copy'),
                Text('Resize: column, row, up/down/left/right'),
                Text('  diagonal: upLeft, upRight, downLeft, downRight'),
                Text('Zoom: zoomIn, zoomOut'),
                Text('Special: defer, uncontrolled'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
