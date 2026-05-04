// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests SemanticsAction class from dart:ui
// Deep Demo: Visual demonstration of every SemanticsAction constant — tap,
// longPress, scrollLeft, scrollRight, scrollUp, scrollDown, increase,
// decrease, showOnScreen, moveCursorForwardByCharacter,
// moveCursorBackwardByCharacter, setText, setSelection, copy, cut, paste,
// didGainAccessibilityFocus, didLoseAccessibilityFocus, customAction,
// dismiss, moveCursorForwardByWord, moveCursorBackwardByWord, focus,
// scrollToOffset, expand, collapse — with bit-index visualisation,
// platform mappings, gesture mock-ups and code samples.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('SemanticsAction Deep Demo executing');

  // ============================================================
  // SECTION 1: SemanticsAction Catalogue Cards
  // ============================================================
  print('=== Section 1: SemanticsAction Catalogue ===');

  // Each action has the bit index used by the engine bitmask, an icon, a
  // semantic colour, a one-liner and a category. Categories group related
  // actions together so the matrix in section 3 stays readable.
  final actionData = <Map<String, dynamic>>[
    {
      'action': ui.SemanticsAction.tap,
      'icon': Icons.touch_app,
      'color': Colors.blue,
      'category': 'Gesture',
      'shortcut': 'Tap',
      'description': 'Brief tap without movement',
      'bit': 0,
    },
    {
      'action': ui.SemanticsAction.longPress,
      'icon': Icons.pan_tool,
      'color': Colors.indigo,
      'category': 'Gesture',
      'shortcut': 'Hold',
      'description': 'Press and hold the screen',
      'bit': 1,
    },
    {
      'action': ui.SemanticsAction.scrollLeft,
      'icon': Icons.arrow_back,
      'color': Colors.cyan,
      'category': 'Scroll',
      'shortcut': 'Swipe \u2190',
      'description': 'Swipe right-to-left',
      'bit': 2,
    },
    {
      'action': ui.SemanticsAction.scrollRight,
      'icon': Icons.arrow_forward,
      'color': Colors.cyan,
      'category': 'Scroll',
      'shortcut': 'Swipe \u2192',
      'description': 'Swipe left-to-right',
      'bit': 3,
    },
    {
      'action': ui.SemanticsAction.scrollUp,
      'icon': Icons.arrow_upward,
      'color': Colors.lightBlue,
      'category': 'Scroll',
      'shortcut': 'Swipe \u2191',
      'description': 'Swipe bottom-to-top',
      'bit': 4,
    },
    {
      'action': ui.SemanticsAction.scrollDown,
      'icon': Icons.arrow_downward,
      'color': Colors.lightBlue,
      'category': 'Scroll',
      'shortcut': 'Swipe \u2193',
      'description': 'Swipe top-to-bottom',
      'bit': 5,
    },
    {
      'action': ui.SemanticsAction.increase,
      'icon': Icons.add_circle_outline,
      'color': Colors.green,
      'category': 'Value',
      'shortcut': '+',
      'description': 'Increase node value',
      'bit': 6,
    },
    {
      'action': ui.SemanticsAction.decrease,
      'icon': Icons.remove_circle_outline,
      'color': Colors.green,
      'category': 'Value',
      'shortcut': '\u2212',
      'description': 'Decrease node value',
      'bit': 7,
    },
    {
      'action': ui.SemanticsAction.showOnScreen,
      'icon': Icons.center_focus_strong,
      'color': Colors.teal,
      'category': 'Visibility',
      'shortcut': 'Reveal',
      'description': 'Bring node into view',
      'bit': 8,
    },
    {
      'action': ui.SemanticsAction.moveCursorForwardByCharacter,
      'icon': Icons.keyboard_arrow_right,
      'color': Colors.deepPurple,
      'category': 'Cursor',
      'shortcut': '\u25B6',
      'description': 'Cursor forward 1 char',
      'bit': 9,
    },
    {
      'action': ui.SemanticsAction.moveCursorBackwardByCharacter,
      'icon': Icons.keyboard_arrow_left,
      'color': Colors.deepPurple,
      'category': 'Cursor',
      'shortcut': '\u25C0',
      'description': 'Cursor backward 1 char',
      'bit': 10,
    },
    {
      'action': ui.SemanticsAction.setSelection,
      'icon': Icons.select_all,
      'color': Colors.purple,
      'category': 'Text',
      'shortcut': 'Range',
      'description': 'Set selection range',
      'bit': 11,
    },
    {
      'action': ui.SemanticsAction.copy,
      'icon': Icons.copy,
      'color': Colors.orange,
      'category': 'Clipboard',
      'shortcut': 'Copy',
      'description': 'Copy current selection',
      'bit': 12,
    },
    {
      'action': ui.SemanticsAction.cut,
      'icon': Icons.cut,
      'color': Colors.deepOrange,
      'category': 'Clipboard',
      'shortcut': 'Cut',
      'description': 'Cut current selection',
      'bit': 13,
    },
    {
      'action': ui.SemanticsAction.paste,
      'icon': Icons.content_paste,
      'color': Colors.amber,
      'category': 'Clipboard',
      'shortcut': 'Paste',
      'description': 'Paste from clipboard',
      'bit': 14,
    },
    {
      'action': ui.SemanticsAction.didGainAccessibilityFocus,
      'icon': Icons.center_focus_weak,
      'color': Colors.lightGreen,
      'category': 'A11y Focus',
      'shortcut': 'Gain',
      'description': 'Node gained a11y focus',
      'bit': 15,
    },
    {
      'action': ui.SemanticsAction.didLoseAccessibilityFocus,
      'icon': Icons.blur_off,
      'color': Colors.lime,
      'category': 'A11y Focus',
      'shortcut': 'Lose',
      'description': 'Node lost a11y focus',
      'bit': 16,
    },
    {
      'action': ui.SemanticsAction.customAction,
      'icon': Icons.extension,
      'color': Colors.pink,
      'category': 'Custom',
      'shortcut': 'Custom',
      'description': 'Custom user-defined action',
      'bit': 17,
    },
    {
      'action': ui.SemanticsAction.dismiss,
      'icon': Icons.cancel,
      'color': Colors.red,
      'category': 'Visibility',
      'shortcut': 'Dismiss',
      'description': 'Dismiss the node',
      'bit': 18,
    },
    {
      'action': ui.SemanticsAction.moveCursorForwardByWord,
      'icon': Icons.skip_next,
      'color': Colors.deepPurple,
      'category': 'Cursor',
      'shortcut': '\u23E9',
      'description': 'Cursor forward 1 word',
      'bit': 19,
    },
    {
      'action': ui.SemanticsAction.moveCursorBackwardByWord,
      'icon': Icons.skip_previous,
      'color': Colors.deepPurple,
      'category': 'Cursor',
      'shortcut': '\u23EA',
      'description': 'Cursor backward 1 word',
      'bit': 20,
    },
    {
      'action': ui.SemanticsAction.setText,
      'icon': Icons.text_fields,
      'color': Colors.purple,
      'category': 'Text',
      'shortcut': 'Set',
      'description': 'Replace field text',
      'bit': 21,
    },
    {
      'action': ui.SemanticsAction.focus,
      'icon': Icons.center_focus_strong,
      'color': Colors.blueGrey,
      'category': 'A11y Focus',
      'shortcut': 'Focus',
      'description': 'Move input focus',
      'bit': 22,
    },
    {
      'action': ui.SemanticsAction.scrollToOffset,
      'icon': Icons.unfold_more,
      'color': Colors.lightBlue,
      'category': 'Scroll',
      'shortcut': 'Offset',
      'description': 'Scroll to offset (Float64x2)',
      'bit': 23,
    },
    {
      'action': ui.SemanticsAction.expand,
      'icon': Icons.expand_more,
      'color': Colors.brown,
      'category': 'Visibility',
      'shortcut': 'Expand',
      'description': 'Expand node (dropdowns)',
      'bit': 24,
    },
    {
      'action': ui.SemanticsAction.collapse,
      'icon': Icons.expand_less,
      'color': Colors.brown,
      'category': 'Visibility',
      'shortcut': 'Collapse',
      'description': 'Collapse node (dropdowns)',
      'bit': 25,
    },
  ];

  final actionCards = <Widget>[];
  for (final data in actionData) {
    final action = data['action'] as ui.SemanticsAction;
    final color = data['color'] as Color;
    final bit = data['bit'] as int;
    final indexValue = 1 << bit;
    print(
      'SemanticsAction.${action.name} index=$indexValue bit=$bit',
    );

    actionCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(data['icon'] as IconData, size: 28.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    action.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${data['category']} \u00B7 1<<$bit',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              data['description'] as String,
              style: TextStyle(fontSize: 10.5, color: Colors.grey.shade800),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Icon(Icons.gesture, size: 12.0, color: Colors.grey.shade600),
                SizedBox(width: 4.0),
                Text(
                  data['shortcut'] as String,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                Spacer(),
                Text(
                  '0x${indexValue.toRadixString(16)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${actionCards.length} action cards');

  // ============================================================
  // SECTION 2: Bit-Index Visualisation
  // ============================================================
  print('=== Section 2: Bit Index Visualisation ===');

  // Each action's index is one bit set. We render a 32-bit grid where
  // exactly one cell lights up per action.
  final bitGridRows = <Widget>[];
  for (final data in actionData) {
    final action = data['action'] as ui.SemanticsAction;
    final color = data['color'] as Color;
    final bit = data['bit'] as int;

    final cells = <Widget>[];
    for (var i = 31; i >= 0; i--) {
      final isOn = i == bit;
      cells.add(
        Container(
          width: 12.0,
          height: 14.0,
          margin: EdgeInsets.symmetric(horizontal: 0.5),
          decoration: BoxDecoration(
            gradient: isOn
                ? LinearGradient(
                    colors: [color, color.withValues(alpha: 0.6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: isOn ? null : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(
              color: isOn ? color : Colors.grey.shade400,
              width: 0.6,
            ),
            boxShadow: isOn
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ]
                : null,
          ),
        ),
      );
    }

    bitGridRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 200.0,
              child: Text(
                action.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 4.0),
            Row(mainAxisSize: MainAxisSize.min, children: cells),
            SizedBox(width: 8.0),
            Text(
              'bit $bit',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final bitGrid = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Colors.blueGrey.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              '32-bit Action Bitmask',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Each SemanticsAction index has exactly one bit set in a 32-bit field.',
          style: TextStyle(fontSize: 11.0, color: Colors.blueGrey.shade600),
        ),
        SizedBox(height: 12.0),
        ...bitGridRows,
      ],
    ),
  );
  print('Created bit grid with ${bitGridRows.length} rows');

  // ============================================================
  // SECTION 3: Category Matrix
  // ============================================================
  print('=== Section 3: Category Matrix ===');

  final categoryColors = <String, Color>{
    'Gesture': Colors.blue,
    'Scroll': Colors.cyan,
    'Value': Colors.green,
    'Visibility': Colors.brown,
    'Cursor': Colors.deepPurple,
    'Text': Colors.purple,
    'Clipboard': Colors.orange,
    'A11y Focus': Colors.lightGreen,
    'Custom': Colors.pink,
  };

  final categoryRows = <Widget>[];
  for (final entry in categoryColors.entries) {
    final category = entry.key;
    final color = entry.value;
    final actionsInCategory = actionData
        .where((d) => d['category'] == category)
        .toList();

    final chips = <Widget>[];
    for (final data in actionsInCategory) {
      final action = data['action'] as ui.SemanticsAction;
      chips.add(
        Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.18),
                color.withValues(alpha: 0.32),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: color, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.25),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data['icon'] as IconData, size: 14.0, color: color),
              SizedBox(width: 6.0),
              Text(
                action.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    categoryRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${actionsInCategory.length} action${actionsInCategory.length == 1 ? '' : 's'}',
                  style:
                      TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Wrap(children: chips),
          ],
        ),
      ),
    );
  }

  final categoryMatrix = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions by Category',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        ...categoryRows,
      ],
    ),
  );
  print('Created category matrix');

  // ============================================================
  // SECTION 4: Gesture Mock-ups
  // ============================================================
  print('=== Section 4: Gesture Mock-ups ===');

  // Render mock phone screens demonstrating the four scroll directions plus
  // tap and long-press as visual hints.
  Widget gestureMock(String label, IconData icon, Color color, double dx,
      double dy, ui.SemanticsAction action) {
    return Container(
      width: 130.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.30),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Mock device frame
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Faux screen content
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.20),
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                // Finger / arrow indicator
                Transform.translate(
                  offset: Offset(dx, dy),
                  child: Icon(icon, color: color, size: 36.0),
                ),
                // Trail indicator
                Positioned(
                  bottom: 8.0,
                  child: Container(
                    width: 30.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.0),
                          color,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            action.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  final gestureMocks = <Widget>[
    gestureMock('Tap', Icons.fiber_manual_record, Colors.blue, 0.0, 0.0,
        ui.SemanticsAction.tap),
    gestureMock('Long Press', Icons.fiber_smart_record, Colors.indigo, 0.0,
        0.0, ui.SemanticsAction.longPress),
    gestureMock('Scroll Left', Icons.arrow_back, Colors.cyan, -20.0, 0.0,
        ui.SemanticsAction.scrollLeft),
    gestureMock('Scroll Right', Icons.arrow_forward, Colors.cyan, 20.0, 0.0,
        ui.SemanticsAction.scrollRight),
    gestureMock('Scroll Up', Icons.arrow_upward, Colors.lightBlue, 0.0,
        -20.0, ui.SemanticsAction.scrollUp),
    gestureMock('Scroll Down', Icons.arrow_downward, Colors.lightBlue, 0.0,
        20.0, ui.SemanticsAction.scrollDown),
    gestureMock('Increase', Icons.add, Colors.green, 0.0, -20.0,
        ui.SemanticsAction.increase),
    gestureMock('Decrease', Icons.remove, Colors.green, 0.0, 20.0,
        ui.SemanticsAction.decrease),
    gestureMock('Dismiss', Icons.close, Colors.red, 0.0, 0.0,
        ui.SemanticsAction.dismiss),
    gestureMock('Show On Screen', Icons.center_focus_strong, Colors.teal,
        0.0, 0.0, ui.SemanticsAction.showOnScreen),
  ];

  final gestureSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gesture, color: Colors.cyan.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Gesture Demonstrations',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: gestureMocks),
      ],
    ),
  );
  print('Created ${gestureMocks.length} gesture mocks');

  // ============================================================
  // SECTION 5: Text & Cursor Action Group
  // ============================================================
  print('=== Section 5: Text & Cursor ===');

  Widget textActionRow(
    ui.SemanticsAction action,
    IconData icon,
    Color color,
    String example,
    String result,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 20.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                SizedBox(height: 2.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        example,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Icon(Icons.arrow_forward,
                        size: 12.0, color: Colors.grey.shade500),
                    SizedBox(width: 6.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        result,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final textSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields,
                color: Colors.deepPurple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Text & Cursor Actions',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        textActionRow(
          ui.SemanticsAction.setText,
          Icons.text_fields,
          Colors.purple,
          'old',
          'new',
        ),
        textActionRow(
          ui.SemanticsAction.setSelection,
          Icons.select_all,
          Colors.purple,
          '|hello|',
          'hel|lo|',
        ),
        textActionRow(
          ui.SemanticsAction.moveCursorForwardByCharacter,
          Icons.keyboard_arrow_right,
          Colors.deepPurple,
          'h|ello',
          'he|llo',
        ),
        textActionRow(
          ui.SemanticsAction.moveCursorBackwardByCharacter,
          Icons.keyboard_arrow_left,
          Colors.deepPurple,
          'he|llo',
          'h|ello',
        ),
        textActionRow(
          ui.SemanticsAction.moveCursorForwardByWord,
          Icons.skip_next,
          Colors.deepPurple,
          'lorem | ipsum',
          'lorem ipsum |',
        ),
        textActionRow(
          ui.SemanticsAction.moveCursorBackwardByWord,
          Icons.skip_previous,
          Colors.deepPurple,
          'lorem ipsum |',
          'lorem | ipsum',
        ),
      ],
    ),
  );
  print('Created text/cursor section');

  // ============================================================
  // SECTION 6: Clipboard Pipeline
  // ============================================================
  print('=== Section 6: Clipboard Pipeline ===');

  Widget pipelineNode(
    String label,
    IconData icon,
    Color color,
    ui.SemanticsAction action,
  ) {
    return Container(
      width: 110.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.40),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30.0),
          SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            action.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  final clipboardPipeline = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz,
                color: Colors.orange.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Clipboard Pipeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pipelineNode('Cut', Icons.cut, Colors.deepOrange,
                ui.SemanticsAction.cut),
            Icon(Icons.arrow_forward,
                color: Colors.grey.shade500, size: 24.0),
            pipelineNode('Copy', Icons.copy, Colors.orange,
                ui.SemanticsAction.copy),
            Icon(Icons.arrow_forward,
                color: Colors.grey.shade500, size: 24.0),
            pipelineNode('Paste', Icons.content_paste, Colors.amber,
                ui.SemanticsAction.paste),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'cut.index = 0x${(1 << 13).toRadixString(16)} \u00B7 '
            'copy.index = 0x${(1 << 12).toRadixString(16)} \u00B7 '
            'paste.index = 0x${(1 << 14).toRadixString(16)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created clipboard pipeline');

  // ============================================================
  // SECTION 7: Accessibility Focus Lifecycle
  // ============================================================
  print('=== Section 7: A11y Focus Lifecycle ===');

  Widget focusStateNode(
    String label,
    Color color,
    IconData icon,
    bool isFocused,
  ) {
    return Container(
      width: 130.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFocused
              ? [color, color.withValues(alpha: 0.6)]
              : [
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isFocused ? color : Colors.grey.shade500,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: (isFocused ? color : Colors.grey).withValues(alpha: 0.4),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon,
              color: isFocused ? Colors.white : Colors.grey.shade700,
              size: 32.0),
          SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: isFocused ? Colors.white : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  final focusLifecycle = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightGreen.shade50, Colors.green.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.lightGreen.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.lightGreen.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new,
                color: Colors.lightGreen.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Accessibility Focus Lifecycle',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'didGainAccessibilityFocus / didLoseAccessibilityFocus / focus',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            focusStateNode(
                'Idle', Colors.grey, Icons.blur_off, false),
            Column(
              children: [
                Icon(Icons.arrow_forward,
                    color: Colors.lightGreen, size: 20.0),
                Text(
                  'didGain',
                  style: TextStyle(
                      fontSize: 9.0, color: Colors.lightGreen.shade800),
                ),
              ],
            ),
            focusStateNode(
                'A11y Focus', Colors.lightGreen, Icons.center_focus_weak,
                true),
            Column(
              children: [
                Icon(Icons.arrow_forward,
                    color: Colors.blueGrey, size: 20.0),
                Text(
                  'focus',
                  style: TextStyle(
                      fontSize: 9.0, color: Colors.blueGrey.shade800),
                ),
              ],
            ),
            focusStateNode(
                'Input Focus', Colors.blueGrey, Icons.center_focus_strong,
                true),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: Colors.lime.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'didLoseAccessibilityFocus brings node back to Idle',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.lime.shade900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created focus lifecycle');

  // ============================================================
  // SECTION 8: Platform Mapping Table
  // ============================================================
  print('=== Section 8: Platform Mapping ===');

  final platformRows = <List<String>>[
    ['Action', 'Android', 'iOS', 'Web'],
    ['tap', 'ACTION_CLICK', 'activate', 'click'],
    ['longPress', 'ACTION_LONG_CLICK', '\u2014', 'contextmenu'],
    ['scrollLeft', 'ACTION_SCROLL_LEFT', 'scrollLeft', 'wheel'],
    ['scrollRight', 'ACTION_SCROLL_RIGHT', 'scrollRight', 'wheel'],
    ['scrollUp', 'ACTION_SCROLL_UP', 'scrollUp', 'wheel'],
    ['scrollDown', 'ACTION_SCROLL_DOWN', 'scrollDown', 'wheel'],
    ['scrollToOffset', 'ACTION_SCROLL_TO_POSITION', 'scrollToVisible', '\u2014'],
    ['increase', 'ACTION_SCROLL_FORWARD', 'increment', 'aria-valuenow+'],
    ['decrease', 'ACTION_SCROLL_BACKWARD', 'decrement', 'aria-valuenow-'],
    ['copy', 'ACTION_COPY', 'copy', 'copy'],
    ['cut', 'ACTION_CUT', 'cut', 'cut'],
    ['paste', 'ACTION_PASTE', 'paste', 'paste'],
    ['focus', 'ACTION_FOCUS', 'focus', 'focus'],
    ['dismiss', 'ACTION_DISMISS', 'dismiss', '\u2014'],
    ['expand', 'ACTION_EXPAND', 'expand', 'aria-expanded=true'],
    ['collapse', 'ACTION_COLLAPSE', 'collapse', 'aria-expanded=false'],
  ];

  final platformTable = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices, color: Colors.grey.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Platform Mapping',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (var i = 0; i < platformRows.length; i++)
          Container(
            decoration: BoxDecoration(
              gradient: i == 0
                  ? LinearGradient(
                      colors: [
                        Colors.indigo.shade100,
                        Colors.indigo.shade50,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              color: i == 0
                  ? null
                  : (i.isEven
                      ? Colors.grey.shade50
                      : Colors.white),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Row(
              children: [
                _platformCell(platformRows[i][0], 140.0,
                    bold: i == 0,
                    color: i == 0
                        ? Colors.indigo.shade900
                        : Colors.deepPurple.shade700,
                    monospace: i != 0),
                _platformCell(platformRows[i][1], 160.0,
                    bold: i == 0,
                    color: i == 0
                        ? Colors.indigo.shade900
                        : Colors.green.shade700),
                _platformCell(platformRows[i][2], 110.0,
                    bold: i == 0,
                    color: i == 0
                        ? Colors.indigo.shade900
                        : Colors.blue.shade700),
                _platformCell(platformRows[i][3], 130.0,
                    bold: i == 0,
                    color: i == 0
                        ? Colors.indigo.shade900
                        : Colors.orange.shade700),
              ],
            ),
          ),
      ],
    ),
  );
  print('Created platform table with ${platformRows.length - 1} entries');

  // ============================================================
  // SECTION 9: Code Examples
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Examples',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// Build an action mask for an interactive widget\n'
          'final tapBit = SemanticsAction.tap.index;\n'
          'final longPressBit = SemanticsAction.longPress.index;\n'
          'final mask = tapBit | longPressBit;\n'
          'print(mask.toRadixString(2));',
          Colors.cyan.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Check whether a mask supports an action\n'
          'bool supportsScroll(int mask) {\n'
          '  return (mask & SemanticsAction.scrollUp.index) != 0;\n'
          '}',
          Colors.lightGreen.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Reading the human-readable name\n'
          "final name = SemanticsAction.dismiss.name; // 'dismiss'\n"
          'final idx  = SemanticsAction.dismiss.index; // 1 << 18',
          Colors.amber.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Reacting to text editing actions\n'
          'switch (action) {\n'
          '  case SemanticsAction.setText:\n'
          '    field.value = newText;\n'
          '  case SemanticsAction.setSelection:\n'
          '    field.selection = TextSelection(\n'
          '      baseOffset: base,\n'
          '      extentOffset: extent,\n'
          '    );\n'
          '  case SemanticsAction.copy:\n'
          '  case SemanticsAction.cut:\n'
          '  case SemanticsAction.paste:\n'
          '    handleClipboard(action);\n'
          '  default:\n'
          '    break;\n'
          '}',
          Colors.purple.shade300,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// scrollToOffset payload (Float64List of length 2)\n'
          'void onScrollToOffset(ByteData payload) {\n'
          '  final offsets = payload.buffer.asFloat64List();\n'
          '  final dx = offsets[0];\n'
          '  final dy = offsets[1];\n'
          '  controller.jumpTo(dy);\n'
          '}',
          Colors.orange.shade300,
        ),
      ],
    ),
  );
  print('Created code examples');

  // ============================================================
  // SECTION 10: Summary Footer
  // ============================================================
  print('=== Section 10: Summary Footer ===');

  final summaryFooter = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.deepPurple.shade700,
          Colors.purple.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.accessibility, color: Colors.white, size: 36.0),
        SizedBox(height: 8.0),
        Text(
          'SemanticsAction at a glance',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            _summaryStat('${actionData.length}', 'constants'),
            _summaryStat('${categoryColors.length}', 'categories'),
            _summaryStat('32', 'bit field'),
            _summaryStat('1<<25', 'highest bit'),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            "Each action is one bit in the engine's action bitmask.",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created summary footer');

  print('SemanticsAction Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.indigo,
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.accessibility_new,
                      size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'SemanticsAction',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'dart:ui accessibility action constants',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Action Catalogue',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: actionCards),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. 32-bit Bitmask Visualisation',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            bitGrid,
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. Action Categories',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            categoryMatrix,
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Gesture Mock-ups',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            gestureSection,
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Text & Cursor Actions',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            textSection,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Clipboard Pipeline',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            clipboardPipeline,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Accessibility Focus Lifecycle',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            focusLifecycle,
            SizedBox(height: 32.0),

            // Section 8
            Text(
              '8. Platform Mapping',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            platformTable,
            SizedBox(height: 32.0),

            // Section 9
            Text(
              '9. Code Examples',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            codeExamples,
            SizedBox(height: 32.0),

            // Section 10
            Text(
              '10. Summary',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryFooter,
          ],
        ),
      ),
    ),
  );
}

// Helper: build a cell of the platform mapping table.
Widget _platformCell(
  String text,
  double width, {
  bool bold = false,
  Color color = Colors.black87,
  bool monospace = false,
}) {
  return SizedBox(
    width: width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: monospace ? 'monospace' : null,
          fontSize: 11.0,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
    ),
  );
}

// Helper: build a code block for the code examples section.
Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 0.5),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// Helper: build a stat tile inside the summary footer.
Widget _summaryStat(String value, String label) {
  return Container(
    width: 90.0,
    padding: EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );
}
