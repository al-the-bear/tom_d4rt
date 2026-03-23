// Deep demo: RenderMouseRegion — MouseRegion widget test
// MouseRegion detects mouse enter, hover, exit events and controls mouse cursor
// Tests all SystemMouseCursors, opaque, hitTestBehavior, nesting, and practical patterns

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('render_mouse_region_test: build() called');

  return SingleChildScrollView(
    child: Container(
      color: Color(0xFF121212),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.0),

          // Section 1: Basic MouseRegion with enter/hover/exit
          _buildSectionTitle('1. Basic MouseRegion — onEnter / onHover / onExit'),
          _buildBasicMouseRegion(),
          SizedBox(height: 24.0),

          // Section 2: Cursor catalog
          _buildSectionTitle('2. SystemMouseCursors Catalog'),
          _buildCursorCatalog(),
          SizedBox(height: 24.0),

          // Section 3: Opaque parameter
          _buildSectionTitle('3. Opaque Parameter (true vs false)'),
          _buildOpaqueDemo(),
          SizedBox(height: 24.0),

          // Section 4: HitTestBehavior options
          _buildSectionTitle('4. HitTestBehavior Options'),
          _buildHitTestBehaviorDemo(),
          SizedBox(height: 24.0),

          // Section 5: Nested MouseRegion (cursor priority)
          _buildSectionTitle('5. Nested MouseRegion — Cursor Priority'),
          _buildNestedMouseRegions(),
          SizedBox(height: 24.0),

          // Section 6: MouseRegion with InkWell/GestureDetector
          _buildSectionTitle('6. MouseRegion + InkWell / GestureDetector'),
          _buildWithInkWellAndGesture(),
          SizedBox(height: 24.0),

          // Section 7: Custom hover effects
          _buildSectionTitle('7. Custom Hover Effects'),
          _buildCustomHoverEffects(),
          SizedBox(height: 24.0),

          // Section 8: Cursor zones — interactive map regions
          _buildSectionTitle('8. Cursor Zones — Interactive Map Regions'),
          _buildCursorZones(),
          SizedBox(height: 24.0),

          // Section 9: Practical patterns
          _buildSectionTitle('9. Practical Patterns'),
          _buildPracticalPatterns(),
          SizedBox(height: 32.0),

          Center(
            child: Text(
              'End of RenderMouseRegion Deep Demo',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    ),
  );
}

Widget _buildHeader() {
  print('render_mouse_region_test: building header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF00BFA5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderMouseRegion Deep Demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'MouseRegion — enter, hover, exit, cursor, opaque, hitTest, nesting',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('render_mouse_region_test: section — ' + title);
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

// Section 1: Basic MouseRegion with callbacks
Widget _buildBasicMouseRegion() {
  print('render_mouse_region_test: building basic mouse region section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MouseRegion(
        onEnter: (PointerEnterEvent event) {
          print('Basic MouseRegion: onEnter at position ' + event.position.toString());
        },
        onHover: (PointerHoverEvent event) {
          print('Basic MouseRegion: onHover at ' + event.localPosition.toString());
        },
        onExit: (PointerExitEvent event) {
          print('Basic MouseRegion: onExit at position ' + event.position.toString());
        },
        child: Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFF1B5E20),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF4CAF50), width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'Hover over me — check console for enter/hover/exit logs',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
      SizedBox(height: 12.0),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (PointerEnterEvent event) {
          print('Click-cursor region: onEnter');
        },
        onExit: (PointerExitEvent event) {
          print('Click-cursor region: onExit');
        },
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            color: Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'MouseRegion with click cursor',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    ],
  );
}

// Section 2: Full SystemMouseCursors catalog
Widget _buildCursorCatalog() {
  print('render_mouse_region_test: building cursor catalog');

  List<MapEntry<String, MouseCursor>> cursorEntries = [
    MapEntry('basic', SystemMouseCursors.basic),
    MapEntry('click', SystemMouseCursors.click),
    MapEntry('forbidden', SystemMouseCursors.forbidden),
    MapEntry('wait', SystemMouseCursors.wait),
    MapEntry('progress', SystemMouseCursors.progress),
    MapEntry('contextMenu', SystemMouseCursors.contextMenu),
    MapEntry('help', SystemMouseCursors.help),
    MapEntry('text', SystemMouseCursors.text),
    MapEntry('verticalText', SystemMouseCursors.verticalText),
    MapEntry('cell', SystemMouseCursors.cell),
    MapEntry('precise', SystemMouseCursors.precise),
    MapEntry('move', SystemMouseCursors.move),
    MapEntry('grab', SystemMouseCursors.grab),
    MapEntry('grabbing', SystemMouseCursors.grabbing),
    MapEntry('noDrop', SystemMouseCursors.noDrop),
    MapEntry('alias', SystemMouseCursors.alias),
    MapEntry('copy', SystemMouseCursors.copy),
    MapEntry('disappearing', SystemMouseCursors.disappearing),
    MapEntry('allScroll', SystemMouseCursors.allScroll),
    MapEntry('resizeLeftRight', SystemMouseCursors.resizeLeftRight),
    MapEntry('resizeUpDown', SystemMouseCursors.resizeUpDown),
    MapEntry('resizeUpLeftDownRight', SystemMouseCursors.resizeUpLeftDownRight),
    MapEntry('resizeUpRightDownLeft', SystemMouseCursors.resizeUpRightDownLeft),
    MapEntry('resizeUp', SystemMouseCursors.resizeUp),
    MapEntry('resizeDown', SystemMouseCursors.resizeDown),
    MapEntry('resizeLeft', SystemMouseCursors.resizeLeft),
    MapEntry('resizeRight', SystemMouseCursors.resizeRight),
    MapEntry('resizeColumn', SystemMouseCursors.resizeColumn),
    MapEntry('resizeRow', SystemMouseCursors.resizeRow),
    MapEntry('zoomIn', SystemMouseCursors.zoomIn),
    MapEntry('zoomOut', SystemMouseCursors.zoomOut),
    MapEntry('none', SystemMouseCursors.none),
  ];

  List<Widget> tiles = [];
  for (int i = 0; i < cursorEntries.length; i++) {
    MapEntry<String, MouseCursor> entry = cursorEntries[i];
    tiles.add(
      MouseRegion(
        cursor: entry.value,
        onEnter: (PointerEnterEvent event) {
          print('Cursor catalog: entered ' + entry.key);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Color(0xFF546E7A), width: 1.0),
          ),
          child: Text(
            entry.key,
            style: TextStyle(color: Colors.white70, fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  return Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: tiles,
  );
}

// Section 3: Opaque parameter comparison
Widget _buildOpaqueDemo() {
  print('render_mouse_region_test: building opaque demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'opaque: true (default) — prevents hit testing of regions behind',
        style: TextStyle(color: Colors.white60, fontSize: 12.0),
      ),
      SizedBox(height: 8.0),
      Stack(
        children: [
          MouseRegion(
            onEnter: (PointerEnterEvent event) {
              print('Opaque demo: BACK region entered (should NOT fire when opaque front is present)');
            },
            child: Container(
              width: 300.0,
              height: 80.0,
              color: Color(0xFF880E4F),
              alignment: Alignment.center,
              child: Text('Back region', style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            left: 50.0,
            top: 10.0,
            child: MouseRegion(
              opaque: true,
              cursor: SystemMouseCursors.click,
              onEnter: (PointerEnterEvent event) {
                print('Opaque demo: FRONT region entered (opaque: true)');
              },
              child: Container(
                width: 200.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text('Front (opaque: true)', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.0),
      Text(
        'opaque: false — allows hit testing to pass through to regions behind',
        style: TextStyle(color: Colors.white60, fontSize: 12.0),
      ),
      SizedBox(height: 8.0),
      Stack(
        children: [
          MouseRegion(
            onEnter: (PointerEnterEvent event) {
              print('Opaque demo: BACK region entered (can fire when front is opaque: false)');
            },
            child: Container(
              width: 300.0,
              height: 80.0,
              color: Color(0xFF1A237E),
              alignment: Alignment.center,
              child: Text('Back region', style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            left: 50.0,
            top: 10.0,
            child: MouseRegion(
              opaque: false,
              cursor: SystemMouseCursors.help,
              onEnter: (PointerEnterEvent event) {
                print('Opaque demo: FRONT region entered (opaque: false)');
              },
              child: Container(
                width: 200.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFF3F51B5).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text('Front (opaque: false)', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

// Section 4: HitTestBehavior options
Widget _buildHitTestBehaviorDemo() {
  print('render_mouse_region_test: building hitTestBehavior demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildHitTestTile('deferToChild', HitTestBehavior.deferToChild, Color(0xFF00695C)),
      SizedBox(height: 10.0),
      _buildHitTestTile('opaque', HitTestBehavior.opaque, Color(0xFF4E342E)),
      SizedBox(height: 10.0),
      _buildHitTestTile('translucent', HitTestBehavior.translucent, Color(0xFF37474F)),
    ],
  );
}

Widget _buildHitTestTile(String label, HitTestBehavior behavior, Color bgColor) {
  return MouseRegion(
    hitTestBehavior: behavior,
    cursor: SystemMouseCursors.click,
    onEnter: (PointerEnterEvent event) {
      print('HitTestBehavior demo: entered region with behavior=' + label);
    },
    onHover: (PointerHoverEvent event) {
      print('HitTestBehavior demo: hover in ' + label + ' at ' + event.localPosition.toString());
    },
    onExit: (PointerExitEvent event) {
      print('HitTestBehavior demo: exited region with behavior=' + label);
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white24, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HitTestBehavior.' + label,
            style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            label == 'deferToChild'
                ? 'Only child receives hit test events'
                : label == 'opaque'
                    ? 'Region absorbs all events even in empty areas'
                    : 'Region receives events but also passes them through',
            style: TextStyle(color: Colors.white54, fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
}

// Section 5: Nested MouseRegions
Widget _buildNestedMouseRegions() {
  print('render_mouse_region_test: building nested mouse regions');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B1B2F),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outer: grab cursor — Inner: text cursor — Innermost: click cursor',
          style: TextStyle(color: Colors.white60, fontSize: 12.0),
        ),
        SizedBox(height: 12.0),
        MouseRegion(
          cursor: SystemMouseCursors.grab,
          onEnter: (PointerEnterEvent event) {
            print('Nested: entered OUTER (grab cursor)');
          },
          onExit: (PointerExitEvent event) {
            print('Nested: exited OUTER');
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFF162447),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0xFF1F4068), width: 2.0),
            ),
            child: Column(
              children: [
                Text('Outer — grab cursor', style: TextStyle(color: Colors.white54, fontSize: 12.0)),
                SizedBox(height: 12.0),
                MouseRegion(
                  cursor: SystemMouseCursors.text,
                  onEnter: (PointerEnterEvent event) {
                    print('Nested: entered MIDDLE (text cursor)');
                  },
                  onExit: (PointerExitEvent event) {
                    print('Nested: exited MIDDLE');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF1F4068),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Color(0xFFE43F5A), width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Text('Middle — text cursor', style: TextStyle(color: Colors.white54, fontSize: 12.0)),
                        SizedBox(height: 12.0),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (PointerEnterEvent event) {
                            print('Nested: entered INNERMOST (click cursor)');
                          },
                          onExit: (PointerExitEvent event) {
                            print('Nested: exited INNERMOST');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE43F5A),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'Innermost — click cursor (wins)',
                              style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'The innermost cursor takes priority over parent cursors',
          style: TextStyle(color: Colors.white38, fontSize: 11.0, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// Section 6: MouseRegion with InkWell and GestureDetector
Widget _buildWithInkWellAndGesture() {
  print('render_mouse_region_test: building InkWell/GestureDetector combos');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // MouseRegion wrapping InkWell
      MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (PointerEnterEvent event) {
          print('MouseRegion+InkWell: mouse entered');
        },
        onExit: (PointerExitEvent event) {
          print('MouseRegion+InkWell: mouse exited');
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('MouseRegion+InkWell: tapped!');
            },
            splashColor: Color(0x44FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF004D40),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'MouseRegion wrapping InkWell — tap and hover both work',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 12.0),
      // MouseRegion wrapping GestureDetector
      MouseRegion(
        cursor: SystemMouseCursors.grab,
        onHover: (PointerHoverEvent event) {
          print('MouseRegion+GestureDetector: hovering at ' + event.localPosition.toString());
        },
        child: GestureDetector(
          onTap: () {
            print('MouseRegion+GestureDetector: tapped!');
          },
          onLongPress: () {
            print('MouseRegion+GestureDetector: long pressed!');
          },
          onDoubleTap: () {
            print('MouseRegion+GestureDetector: double tapped!');
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF311B92),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0xFF7C4DFF), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MouseRegion wrapping GestureDetector',
                  style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Supports tap, double-tap, long press + hover tracking',
                  style: TextStyle(color: Colors.white54, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12.0),
      // GestureDetector wrapping MouseRegion
      GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          print('GestureDetector+MouseRegion: pan delta=' + details.delta.toString());
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.move,
          onEnter: (PointerEnterEvent event) {
            print('GestureDetector+MouseRegion: entered draggable zone');
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFBF360C),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'GestureDetector wrapping MouseRegion — drag + move cursor',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 7: Custom hover effects
Widget _buildCustomHoverEffects() {
  print('render_mouse_region_test: building custom hover effects');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Hover card with elevation illusion
      MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (PointerEnterEvent event) {
          print('Hover card: entered — would elevate in stateful widget');
        },
        onExit: (PointerExitEvent event) {
          print('Hover card: exited — would de-elevate');
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF283593)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hover Elevation Card',
                style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.0),
              Text(
                'In a stateful widget this would animate elevation on hover',
                style: TextStyle(color: Colors.white60, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.0),
      // Row of hover buttons
      Row(
        children: [
          Expanded(child: _buildHoverButton('Primary', Color(0xFF1565C0), SystemMouseCursors.click)),
          SizedBox(width: 8.0),
          Expanded(child: _buildHoverButton('Secondary', Color(0xFF6A1B9A), SystemMouseCursors.click)),
          SizedBox(width: 8.0),
          Expanded(child: _buildHoverButton('Danger', Color(0xFFC62828), SystemMouseCursors.forbidden)),
          SizedBox(width: 8.0),
          Expanded(child: _buildHoverButton('Disabled', Color(0xFF424242), SystemMouseCursors.basic)),
        ],
      ),
      SizedBox(height: 12.0),
      // Hover underline text link
      MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (PointerEnterEvent event) {
          print('Hover link: entered — would show underline');
        },
        onExit: (PointerExitEvent event) {
          print('Hover link: exited — would hide underline');
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Hover link — would underline on hover in stateful widget',
            style: TextStyle(
              color: Color(0xFF42A5F5),
              fontSize: 14.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildHoverButton(String label, Color color, MouseCursor cursor) {
  return MouseRegion(
    cursor: cursor,
    onEnter: (PointerEnterEvent event) {
      print('Hover button [' + label + ']: entered');
    },
    onExit: (PointerExitEvent event) {
      print('Hover button [' + label + ']: exited');
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

// Section 8: Cursor zones — interactive map regions
Widget _buildCursorZones() {
  print('render_mouse_region_test: building cursor zones');
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF16213E), width: 2.0),
    ),
    padding: EdgeInsets.all(4.0),
    child: Column(
      children: [
        // Top row of zones
        Row(
          children: [
            Expanded(child: _buildZoneTile('Resize NW', SystemMouseCursors.resizeUpLeftDownRight, Color(0xFF0F3460))),
            Expanded(child: _buildZoneTile('Resize N', SystemMouseCursors.resizeUp, Color(0xFF16213E))),
            Expanded(child: _buildZoneTile('Resize NE', SystemMouseCursors.resizeUpRightDownLeft, Color(0xFF0F3460))),
          ],
        ),
        // Middle row
        Row(
          children: [
            Expanded(child: _buildZoneTile('Resize W', SystemMouseCursors.resizeLeft, Color(0xFF16213E))),
            Expanded(child: _buildZoneTile('Move', SystemMouseCursors.move, Color(0xFFE94560))),
            Expanded(child: _buildZoneTile('Resize E', SystemMouseCursors.resizeRight, Color(0xFF16213E))),
          ],
        ),
        // Bottom row
        Row(
          children: [
            Expanded(child: _buildZoneTile('Resize SW', SystemMouseCursors.resizeUpRightDownLeft, Color(0xFF0F3460))),
            Expanded(child: _buildZoneTile('Resize S', SystemMouseCursors.resizeDown, Color(0xFF16213E))),
            Expanded(child: _buildZoneTile('Resize SE', SystemMouseCursors.resizeUpLeftDownRight, Color(0xFF0F3460))),
          ],
        ),
      ],
    ),
  );
}

Widget _buildZoneTile(String label, MouseCursor cursor, Color bgColor) {
  return MouseRegion(
    cursor: cursor,
    onEnter: (PointerEnterEvent event) {
      print('Zone [' + label + ']: entered');
    },
    onHover: (PointerHoverEvent event) {
      // Intentionally verbose for demo
      print('Zone [' + label + ']: hover at ' + event.localPosition.toString());
    },
    onExit: (PointerExitEvent event) {
      print('Zone [' + label + ']: exited');
    },
    child: Container(
      height: 60.0,
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: Colors.white70, fontSize: 10.0),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// Section 9: Practical patterns
Widget _buildPracticalPatterns() {
  print('render_mouse_region_test: building practical patterns');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Pattern: toolbar with hover feedback
      Text('Toolbar with cursor feedback:', style: TextStyle(color: Colors.white60, fontSize: 12.0)),
      SizedBox(height: 8.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            _buildToolbarItem(Icons.edit, 'Edit', SystemMouseCursors.click),
            _buildToolbarItem(Icons.zoom_in, 'Zoom', SystemMouseCursors.zoomIn),
            _buildToolbarItem(Icons.pan_tool, 'Pan', SystemMouseCursors.grab),
            _buildToolbarItem(Icons.crop, 'Crop', SystemMouseCursors.precise),
            _buildToolbarItem(Icons.text_fields, 'Text', SystemMouseCursors.text),
            _buildToolbarItem(Icons.delete, 'Delete', SystemMouseCursors.forbidden),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Pattern: data grid with resizable columns
      Text('Data grid header with resize cursors:', style: TextStyle(color: Colors.white60, fontSize: 12.0)),
      SizedBox(height: 8.0),
      Row(
        children: [
          _buildGridHeader(label: 'Name', flex: 3),
          _buildGridDivider(),
          _buildGridHeader(label: 'Type', flex: 2),
          _buildGridDivider(),
          _buildGridHeader(label: 'Size', flex: 1),
          _buildGridDivider(),
          _buildGridHeader(label: 'Modified', flex: 2),
        ],
      ),
      SizedBox(height: 16.0),
      // Pattern: split pane handle
      Text('Split pane drag handle:', style: TextStyle(color: Colors.white60, fontSize: 12.0)),
      SizedBox(height: 8.0),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Left pane', style: TextStyle(color: Colors.white54, fontSize: 12.0)),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            onEnter: (PointerEnterEvent event) {
              print('Split pane: entered drag handle');
            },
            onExit: (PointerExitEvent event) {
              print('Split pane: exited drag handle');
            },
            child: Container(
              width: 8.0,
              height: 60.0,
              color: Color(0xFF00BCD4),
            ),
          ),
          Expanded(
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Right pane', style: TextStyle(color: Colors.white54, fontSize: 12.0)),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.0),
      // Pattern: progress bar with tooltip-like hover
      Text('Progress bar with hover zone:', style: TextStyle(color: Colors.white60, fontSize: 12.0)),
      SizedBox(height: 8.0),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (PointerHoverEvent event) {
          double fraction = event.localPosition.dx / 300.0;
          if (fraction < 0.0) {
            fraction = 0.0;
          }
          if (fraction > 1.0) {
            fraction = 1.0;
          }
          int percent = (fraction * 100).toInt();
          print('Progress hover: ' + percent.toString() + '%');
        },
        child: Container(
          width: 300.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: Color(0xFF424242),
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 210.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00E676)],
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      // Pattern: color picker cells
      Text('Color picker with help cursor:', style: TextStyle(color: Colors.white60, fontSize: 12.0)),
      SizedBox(height: 8.0),
      Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: _buildColorPickerCells(),
      ),
    ],
  );
}

Widget _buildToolbarItem(IconData icon, String tooltip, MouseCursor cursor) {
  return MouseRegion(
    cursor: cursor,
    onEnter: (PointerEnterEvent event) {
      print('Toolbar: hovering over ' + tooltip);
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Color(0xFF333333),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Icon(icon, color: Colors.white70, size: 20.0),
      ),
    ),
  );
}

Widget _buildGridHeader({required String label, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (PointerEnterEvent event) {
        print('Grid header: entered ' + label);
      },
      child: Container(
        height: 36.0,
        color: Color(0xFF2C2C2C),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 8.0),
        child: Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget _buildGridDivider() {
  return MouseRegion(
    cursor: SystemMouseCursors.resizeColumn,
    onEnter: (PointerEnterEvent event) {
      print('Grid divider: entered — would start column resize');
    },
    child: Container(
      width: 4.0,
      height: 36.0,
      color: Color(0xFF555555),
    ),
  );
}

List<Widget> _buildColorPickerCells() {
  List<Color> colors = [
    Color(0xFFE53935),
    Color(0xFFD81B60),
    Color(0xFF8E24AA),
    Color(0xFF5E35B1),
    Color(0xFF3949AB),
    Color(0xFF1E88E5),
    Color(0xFF039BE5),
    Color(0xFF00ACC1),
    Color(0xFF00897B),
    Color(0xFF43A047),
    Color(0xFF7CB342),
    Color(0xFFC0CA33),
    Color(0xFFFDD835),
    Color(0xFFFFB300),
    Color(0xFFFB8C00),
    Color(0xFFF4511E),
  ];

  List<Widget> cells = [];
  for (int i = 0; i < colors.length; i++) {
    Color c = colors[i];
    cells.add(
      MouseRegion(
        cursor: SystemMouseCursors.precise,
        onEnter: (PointerEnterEvent event) {
          print('Color picker: entered cell #' + i.toString() + ' color=' + c.toString());
        },
        onExit: (PointerExitEvent event) {
          print('Color picker: exited cell #' + i.toString());
        },
        child: Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.white24, width: 1.0),
          ),
        ),
      ),
    );
  }
  return cells;
}
