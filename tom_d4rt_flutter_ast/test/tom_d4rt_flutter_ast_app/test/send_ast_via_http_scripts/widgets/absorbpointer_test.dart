// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AbsorbPointer, IgnorePointer, MouseRegion, RepaintBoundary from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    'AbsorbPointer/IgnorePointer/MouseRegion/RepaintBoundary test executing',
  );

  // ========== ABSORBPOINTER ==========
  print('--- AbsorbPointer Tests ---');

  // Test AbsorbPointer absorbing=true (default)
  final absorbTrue = AbsorbPointer(
    absorbing: true,
    child: ElevatedButton(
      onPressed: () {
        print('This should not be called');
      },
      child: Text('Absorbed (disabled)'),
    ),
  );
  print('AbsorbPointer absorbing=true created');

  // Test AbsorbPointer absorbing=false
  final absorbFalse = AbsorbPointer(
    absorbing: false,
    child: ElevatedButton(
      onPressed: () {
        print('Button pressed (not absorbed)');
      },
      child: Text('Not absorbed (enabled)'),
    ),
  );
  print('AbsorbPointer absorbing=false created');

  // Test AbsorbPointer wrapping multiple children
  final absorbGroup = AbsorbPointer(
    absorbing: true,
    child: Column(
      children: [
        ElevatedButton(
          onPressed: () {
            print('Button 1');
          },
          child: Text('Button 1'),
        ),
        ElevatedButton(
          onPressed: () {
            print('Button 2');
          },
          child: Text('Button 2'),
        ),
        TextField(decoration: InputDecoration(labelText: 'Absorbed TextField')),
      ],
    ),
  );
  print('AbsorbPointer wrapping group created');

  // ========== IGNOREPOINTER ==========
  print('--- IgnorePointer Tests ---');

  // Test IgnorePointer ignoring=true (default)
  final ignoreTrue = IgnorePointer(
    ignoring: true,
    child: ElevatedButton(
      onPressed: () {
        print('This should not be called');
      },
      child: Text('Ignored (pass-through)'),
    ),
  );
  print('IgnorePointer ignoring=true created');

  // Test IgnorePointer ignoring=false
  final ignoreFalse = IgnorePointer(
    ignoring: false,
    child: ElevatedButton(
      onPressed: () {
        print('Button pressed (not ignored)');
      },
      child: Text('Not ignored (enabled)'),
    ),
  );
  print('IgnorePointer ignoring=false created');

  // Test IgnorePointer wrapping a stack
  final ignoreStack = IgnorePointer(
    ignoring: true,
    child: Stack(
      children: [
        Container(
          width: 200.0,
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Text('Background', style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          child: ElevatedButton(
            onPressed: () {
              print('Stack button');
            },
            child: Text('Stack Btn'),
          ),
        ),
      ],
    ),
  );
  print('IgnorePointer wrapping stack created');

  // ========== MOUSEREGION ==========
  print('--- MouseRegion Tests ---');

  // Test MouseRegion basic with onEnter/onExit
  final mouseBasic = MouseRegion(
    onEnter: (event) {
      print('Mouse entered');
    },
    onExit: (event) {
      print('Mouse exited');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Hover me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion basic created');

  // Test MouseRegion with onHover
  final mouseHover = MouseRegion(
    onHover: (event) {
      print('Mouse hovering');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.orange,
      child: Center(
        child: Text('Track hover', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion with onHover created');

  // Test MouseRegion with cursor
  final mouseCursor = MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Click cursor', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion with click cursor created');

  // Test MouseRegion with opaque=false
  final mouseOpaque = MouseRegion(
    opaque: false,
    onEnter: (event) {
      print('Non-opaque entered');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Non-opaque', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion opaque=false created');

  // ========== REPAINTBOUNDARY ==========
  print('--- RepaintBoundary Tests ---');

  // Test RepaintBoundary basic
  final repaintBasic = RepaintBoundary(
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('RepaintBoundary', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RepaintBoundary basic created');

  // Test RepaintBoundary wrapping complex content
  final repaintComplex = RepaintBoundary(
    child: Column(
      children: [
        Container(
          color: Colors.blue,
          height: 30.0,
          width: 200.0,
          child: Text('Row 1', style: TextStyle(color: Colors.white)),
        ),
        Container(
          color: Colors.green,
          height: 30.0,
          width: 200.0,
          child: Text('Row 2', style: TextStyle(color: Colors.white)),
        ),
        Container(
          color: Colors.orange,
          height: 30.0,
          width: 200.0,
          child: Text('Row 3', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
  print('RepaintBoundary wrapping complex content created');

  // Test RepaintBoundary with key
  final repaintKeyed = RepaintBoundary(
    key: ValueKey('repaint-boundary-1'),
    child: Container(
      width: 200.0,
      height: 40.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Keyed boundary', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RepaintBoundary with key created');

  print(
    'All AbsorbPointer/IgnorePointer/MouseRegion/RepaintBoundary tests completed',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== AbsorbPointer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Absorbing=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbTrue,
        SizedBox(height: 8.0),
        Text('Absorbing=false:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbFalse,
        SizedBox(height: 8.0),
        Text('Absorbing group:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbGroup,
        SizedBox(height: 16.0),
        Text(
          '=== IgnorePointer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Ignoring=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreTrue,
        SizedBox(height: 8.0),
        Text('Ignoring=false:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreFalse,
        SizedBox(height: 8.0),
        Text('Ignoring stack:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreStack,
        SizedBox(height: 16.0),
        Text(
          '=== MouseRegion Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Basic (enter/exit):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        mouseBasic,
        SizedBox(height: 8.0),
        Text('Hover tracking:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseHover,
        SizedBox(height: 8.0),
        Text('Click cursor:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseCursor,
        SizedBox(height: 8.0),
        Text('Non-opaque:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseOpaque,
        SizedBox(height: 16.0),
        Text(
          '=== RepaintBoundary Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintBasic,
        SizedBox(height: 8.0),
        Text('Complex content:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintComplex,
        SizedBox(height: 8.0),
        Text('Keyed:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintKeyed,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          '• AbsorbPointer absorbs hits, preventing children from receiving them',
        ),
        Text(
          '• IgnorePointer ignores hits, passing them through to widgets behind',
        ),
        Text('• MouseRegion tracks mouse enter/exit/hover events'),
        Text('• RepaintBoundary isolates repaint regions for performance'),
      ],
    ),
  );
}
