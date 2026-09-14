// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Mouse Cursor Showcase
// Theme: "Mouse Cursor Showcase" — a richly designed catalogue of MouseRegion,
// SystemMouseCursors variants, MaterialStateMouseCursor / WidgetStateMouseCursor,
// and hitTestBehavior patterns. Each card visualises the cursor type using
// descriptive icons because the actual OS cursor only appears on real mouseover.
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE — A copper / teal / plum palette unique to this showcase.
// ============================================================================
const Color kInk = Color(0xFF1A1124);
const Color kBackdrop = Color(0xFFFBF7F2);
const Color kCopper = Color(0xFFC65F2E);
const Color kCopperSoft = Color(0xFFFFE3D2);
const Color kTeal = Color(0xFF1F6F7B);
const Color kTealSoft = Color(0xFFD2ECEF);
const Color kPlum = Color(0xFF6B3B7A);
const Color kPlumSoft = Color(0xFFE9D9EF);
const Color kSaffron = Color(0xFFE0A82E);
const Color kSaffronSoft = Color(0xFFFBEFCB);
const Color kForest = Color(0xFF3F7A4F);
const Color kForestSoft = Color(0xFFD8E9D9);
const Color kCrimson = Color(0xFFB23A48);
const Color kCrimsonSoft = Color(0xFFF6D9DD);
const Color kIndigo = Color(0xFF334B7D);
const Color kIndigoSoft = Color(0xFFD9DEEB);
const Color kSlate = Color(0xFF4A5563);
const Color kSlateSoft = Color(0xFFE3E6EA);

// ============================================================================
// HELPER: Hero header banner
// ============================================================================
Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 34.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPlum, kTeal, kCopper],
      ),
      boxShadow: [
        BoxShadow(
          color: kInk.withOpacity(0.28),
          blurRadius: 18.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: Colors.white.withOpacity(0.45), width: 1.4),
              ),
              child: Icon(Icons.mouse_outlined,
                  color: Colors.white, size: 34.0),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mouse Cursor Showcase',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3)),
                  SizedBox(height: 4.0),
                  Text(
                      'A field guide to MouseRegion, SystemMouseCursors, and state-aware cursors',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 22.0),
        Wrap(spacing: 8.0, runSpacing: 8.0, children: [
          _heroChip('MouseRegion'),
          _heroChip('SystemMouseCursors'),
          _heroChip('SystemMouseCursor'),
          _heroChip('MaterialStateMouseCursor'),
          _heroChip('WidgetStateMouseCursor'),
          _heroChip('MouseCursor.defer'),
          _heroChip('MouseCursor.uncontrolled'),
          _heroChip('hitTestBehavior'),
          _heroChip('opaqueLayer'),
        ]),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withOpacity(0.30)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.white.withOpacity(0.92), size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                    'Cursors only render under a physical pointer device. Each card '
                    'uses an icon medallion as a visual stand-in.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        height: 1.4)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.24),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withOpacity(0.40), width: 1.0),
    ),
    child: Text(label,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace')),
  );
}

// ============================================================================
// HELPER: Section banner
// ============================================================================
Widget _sectionBanner(int n, String title, String subtitle, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
    margin: EdgeInsets.only(top: 24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [accent, accent.withOpacity(0.62)],
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.24),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.white, width: 1.6),
          ),
          child: Text(n.toString().padLeft(2, '0'),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0)),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w900)),
              SizedBox(height: 3.0),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Icon(Icons.mouse,
            color: Colors.white.withOpacity(0.85), size: 28.0),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Cursor card — icon medallion + label + description, wrapped in
// MouseRegion. The icon is the visual stand-in for the actual OS cursor.
// ============================================================================
Widget _cursorCard({
  required IconData icon,
  required String title,
  required String cursorName,
  required String description,
  required MouseCursor cursor,
  required Color accent,
  Color? medallionColor,
}) {
  final medallion = medallionColor ?? accent;
  return MouseRegion(
    cursor: cursor,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: accent.withOpacity(0.40), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.12),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon medallion
          Container(
            width: 64.0,
            height: 64.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [medallion, medallion.withOpacity(0.55)],
              ),
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: [
                BoxShadow(
                  color: medallion.withOpacity(0.45),
                  blurRadius: 8.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32.0),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: kInk,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 3.0),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(cursorName,
                      style: TextStyle(
                          color: accent,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace')),
                ),
                SizedBox(height: 8.0),
                Text(description,
                    style: TextStyle(
                        color: kInk.withOpacity(0.78),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1.42)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER: Recipe code-quote card
// ============================================================================
Widget _recipeCard(
    String title, String description, List<String> snippet, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.22),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(13.0)),
          ),
          child: Row(children: [
            Icon(Icons.terminal, color: accent, size: 18.0),
            SizedBox(width: 9.0),
            Expanded(
              child: Text('Recipe: $title',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800)),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Text(description,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.78),
                  fontSize: 12.0,
                  height: 1.45,
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF0D0814),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withOpacity(0.32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: snippet
                .map((line) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5),
                      child: Text(line,
                          style: TextStyle(
                              color: accent.withOpacity(0.96),
                              fontSize: 11.0,
                              fontFamily: 'monospace',
                              height: 1.35)),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Comparison table
// ============================================================================
Widget _comparisonTable(
    String title, List<List<String>> rows, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withOpacity(0.55), width: 1.0),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.16),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(13.0)),
          ),
          child: Row(children: [
            Icon(Icons.table_chart_outlined, color: accent, size: 18.0),
            SizedBox(width: 9.0),
            Text(title,
                style: TextStyle(
                    color: kInk,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800)),
          ]),
        ),
        ...rows.asMap().entries.map((entry) {
          final idx = entry.key;
          final row = entry.value;
          final isHeader = idx == 0;
          return Container(
            padding:
                EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isHeader
                  ? accent.withOpacity(0.07)
                  : (idx.isEven ? Color(0xFFF7F4EE) : Colors.white),
              border: Border(
                top: BorderSide(color: Color(0xFFE6E1D8), width: 0.5),
              ),
            ),
            child: Row(
              children: row
                  .map((cell) => Expanded(
                        child: Text(cell,
                            style: TextStyle(
                                color: isHeader ? accent : kInk,
                                fontSize: 11.5,
                                fontWeight: isHeader
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                fontFamily:
                                    isHeader ? null : 'monospace')),
                      ))
                  .toList(),
            ),
          );
        }),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Concept overview block
// ============================================================================
Widget _conceptOverview() {
  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kBackdrop,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE0D6C5), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.menu_book_outlined, color: kPlum, size: 22.0),
          SizedBox(width: 10.0),
          Text('Concept Overview',
              style: TextStyle(
                  color: kInk,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 12.0),
        Text(
            'Flutter renders cursors via the MouseRegion widget. A MouseRegion '
            'wraps any subtree and declares which MouseCursor should be shown '
            'while the pointer hovers inside its bounds. The cursor is chosen '
            'from a deep stack — innermost MouseRegion wins unless it opts to '
            'defer via MouseCursor.defer.',
            style: TextStyle(
                color: kInk.withOpacity(0.84),
                fontSize: 13.5,
                height: 1.5)),
        SizedBox(height: 14.0),
        _bulletLine(Icons.adjust, kCopper,
            'SystemMouseCursors exposes 30+ named predefined cursors.'),
        _bulletLine(Icons.layers, kTeal,
            'MouseRegion nests like a Stack — innermost cursor wins.'),
        _bulletLine(Icons.swap_calls, kPlum,
            'MouseCursor.defer hands off control to the next region.'),
        _bulletLine(Icons.toggle_on, kSaffron,
            'MaterialStateMouseCursor reacts to pressed / hovered / disabled.'),
        _bulletLine(Icons.touch_app, kForest,
            'HitTestBehavior controls whether the region is hit-testable.'),
        _bulletLine(Icons.block, kCrimson,
            'MouseCursor.uncontrolled leaves the cursor untouched.'),
      ],
    ),
  );
}

Widget _bulletLine(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.only(top: 7.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Icon(icon, color: color, size: 14.0),
        ),
        SizedBox(width: 11.0),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: CURSOR PRIMITIVES — defer, uncontrolled, basic, none
// ============================================================================
Widget _section1() {
  final accent = kSlate;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(1, 'Cursor Primitives',
          'The atomic building blocks of cursor behaviour', accent),
      _cursorCard(
        icon: Icons.arrow_upward,
        title: 'Default Pointer',
        cursorName: 'SystemMouseCursors.basic',
        description:
            'The standard arrow cursor. Default for almost every widget that '
            'does not opt into a more specific cursor.',
        cursor: SystemMouseCursors.basic,
        accent: accent,
        medallionColor: kSlate,
      ),
      _cursorCard(
        icon: Icons.visibility_off_outlined,
        title: 'Hidden Cursor',
        cursorName: 'SystemMouseCursors.none',
        description:
            'Removes the cursor entirely. Useful for fullscreen video '
            'playback, kiosk-mode apps, or game canvases.',
        cursor: SystemMouseCursors.none,
        accent: accent,
        medallionColor: kInk,
      ),
      _cursorCard(
        icon: Icons.skip_next_outlined,
        title: 'Deferred Cursor',
        cursorName: 'MouseCursor.defer',
        description:
            'Yields the cursor decision to the next MouseRegion in the stack. '
            'Useful when a wrapper widget should never override its child.',
        cursor: MouseCursor.defer,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.cancel_outlined,
        title: 'Uncontrolled',
        cursorName: 'MouseCursor.uncontrolled',
        description:
            'Leaves whatever cursor is currently set untouched. Embedded '
            'platform views often use this to let native widgets manage cursors.',
        cursor: MouseCursor.uncontrolled,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _recipeCard(
        'Primitive cursor playground',
        'Combine the four primitives to compose layered cursor logic.',
        [
          'MouseRegion(',
          '  cursor: MouseCursor.defer,',
          '  child: MouseRegion(',
          '    cursor: SystemMouseCursors.basic,',
          '    child: child,',
          '  ),',
          ')',
        ],
        accent,
      ),
      _comparisonTable(
        'Cursor primitive matrix',
        [
          ['Cursor', 'Visual Effect', 'Stops Cascade'],
          ['SystemMouseCursors.basic', 'Arrow', 'yes'],
          ['SystemMouseCursors.none', 'Hidden', 'yes'],
          ['MouseCursor.defer', 'Passes through', 'no'],
          ['MouseCursor.uncontrolled', 'Untouched', 'no'],
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 2: BASIC / CLICK / FORBIDDEN CURSORS
// ============================================================================
Widget _section2() {
  final accent = kCopper;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(2, 'Basic / Click / Forbidden',
          'Foundational interactive cursors', accent),
      _cursorCard(
        icon: Icons.touch_app,
        title: 'Click (Hand)',
        cursorName: 'SystemMouseCursors.click',
        description:
            'The hand-pointer cursor. Signals "this is clickable" — use for '
            'buttons, links, and any other tappable affordance.',
        cursor: SystemMouseCursors.click,
        accent: accent,
        medallionColor: kCopper,
      ),
      _cursorCard(
        icon: Icons.do_disturb_alt,
        title: 'Forbidden',
        cursorName: 'SystemMouseCursors.forbidden',
        description:
            'A "no entry" sign — communicates that the action is not allowed '
            'at this position. Common for disabled drop targets.',
        cursor: SystemMouseCursors.forbidden,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _cursorCard(
        icon: Icons.hourglass_empty,
        title: 'Wait',
        cursorName: 'SystemMouseCursors.wait',
        description:
            'A spinning or hourglass cursor — the app is busy and the user '
            'should wait before interacting further.',
        cursor: SystemMouseCursors.wait,
        accent: accent,
        medallionColor: kSaffron,
      ),
      _cursorCard(
        icon: Icons.timelapse,
        title: 'Progress',
        cursorName: 'SystemMouseCursors.progress',
        description:
            'A working-in-the-background cursor — usually an arrow with a small '
            'spinner overlay. The UI is still responsive but a task is running.',
        cursor: SystemMouseCursors.progress,
        accent: accent,
        medallionColor: kIndigo,
      ),
      _cursorCard(
        icon: Icons.help_outline,
        title: 'Help',
        cursorName: 'SystemMouseCursors.help',
        description:
            'An arrow with a question-mark hint — used for contextual help '
            'affordances, "what is this?" interactions, and tooltips.',
        cursor: SystemMouseCursors.help,
        accent: accent,
        medallionColor: kTeal,
      ),
      _recipeCard(
        'Disabled vs forbidden vs disabled+forbidden',
        'Combine cursors with state to convey "you cannot click this".',
        [
          'MouseRegion(',
          '  cursor: enabled',
          '    ? SystemMouseCursors.click',
          '    : SystemMouseCursors.forbidden,',
          '  child: GestureDetector(',
          '    onTap: enabled ? () => fire() : null,',
          '    child: const ButtonChrome(),',
          '  ),',
          ')',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 3: TEXT CURSORS
// ============================================================================
Widget _section3() {
  final accent = kTeal;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(3, 'Text Cursors',
          'I-beam variants for editable and selectable regions', accent),
      _cursorCard(
        icon: Icons.text_fields,
        title: 'Text I-Beam',
        cursorName: 'SystemMouseCursors.text',
        description:
            'The classic I-beam cursor used over editable or selectable text. '
            'Signals "you can place a caret or select text here".',
        cursor: SystemMouseCursors.text,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.swap_vert,
        title: 'Vertical Text',
        cursorName: 'SystemMouseCursors.verticalText',
        description:
            'A horizontal I-beam used over vertically-laid-out text such as '
            'Japanese tategaki or rotated labels.',
        cursor: SystemMouseCursors.verticalText,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.grid_4x4,
        title: 'Cell',
        cursorName: 'SystemMouseCursors.cell',
        description:
            'A small crosshair used to select a single grid cell — common in '
            'spreadsheet UIs and tabular editors.',
        cursor: SystemMouseCursors.cell,
        accent: accent,
        medallionColor: kForest,
      ),
      _cursorCard(
        icon: Icons.center_focus_strong,
        title: 'Precise',
        cursorName: 'SystemMouseCursors.precise',
        description:
            'A crosshair cursor for pixel-precision tasks: drawing, image '
            'editors, selection rectangles, or coordinate picking.',
        cursor: SystemMouseCursors.precise,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _recipeCard(
        'A simple inline text editor row',
        'A Row with mixed selectable, editable, and read-only spans.',
        [
          'Row(children: [',
          '  MouseRegion(cursor: SystemMouseCursors.text,',
          '    child: SelectableText("hello")),',
          '  MouseRegion(cursor: SystemMouseCursors.text,',
          '    child: TextField()),',
          '  MouseRegion(cursor: SystemMouseCursors.basic,',
          '    child: Text("read only")),',
          '])',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 4: GRAB & DRAG CURSORS
// ============================================================================
Widget _section4() {
  final accent = kSaffron;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(4, 'Grab & Drag Cursors',
          'Open and closed hands for grab gestures', accent),
      _cursorCard(
        icon: Icons.pan_tool_outlined,
        title: 'Grab (Open Hand)',
        cursorName: 'SystemMouseCursors.grab',
        description:
            'An open hand — the element under the cursor can be picked up '
            'and dragged. Use on slider thumbs, list reorder handles, etc.',
        cursor: SystemMouseCursors.grab,
        accent: accent,
        medallionColor: kSaffron,
      ),
      _cursorCard(
        icon: Icons.back_hand,
        title: 'Grabbing (Closed Hand)',
        cursorName: 'SystemMouseCursors.grabbing',
        description:
            'A closed fist — the user is currently dragging. Toggle to this '
            'on pointerDown while a grab is in progress.',
        cursor: SystemMouseCursors.grabbing,
        accent: accent,
        medallionColor: kCopper,
      ),
      _cursorCard(
        icon: Icons.open_with,
        title: 'Move',
        cursorName: 'SystemMouseCursors.move',
        description:
            'A four-directional arrow — the element can be moved freely in '
            'any direction. Common for canvas viewport panning.',
        cursor: SystemMouseCursors.move,
        accent: accent,
        medallionColor: kIndigo,
      ),
      _cursorCard(
        icon: Icons.swap_horiz_outlined,
        title: 'All Scroll',
        cursorName: 'SystemMouseCursors.allScroll',
        description:
            'The "scroll in any direction" cursor — typically a four-arrow '
            'star. Used during middle-button autoscroll modes.',
        cursor: SystemMouseCursors.allScroll,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.block,
        title: 'No Drop',
        cursorName: 'SystemMouseCursors.noDrop',
        description:
            'Currently dragging, but this drop target rejects the payload. '
            'A closed hand with a "no entry" badge.',
        cursor: SystemMouseCursors.noDrop,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _cursorCard(
        icon: Icons.disabled_by_default_outlined,
        title: 'Disappearing',
        cursorName: 'SystemMouseCursors.disappearing',
        description:
            'A drag-vanish cursor — signals that releasing here will cause '
            'the dragged item to be discarded. Web-only on most platforms.',
        cursor: SystemMouseCursors.disappearing,
        accent: accent,
        medallionColor: kSlate,
      ),
    ],
  );
}

// ============================================================================
// SECTION 5: RESIZE CURSORS — horizontal / vertical / diagonal
// ============================================================================
Widget _section5() {
  final accent = kPlum;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(5, 'Resize Cursors',
          'Edge and corner resize affordances for panels and elements',
          accent),
      _cursorCard(
        icon: Icons.height,
        title: 'Resize Column',
        cursorName: 'SystemMouseCursors.resizeColumn',
        description:
            'A horizontal double-headed arrow for column-width resizing in '
            'tables and split panes.',
        cursor: SystemMouseCursors.resizeColumn,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.swap_vert,
        title: 'Resize Row',
        cursorName: 'SystemMouseCursors.resizeRow',
        description:
            'A vertical double-headed arrow for row-height resizing in '
            'tables and stacked panels.',
        cursor: SystemMouseCursors.resizeRow,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.unfold_more,
        title: 'Resize Up/Down',
        cursorName: 'SystemMouseCursors.resizeUpDown',
        description:
            'A vertical resize cursor that emphasises a top↔bottom edge.',
        cursor: SystemMouseCursors.resizeUpDown,
        accent: accent,
        medallionColor: kCopper,
      ),
      _cursorCard(
        icon: Icons.unfold_more,
        title: 'Resize Left/Right',
        cursorName: 'SystemMouseCursors.resizeLeftRight',
        description:
            'A horizontal resize cursor that emphasises a left↔right edge.',
        cursor: SystemMouseCursors.resizeLeftRight,
        accent: accent,
        medallionColor: kSaffron,
      ),
      _cursorCard(
        icon: Icons.north,
        title: 'Resize Up',
        cursorName: 'SystemMouseCursors.resizeUp',
        description:
            'Single-direction up-resize cursor — used on the top edge of '
            'resizable panels.',
        cursor: SystemMouseCursors.resizeUp,
        accent: accent,
        medallionColor: kForest,
      ),
      _cursorCard(
        icon: Icons.south,
        title: 'Resize Down',
        cursorName: 'SystemMouseCursors.resizeDown',
        description:
            'Single-direction down-resize cursor for the bottom edge of a '
            'resizable panel.',
        cursor: SystemMouseCursors.resizeDown,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _cursorCard(
        icon: Icons.west,
        title: 'Resize Left',
        cursorName: 'SystemMouseCursors.resizeLeft',
        description:
            'Single-direction left-resize cursor for the left edge of a '
            'resizable element.',
        cursor: SystemMouseCursors.resizeLeft,
        accent: accent,
        medallionColor: kIndigo,
      ),
      _cursorCard(
        icon: Icons.east,
        title: 'Resize Right',
        cursorName: 'SystemMouseCursors.resizeRight',
        description:
            'Single-direction right-resize cursor for the right edge of a '
            'resizable element.',
        cursor: SystemMouseCursors.resizeRight,
        accent: accent,
        medallionColor: kSlate,
      ),
      _cursorCard(
        icon: Icons.north_west,
        title: 'Resize Up-Left',
        cursorName: 'SystemMouseCursors.resizeUpLeft',
        description:
            'A diagonal NW resize cursor — points toward the top-left corner '
            'of a resizable element.',
        cursor: SystemMouseCursors.resizeUpLeft,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.north_east,
        title: 'Resize Up-Right',
        cursorName: 'SystemMouseCursors.resizeUpRight',
        description:
            'A diagonal NE resize cursor — points toward the top-right corner '
            'of a resizable element.',
        cursor: SystemMouseCursors.resizeUpRight,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.south_west,
        title: 'Resize Down-Left',
        cursorName: 'SystemMouseCursors.resizeDownLeft',
        description:
            'A diagonal SW resize cursor — points toward the bottom-left corner '
            'of a resizable element.',
        cursor: SystemMouseCursors.resizeDownLeft,
        accent: accent,
        medallionColor: kCopper,
      ),
      _cursorCard(
        icon: Icons.south_east,
        title: 'Resize Down-Right',
        cursorName: 'SystemMouseCursors.resizeDownRight',
        description:
            'A diagonal SE resize cursor — points toward the bottom-right corner '
            'of a resizable element.',
        cursor: SystemMouseCursors.resizeDownRight,
        accent: accent,
        medallionColor: kSaffron,
      ),
      _cursorCard(
        icon: Icons.compare_arrows,
        title: 'Resize NW↔SE Diagonal',
        cursorName: 'SystemMouseCursors.resizeUpLeftDownRight',
        description:
            'A double-headed diagonal arrow pointing both NW and SE — for '
            'corner resize handles that work along the principal diagonal.',
        cursor: SystemMouseCursors.resizeUpLeftDownRight,
        accent: accent,
        medallionColor: kForest,
      ),
      _cursorCard(
        icon: Icons.compare_arrows,
        title: 'Resize NE↔SW Diagonal',
        cursorName: 'SystemMouseCursors.resizeUpRightDownLeft',
        description:
            'A double-headed diagonal arrow pointing both NE and SW — for '
            'corner resize handles along the anti-diagonal.',
        cursor: SystemMouseCursors.resizeUpRightDownLeft,
        accent: accent,
        medallionColor: kCrimson,
      ),
    ],
  );
}

// ============================================================================
// SECTION 6: ZOOM CURSORS
// ============================================================================
Widget _section6() {
  final accent = kForest;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(6, 'Zoom Cursors',
          'Magnifier-with-plus and magnifier-with-minus', accent),
      _cursorCard(
        icon: Icons.zoom_in,
        title: 'Zoom In',
        cursorName: 'SystemMouseCursors.zoomIn',
        description:
            'A magnifier with a "+" sign — clicking will zoom into the '
            'pointed-at location. Common for image viewers and map UIs.',
        cursor: SystemMouseCursors.zoomIn,
        accent: accent,
        medallionColor: kForest,
      ),
      _cursorCard(
        icon: Icons.zoom_out,
        title: 'Zoom Out',
        cursorName: 'SystemMouseCursors.zoomOut',
        description:
            'A magnifier with a "−" sign — clicking will zoom out of the '
            'current view. Often paired with Alt-modifier zoom-in.',
        cursor: SystemMouseCursors.zoomOut,
        accent: accent,
        medallionColor: kTeal,
      ),
      _recipeCard(
        'Modifier-aware zoom cursor',
        'Toggle between zoom-in and zoom-out based on the Alt key.',
        [
          'final cursor = altPressed',
          '    ? SystemMouseCursors.zoomOut',
          '    : SystemMouseCursors.zoomIn;',
          'return MouseRegion(',
          '  cursor: cursor,',
          '  child: const PictureViewer(),',
          ');',
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 7: HELP / CONTEXTUAL CURSORS
// ============================================================================
Widget _section7() {
  final accent = kIndigo;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(7, 'Help & Contextual Cursors',
          'Hints, context menus, alias links, and copy drag targets', accent),
      _cursorCard(
        icon: Icons.help_center_outlined,
        title: 'Help',
        cursorName: 'SystemMouseCursors.help',
        description:
            'An arrow with a question mark — communicates that hovering will '
            'reveal contextual help or that clicking opens a help dialog.',
        cursor: SystemMouseCursors.help,
        accent: accent,
        medallionColor: kIndigo,
      ),
      _cursorCard(
        icon: Icons.menu_open,
        title: 'Context Menu',
        cursorName: 'SystemMouseCursors.contextMenu',
        description:
            'An arrow with a small menu badge — primary-click here will open '
            'a context menu rather than perform the default action.',
        cursor: SystemMouseCursors.contextMenu,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.share,
        title: 'Alias (Link)',
        cursorName: 'SystemMouseCursors.alias',
        description:
            'A curved-arrow alias cursor — used when dropping will create a '
            'shortcut or symbolic link, not a copy.',
        cursor: SystemMouseCursors.alias,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.content_copy,
        title: 'Copy',
        cursorName: 'SystemMouseCursors.copy',
        description:
            'Arrow with a "+" badge — signals that dropping here will copy '
            'the dragged data rather than move it.',
        cursor: SystemMouseCursors.copy,
        accent: accent,
        medallionColor: kForest,
      ),
    ],
  );
}

// ============================================================================
// SECTION 8: MaterialStateMouseCursor / WidgetStateMouseCursor
// ============================================================================
Widget _section8() {
  final accent = kCrimson;
  // MaterialStateMouseCursor is a state-aware cursor used by Material widgets
  // (Buttons, Switches, etc). The two main constants are clickable and textable.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(8, 'State-Aware Cursors',
          'MaterialStateMouseCursor & WidgetStateMouseCursor', accent),
      _cursorCard(
        icon: Icons.smart_button,
        title: 'Material clickable',
        cursorName: 'MaterialStateMouseCursor.clickable',
        description:
            'Resolves to SystemMouseCursors.click when enabled, '
            'SystemMouseCursors.basic when disabled. Used by all Material '
            'buttons internally.',
        cursor: MaterialStateMouseCursor.clickable,
        accent: accent,
        medallionColor: kCrimson,
      ),
      _cursorCard(
        icon: Icons.edit_note,
        title: 'Material textable',
        cursorName: 'MaterialStateMouseCursor.textable',
        description:
            'Resolves to SystemMouseCursors.text when enabled, '
            'SystemMouseCursors.basic when disabled. Used by TextField, '
            'SelectableText, etc.',
        cursor: MaterialStateMouseCursor.textable,
        accent: accent,
        medallionColor: kPlum,
      ),
      _cursorCard(
        icon: Icons.widgets_outlined,
        title: 'Widget clickable',
        cursorName: 'WidgetStateMouseCursor.clickable',
        description:
            'The framework-agnostic equivalent of the Material clickable cursor. '
            'Prefer this in pure widgets layers when on Flutter ≥3.13.',
        cursor: WidgetStateMouseCursor.clickable,
        accent: accent,
        medallionColor: kTeal,
      ),
      _cursorCard(
        icon: Icons.text_snippet_outlined,
        title: 'Widget textable',
        cursorName: 'WidgetStateMouseCursor.textable',
        description:
            'The framework-agnostic equivalent of the Material textable cursor.',
        cursor: WidgetStateMouseCursor.textable,
        accent: accent,
        medallionColor: kSaffron,
      ),
      _recipeCard(
        'Building a custom state-aware cursor',
        'Use resolveWith to derive a cursor from the current state-set.',
        [
          'final cursor = WidgetStateMouseCursor.resolveWith((states) {',
          '  if (states.contains(WidgetState.disabled)) {',
          '    return SystemMouseCursors.forbidden;',
          '  }',
          '  if (states.contains(WidgetState.dragged)) {',
          '    return SystemMouseCursors.grabbing;',
          '  }',
          '  return SystemMouseCursors.click;',
          '});',
        ],
        accent,
      ),
      _comparisonTable(
        'State-aware cursor matrix',
        [
          ['State', 'clickable', 'textable'],
          ['default', 'click', 'text'],
          ['disabled', 'basic', 'basic'],
          ['hovered', 'click', 'text'],
          ['pressed', 'click', 'text'],
          ['focused', 'click', 'text'],
        ],
        accent,
      ),
    ],
  );
}

// ============================================================================
// SECTION 9: MouseRegion behaviour — onEnter / onExit / onHover
// ============================================================================
Widget _section9() {
  final accent = kTeal;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(9, 'MouseRegion Behaviours',
          'onEnter, onExit, onHover, opaque, hitTestBehavior', accent),
      _behaviourCard(
        'onEnter',
        'Called once when the pointer first enters the region. Use it to '
            'preload data, start subtle hover animations, or set a "hovered" '
            'flag in the parent.',
        Icons.login,
        kTeal,
      ),
      _behaviourCard(
        'onExit',
        'Called once when the pointer leaves the region. Always pair with '
            'onEnter to ensure resources are released and hover state is reset.',
        Icons.logout,
        kCopper,
      ),
      _behaviourCard(
        'onHover',
        'Called for every pointer move event while the pointer is inside the '
            'region. Use sparingly — high frequency events can be expensive.',
        Icons.gesture,
        kPlum,
      ),
      _behaviourCard(
        'opaque',
        'When true (the default), the MouseRegion absorbs hover events from '
            'sibling regions. Set false to allow hover events to fall through.',
        Icons.layers_outlined,
        kForest,
      ),
      _behaviourCard(
        'hitTestBehavior',
        'Controls how the region participates in hit testing. opaqueLayer makes '
            'it block, translucent lets events pass to siblings, deferToChild '
            'inherits from the child.',
        Icons.crop_free,
        kCrimson,
      ),
      _behaviourCard(
        'cursor',
        'The MouseCursor to use while the pointer is inside the region. The '
            'innermost non-deferred cursor wins.',
        Icons.mouse_outlined,
        kIndigo,
      ),
      _recipeCard(
        'Tooltip-style hover card',
        'A minimal pattern that shows a tooltip when the pointer enters.',
        [
          'MouseRegion(',
          '  cursor: SystemMouseCursors.help,',
          '  onEnter: (_) => showTooltip(),',
          '  onExit: (_) => hideTooltip(),',
          '  child: const InfoIcon(),',
          ')',
        ],
        accent,
      ),
    ],
  );
}

Widget _behaviourCard(
    String name, String description, IconData icon, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent.withOpacity(0.05),
          accent.withOpacity(0.16),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withOpacity(0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(11.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: kInk,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace')),
              SizedBox(height: 6.0),
              Text(description,
                  style: TextStyle(
                      color: kInk.withOpacity(0.78),
                      fontSize: 12.5,
                      height: 1.42,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10: hitTestBehavior Patterns
// ============================================================================
Widget _section10() {
  final accent = kSaffron;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(10, 'hitTestBehavior Patterns',
          'Opaque, translucent, and deferToChild scenarios', accent),
      _hitCard(
        'opaque (default)',
        'The MouseRegion blocks pointer events from reaching siblings beneath '
            'it. Hover events stop here. This is the right default.',
        HitTestBehavior.opaque,
        Icons.layers,
        kSaffron,
      ),
      _hitCard(
        'translucent',
        'The MouseRegion still receives events, but lets them continue to '
            'sibling regions underneath. Use for cursor-only overlays.',
        HitTestBehavior.translucent,
        Icons.water_drop_outlined,
        kTeal,
      ),
      _hitCard(
        'deferToChild',
        'The MouseRegion is hit-tested only at locations where the child '
            'reports a hit. Useful for irregular shapes and CustomPaint.',
        HitTestBehavior.deferToChild,
        Icons.child_care_outlined,
        kPlum,
      ),
      _recipeCard(
        'A translucent overlay that changes cursor without blocking clicks',
        'Wrap a child in a translucent MouseRegion to add cursor behavior.',
        [
          'Stack(children: [',
          '  const ChildContent(),',
          '  Positioned.fill(',
          '    child: MouseRegion(',
          '      cursor: SystemMouseCursors.help,',
          '      hitTestBehavior: HitTestBehavior.translucent,',
          '      child: const SizedBox.expand(),',
          '    ),',
          '  ),',
          '])',
        ],
        accent,
      ),
      _comparisonTable(
        'hitTestBehavior cheat sheet',
        [
          ['Behavior', 'Receives events', 'Blocks siblings'],
          ['opaque', 'yes', 'yes'],
          ['translucent', 'yes', 'no'],
          ['deferToChild', 'only if child hits', 'only where child hits'],
        ],
        accent,
      ),
    ],
  );
}

Widget _hitCard(String name, String description, HitTestBehavior behavior,
    IconData icon, Color accent) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    hitTestBehavior: behavior,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withOpacity(0.45), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: accent, size: 22.0),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: kInk,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace')),
                SizedBox(height: 6.0),
                Text(description,
                    style: TextStyle(
                        color: kInk.withOpacity(0.80),
                        fontSize: 12.5,
                        height: 1.42,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 11: Compound Examples — splitters, drag handles, color picker
// ============================================================================
Widget _section11() {
  final accent = kPlum;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(11, 'Compound Examples',
          'Real-world combinations of cursors and regions', accent),
      _compoundSplitter(),
      _compoundReorderRow(),
      _compoundColorPicker(),
      _compoundResizableCard(),
      _compoundContextMenu(),
      _compoundLinkText(),
    ],
  );
}

Widget _compoundSplitter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kPlum.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.vertical_split_outlined, color: kPlum, size: 18.0),
          SizedBox(width: 8.0),
          Text('Vertical splitter (resizeColumn)',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 10.0),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: kPlumSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kPlum.withOpacity(0.35)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text('Left Panel',
                      style: TextStyle(
                          color: kPlum,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0)),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: Container(
                  width: 6.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: kPlum,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text('Right Panel',
                      style: TextStyle(
                          color: kPlum,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _compoundReorderRow() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kSaffron.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.reorder, color: kSaffron, size: 18.0),
          SizedBox(width: 8.0),
          Text('Reorderable list (grab → grabbing)',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 10.0),
        Column(
          children: [
            _reorderItem('Alpha', kCopper),
            _reorderItem('Bravo', kTeal),
            _reorderItem('Charlie', kPlum),
            _reorderItem('Delta', kForest),
          ],
        ),
      ],
    ),
  );
}

Widget _reorderItem(String label, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.grab,
          child: Icon(Icons.drag_handle, color: accent, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.22),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text('grab',
              style: TextStyle(
                  color: accent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

Widget _compoundColorPicker() {
  final swatches = <Color>[
    kCopper,
    kTeal,
    kPlum,
    kSaffron,
    kForest,
    kCrimson,
    kIndigo,
    kSlate,
  ];
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kTeal.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.palette_outlined, color: kTeal, size: 18.0),
          SizedBox(width: 8.0),
          Text('Color picker (precise crosshair)',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 12.0),
        MouseRegion(
          cursor: SystemMouseCursors.precise,
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: swatches,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(spacing: 8.0, runSpacing: 8.0, children: [
          for (final c in swatches)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: c.withOpacity(0.40),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
        ]),
      ],
    ),
  );
}

Widget _compoundResizableCard() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kForest.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.crop_landscape, color: kForest, size: 18.0),
          SizedBox(width: 8.0),
          Text('Resizable card (all eight handle cursors)',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 12.0),
        Stack(
          children: [
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: kForestSoft,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: kForest.withOpacity(0.45)),
              ),
              alignment: Alignment.center,
              child: Text('Drag any edge or corner',
                  style: TextStyle(
                      color: kForest,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700)),
            ),
            // Top edge
            Positioned(
              top: 0.0,
              left: 12.0,
              right: 12.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUp,
                child: Container(height: 8.0, color: Colors.transparent),
              ),
            ),
            // Bottom edge
            Positioned(
              bottom: 0.0,
              left: 12.0,
              right: 12.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeDown,
                child: Container(height: 8.0, color: Colors.transparent),
              ),
            ),
            // Left edge
            Positioned(
              left: 0.0,
              top: 12.0,
              bottom: 12.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeft,
                child: Container(width: 8.0, color: Colors.transparent),
              ),
            ),
            // Right edge
            Positioned(
              right: 0.0,
              top: 12.0,
              bottom: 12.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeRight,
                child: Container(width: 8.0, color: Colors.transparent),
              ),
            ),
            // Corners
            Positioned(
              top: 0.0,
              left: 0.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUpLeft,
                child: _cornerDot(kForest),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeUpRight,
                child: _cornerDot(kForest),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeDownLeft,
                child: _cornerDot(kForest),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeDownRight,
                child: _cornerDot(kForest),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _cornerDot(Color color) {
  return Container(
    width: 14.0,
    height: 14.0,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2.0),
    ),
  );
}

Widget _compoundContextMenu() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kIndigo.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.menu_open, color: kIndigo, size: 18.0),
          SizedBox(width: 8.0),
          Text('Right-click region (contextMenu cursor)',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 12.0),
        MouseRegion(
          cursor: SystemMouseCursors.contextMenu,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: kIndigoSoft,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: kIndigo.withOpacity(0.45)),
            ),
            child: Row(
              children: [
                Icon(Icons.touch_app_outlined, color: kIndigo, size: 22.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                      'Right-click anywhere in this area to open a custom context menu. '
                      'The cursor hints at the secondary action.',
                      style: TextStyle(
                          color: kIndigo,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          height: 1.4)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compoundLinkText() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kCopper.withOpacity(0.42), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.link, color: kCopper, size: 18.0),
          SizedBox(width: 8.0),
          Text('Inline link inside a paragraph',
              style: TextStyle(
                  color: kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kCopperSoft,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('You can read more about cursors in the ',
                  style: TextStyle(color: kInk, fontSize: 13.0)),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text('official documentation',
                    style: TextStyle(
                        color: kCopper,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline)),
              ),
              Text(' or open the ', style: TextStyle(color: kInk, fontSize: 13.0)),
              MouseRegion(
                cursor: SystemMouseCursors.help,
                child: Text('inline help',
                    style: TextStyle(
                        color: kTeal,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline)),
              ),
              Text(' tooltip.', style: TextStyle(color: kInk, fontSize: 13.0)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12: Big cursor variant matrix
// ============================================================================
Widget _section12() {
  final accent = kCrimson;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(12, 'Cursor Variant Matrix',
          'A consolidated reference grid for every SystemMouseCursors entry',
          accent),
      _comparisonTable(
        'Pointer cursors',
        [
          ['Cursor', 'Typical Use', 'Platforms'],
          ['basic', 'default arrow', 'all'],
          ['click', 'clickable affordances', 'all'],
          ['forbidden', 'disabled drop targets', 'all'],
          ['none', 'hide cursor', 'all'],
          ['wait', 'blocking task', 'all'],
          ['progress', 'background task', 'all'],
          ['help', 'contextual help', 'all'],
          ['contextMenu', 'right-click areas', 'all'],
        ],
        kCopper,
      ),
      _comparisonTable(
        'Text cursors',
        [
          ['Cursor', 'Typical Use', 'Platforms'],
          ['text', 'editable / selectable text', 'all'],
          ['verticalText', 'rotated text / CJK vertical', 'all'],
          ['cell', 'spreadsheet cell', 'all'],
          ['precise', 'pixel-precise picking', 'all'],
        ],
        kTeal,
      ),
      _comparisonTable(
        'Drag cursors',
        [
          ['Cursor', 'Typical Use', 'Platforms'],
          ['grab', 'pickable item', 'all'],
          ['grabbing', 'currently dragging', 'all'],
          ['move', 'freely movable item', 'all'],
          ['allScroll', 'autoscroll any direction', 'all'],
          ['noDrop', 'dragging over reject zone', 'all'],
          ['disappearing', 'drop here to discard', 'web'],
          ['alias', 'drop creates shortcut', 'all'],
          ['copy', 'drop copies', 'all'],
        ],
        kPlum,
      ),
      _comparisonTable(
        'Resize cursors',
        [
          ['Cursor', 'Direction', 'Use'],
          ['resizeColumn', 'horizontal', 'column splitter'],
          ['resizeRow', 'vertical', 'row splitter'],
          ['resizeUpDown', 'vertical', 'top/bottom edge'],
          ['resizeLeftRight', 'horizontal', 'left/right edge'],
          ['resizeUp', 'up', 'top edge only'],
          ['resizeDown', 'down', 'bottom edge only'],
          ['resizeLeft', 'left', 'left edge only'],
          ['resizeRight', 'right', 'right edge only'],
          ['resizeUpLeft', 'NW', 'top-left corner'],
          ['resizeUpRight', 'NE', 'top-right corner'],
          ['resizeDownLeft', 'SW', 'bottom-left corner'],
          ['resizeDownRight', 'SE', 'bottom-right corner'],
          ['resizeUpLeftDownRight', 'NW-SE', 'principal diagonal'],
          ['resizeUpRightDownLeft', 'NE-SW', 'anti-diagonal'],
        ],
        kSaffron,
      ),
      _comparisonTable(
        'Zoom & misc cursors',
        [
          ['Cursor', 'Typical Use', 'Notes'],
          ['zoomIn', 'magnify in', 'image viewers'],
          ['zoomOut', 'magnify out', 'image viewers'],
          ['defer', 'pass to outer region', 'never visible'],
          ['uncontrolled', 'leave OS cursor', 'native embedding'],
        ],
        kForest,
      ),
    ],
  );
}

// ============================================================================
// SECTION 13: Glossary
// ============================================================================
Widget _glossary() {
  final accent = kInk;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionBanner(13, 'Glossary',
          'Key terms used throughout the cursor system', accent),
      _glossaryEntry(
          'MouseRegion',
          'A widget that detects pointer enter/exit/hover and applies a cursor '
              'while the pointer is inside its bounds.',
          Icons.crop_square,
          kCopper),
      _glossaryEntry(
          'MouseCursor',
          'The abstract base class for all cursors. Subtypes include '
              'SystemMouseCursor, MaterialStateMouseCursor, and the singletons '
              'defer & uncontrolled.',
          Icons.account_tree_outlined,
          kTeal),
      _glossaryEntry(
          'SystemMouseCursor',
          'A predefined cursor that maps to the host OS native cursor of the '
              'same kind. Accessed through SystemMouseCursors.<name>.',
          Icons.desktop_windows_outlined,
          kPlum),
      _glossaryEntry(
          'SystemMouseCursors',
          'The static collection of all named system cursors: basic, click, '
              'text, forbidden, grab, grabbing, resize*, zoom*, etc.',
          Icons.library_books_outlined,
          kSaffron),
      _glossaryEntry(
          'MaterialStateMouseCursor',
          'A cursor that resolves differently per MaterialState. The two '
              'built-in constants are clickable and textable.',
          Icons.layers_outlined,
          kForest),
      _glossaryEntry(
          'WidgetStateMouseCursor',
          'The framework-level rename of MaterialStateMouseCursor; same idea '
              'but in flutter/widgets so non-Material apps can use it.',
          Icons.widgets_outlined,
          kCrimson),
      _glossaryEntry(
          'MouseCursor.defer',
          'Singleton meaning "delegate cursor decision to the next region". '
              'Use to make a wrapper widget transparent to cursor logic.',
          Icons.skip_next_outlined,
          kIndigo),
      _glossaryEntry(
          'MouseCursor.uncontrolled',
          'Singleton meaning "do not change the cursor". Used by platform '
              'views so native widgets remain in charge.',
          Icons.do_disturb,
          kSlate),
      _glossaryEntry(
          'HitTestBehavior',
          'Enum controlling how a region participates in pointer hit testing: '
              'opaque, translucent, deferToChild.',
          Icons.touch_app_outlined,
          kCopper),
      _glossaryEntry(
          'opaqueLayer',
          'A short-hand for "this MouseRegion blocks events from siblings". '
              'Default behaviour for MouseRegion.opaque = true.',
          Icons.filter_b_and_w_outlined,
          kTeal),
    ],
  );
}

Widget _glossaryEntry(
    String term, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withOpacity(0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.16),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(term,
                  style: TextStyle(
                      color: kInk,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace')),
              SizedBox(height: 4.0),
              Text(description,
                  style: TextStyle(
                      color: kInk.withOpacity(0.78),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      height: 1.42)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 14: Epilogue
// ============================================================================
Widget _epilogue() {
  return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kInk, kPlum, kTeal],
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.auto_awesome,
              color: Colors.white.withOpacity(0.92), size: 22.0),
          SizedBox(width: 10.0),
          Text('Epilogue',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800)),
        ]),
        SizedBox(height: 14.0),
        Text(
            'The MouseRegion + SystemMouseCursors pair gives you platform-correct '
            'cursors for free. Reach for MaterialStateMouseCursor / '
            'WidgetStateMouseCursor when your cursor should respond to state, '
            'and use MouseCursor.defer to keep wrappers transparent to '
            'composed cursor logic.',
            style: TextStyle(
                color: Colors.white.withOpacity(0.94),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                height: 1.5)),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates_outlined,
                  color: Colors.white.withOpacity(0.92), size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                    'Pro tip: the innermost MouseRegion wins. To "punch through" '
                    'a wrapper, use MouseCursor.defer on the outer region.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        height: 1.4)),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.0),
        Wrap(spacing: 8.0, runSpacing: 8.0, children: [
          _epilogueChip('30+ cursors'),
          _epilogueChip('14 sections'),
          _epilogueChip('6 compound demos'),
          _epilogueChip('5 comparison tables'),
          _epilogueChip('1 unified theme'),
        ]),
        SizedBox(height: 20.0),
        Center(
          child: Text('— end of cursor showcase —',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.78),
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}

Widget _epilogueChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.20),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withOpacity(0.35)),
    ),
    child: Text(label,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace')),
  );
}

// ============================================================================
// HELPER: Decorative divider strip
// ============================================================================
Widget _decorStrip() {
  final tints = <Color>[
    kCopper,
    kTeal,
    kPlum,
    kSaffron,
    kForest,
    kCrimson,
    kIndigo,
    kSlate,
  ];
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    height: 8.0,
    child: Row(
      children: [
        for (final t in tints)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                color: t,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: Math-flavoured aesthetic — pseudo-random rotating chip strip
// (uses dart:math; deterministic seed to keep the visuals stable)
// ============================================================================
Widget _aestheticStrip() {
  final rng = math.Random(42);
  final palette = <Color>[
    kCopper,
    kTeal,
    kPlum,
    kSaffron,
    kForest,
    kCrimson,
    kIndigo,
    kSlate,
  ];
  final chips = <Widget>[];
  for (var i = 0; i < 18; i++) {
    final c = palette[rng.nextInt(palette.length)];
    final w = 36.0 + rng.nextInt(28).toDouble();
    chips.add(Container(
      width: w,
      height: 18.0,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c, c.withOpacity(0.55)],
        ),
        borderRadius: BorderRadius.circular(9.0),
      ),
    ));
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Wrap(children: chips),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: kBackdrop,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heroHeader(),
            _conceptOverview(),
            _decorStrip(),
            _section1(),
            _aestheticStrip(),
            _section2(),
            _decorStrip(),
            _section3(),
            _aestheticStrip(),
            _section4(),
            _decorStrip(),
            _section5(),
            _aestheticStrip(),
            _section6(),
            _decorStrip(),
            _section7(),
            _aestheticStrip(),
            _section8(),
            _decorStrip(),
            _section9(),
            _aestheticStrip(),
            _section10(),
            _decorStrip(),
            _section11(),
            _aestheticStrip(),
            _section12(),
            _decorStrip(),
            _glossary(),
            _aestheticStrip(),
            _epilogue(),
            SizedBox(height: 28.0),
          ],
        ),
      ),
    ),
  );
}
