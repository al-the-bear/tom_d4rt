// D4rt test script: Comprehensive deep demo for DirectionallyExtendSelectionEvent
//
// DirectionallyExtendSelectionEvent is used to extend text selection in a specific
// direction. Part of Flutter's selection system for editable text widgets.
//
// Key properties:
//   - direction: SelectionExtendDirection (forward, backward, previousLine, nextLine)
//   - dx: horizontal position for line-based extension
//   - isEnd: whether to extend the end (true) or start (false) of selection
//
// This demo covers:
//   1. DirectionallyExtendSelectionEvent purpose and overview
//   2. direction property with all SelectionExtendDirection values
//   3. dx and isEnd properties explained
//   4. Forward selection examples
//   5. Backward selection examples
//   6. Character-level extension
//   7. Word-level extension concepts
//   8. Line-level extension patterns
//   9. Selection event comparison
//  10. Practical use cases
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS - Deep Blue / Cyan Theme for Selection
// ═══════════════════════════════════════════════════════════════════════════

var _kBlue50 = Color(0xFFE3F2FD);
var _kBlue100 = Color(0xFFBBDEFB);
var _kBlue200 = Color(0xFF90CAF9);
var _kBlue300 = Color(0xFF64B5F6);
var _kBlue400 = Color(0xFF42A5F5);
var _kBlue500 = Color(0xFF2196F3);
var _kBlue600 = Color(0xFF1E88E5);
var _kBlue700 = Color(0xFF1976D2);
var _kBlue800 = Color(0xFF1565C0);
var _kBlue900 = Color(0xFF0D47A1);

var _kCyan500 = Color(0xFF00BCD4);
var _kCyan700 = Color(0xFF0097A7);
var _kTeal500 = Color(0xFF009688);
var _kAmber500 = Color(0xFFFFC107);
var _kOrange500 = Color(0xFFFF9800);
var _kGreen500 = Color(0xFF4CAF50);
var _kRed500 = Color(0xFFF44336);

var _kSurface = Color(0xFFE3F2FD);
var _kCardBg = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kBlue800, _kBlue600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kBlue700.withAlpha(80),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  var color = accentColor ?? _kBlue500;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

Widget _buildPropertyRow(String name, String value, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kBlue900,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: _kBlue700.withAlpha(180),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionChip(String direction, String desc, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              direction,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 9, color: color.withAlpha(180)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 11,
        color: Color(0xFF90CAF9),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

Widget _buildSelectionVisual(
  String text,
  int selStart,
  int selEnd,
  bool isForward,
  String label,
) {
  var chars = text.split('');
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kBlue300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: _kBlue800,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < chars.length; i++)
              Container(
                width: 18,
                height: 24,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: (i >= selStart && i < selEnd)
                      ? _kBlue400.withAlpha(150)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: (i >= selStart && i < selEnd)
                        ? _kBlue600
                        : _kBlue200,
                    width: (i >= selStart && i < selEnd) ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    chars[i],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: (i >= selStart && i < selEnd)
                          ? Colors.white
                          : _kBlue900,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(
              isForward ? Icons.arrow_forward : Icons.arrow_back,
              color: isForward ? _kGreen500 : _kOrange500,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              isForward ? 'Forward' : 'Backward',
              style: TextStyle(
                fontSize: 10,
                color: isForward ? _kGreen500 : _kOrange500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildEventComparisonRow(String eventName, String purpose, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                purpose,
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('DirectionallyExtendSelectionEvent test executing');
  print('=' * 60);

  // Create event instances for demonstration
  var forwardEvent = DirectionallyExtendSelectionEvent(
    dx: 100.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );

  var backwardEvent = DirectionallyExtendSelectionEvent(
    dx: 50.0,
    isEnd: false,
    direction: SelectionExtendDirection.backward,
  );

  var nextLineEvent = DirectionallyExtendSelectionEvent(
    dx: 75.0,
    isEnd: true,
    direction: SelectionExtendDirection.nextLine,
  );

  var previousLineEvent = DirectionallyExtendSelectionEvent(
    dx: 120.0,
    isEnd: true,
    direction: SelectionExtendDirection.previousLine,
  );

  // Print event information
  print('\n[1] DirectionallyExtendSelectionEvent Purpose');
  print('-' * 50);
  print('Event for extending text selection directionally');
  print('Used for keyboard navigation in text editing');
  print('Supports forward, backward, and line navigation');

  print('\n[2] Forward Event Properties');
  print('-' * 50);
  print('direction: ${forwardEvent.direction}');
  print('dx: ${forwardEvent.dx}');
  print('isEnd: ${forwardEvent.isEnd}');
  print('type: ${forwardEvent.type}');

  print('\n[3] Backward Event Properties');
  print('-' * 50);
  print('direction: ${backwardEvent.direction}');
  print('dx: ${backwardEvent.dx}');
  print('isEnd: ${backwardEvent.isEnd}');
  print('type: ${backwardEvent.type}');

  print('\n[4] Next Line Event Properties');
  print('-' * 50);
  print('direction: ${nextLineEvent.direction}');
  print('dx: ${nextLineEvent.dx}');
  print('isEnd: ${nextLineEvent.isEnd}');

  print('\n[5] Previous Line Event Properties');
  print('-' * 50);
  print('direction: ${previousLineEvent.direction}');
  print('dx: ${previousLineEvent.dx}');
  print('isEnd: ${previousLineEvent.isEnd}');

  print('\n[6] SelectionExtendDirection Enum Values');
  print('-' * 50);
  for (var direction in SelectionExtendDirection.values) {
    print('- $direction');
  }
  print('Total directions: ${SelectionExtendDirection.values.length}');

  print('\n[7] Direction Meanings');
  print('-' * 50);
  print('forward: Move selection toward end of text');
  print('backward: Move selection toward start of text');
  print('nextLine: Extend to corresponding position in next line');
  print('previousLine: Extend to corresponding position in previous line');

  print('\n[8] isEnd Property Explained');
  print('-' * 50);
  print('isEnd=true: Extend the end boundary of selection');
  print('isEnd=false: Extend the start boundary of selection');
  print('Useful for shift+arrow key behavior');

  print('\n[9] dx Property Explained');
  print('-' * 50);
  print('dx: Horizontal position for line-based navigation');
  print('Used when extending to next/previous line');
  print('Helps maintain cursor column position');

  print('\n[10] copyWith Method');
  print('-' * 50);
  var copiedEvent = forwardEvent.copyWith(dx: 200.0);
  print('Original dx: ${forwardEvent.dx}');
  print('Copied dx: ${copiedEvent.dx}');
  print('Direction preserved: ${copiedEvent.direction}');

  print('\n[11] Forward Selection Use Case');
  print('-' * 50);
  print('User presses Shift+Right Arrow');
  print('Selection extends forward by one character');
  print('isEnd=true extends right boundary');

  print('\n[12] Backward Selection Use Case');
  print('-' * 50);
  print('User presses Shift+Left Arrow');
  print('Selection extends backward');
  print('isEnd=false moves left boundary');

  print('\n[13] Line Navigation Use Case');
  print('-' * 50);
  print('User presses Shift+Down Arrow');
  print('Selection extends to next line');
  print('dx maintains horizontal position');

  print('\n[14] Character-Level Extension');
  print('-' * 50);
  print('Single character movement');
  print('direction: forward or backward');
  print('Most granular selection extension');

  print('\n[15] Word-Level Extension Concept');
  print('-' * 50);
  print('Word boundaries determined by text');
  print('Usually combined with Ctrl modifier');
  print('Uses GranularlyExtendSelectionEvent');

  print('\n[16] Line-Level Extension');
  print('-' * 50);
  print('nextLine: Extend selection down');
  print('previousLine: Extend selection up');
  print('dx preserves horizontal position');

  print('\n[17] Selection Event Type');
  print('-' * 50);
  print('type: ${forwardEvent.type}');
  print('All selection events have a type property');
  print('Type identifies the event kind');

  print('\n[18] Related Selection Events');
  print('-' * 50);
  print('- SelectWordSelectionEvent (double-tap)');
  print('- SelectAllSelectionEvent (Ctrl+A)');
  print('- ClearSelectionEvent (tap away)');
  print('- GranularlyExtendSelectionEvent (word/line)');
  print('- SelectParagraphSelectionEvent (triple-tap)');

  print('\n[19] Event Construction');
  print('-' * 50);
  print('Required: dx, isEnd, direction');
  print('All parameters are named parameters');
  print('No optional parameters');

  print('\n[20] Practical Keyboard Behavior');
  print('-' * 50);
  print('Shift+Right: forward, isEnd=true');
  print('Shift+Left: backward, isEnd=true');
  print('Shift+Down: nextLine, isEnd=true');
  print('Shift+Up: previousLine, isEnd=true');

  print('\n' + '=' * 60);
  print('DirectionallyExtendSelectionEvent test completed');

  // Build the visual demo UI
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kBlue900, _kBlue700, _kCyan700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kBlue800.withAlpha(100),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.select_all, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'DirectionallyExtendSelectionEvent',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Text Selection Extension Event',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadge('rendering', _kCyan500),
                  SizedBox(width: 8),
                  _buildBadge('SelectionEvent', _kAmber500),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Section 1: Purpose
        _buildSectionHeader('Purpose & Overview', Icons.info),
        _buildCard(
          'What is DirectionallyExtendSelectionEvent?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A selection event that extends the current text selection '
                'in a specific direction. Used for keyboard-based selection '
                'navigation in editable text widgets.',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildPropertyRow(
                'Class Type',
                'extends SelectionEvent',
                Icons.class_,
                _kBlue600,
              ),
              _buildPropertyRow(
                'Package',
                'package:flutter/rendering.dart',
                Icons.folder,
                _kCyan700,
              ),
              _buildPropertyRow(
                'Primary Use',
                'Shift+Arrow key selection',
                Icons.keyboard,
                _kTeal500,
              ),
            ],
          ),
        ),

        // Section 2: Direction Property
        _buildSectionHeader('Direction Property', Icons.directions),
        _buildCard(
          'SelectionExtendDirection Values',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The direction property specifies which way to extend:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              Wrap(
                children: [
                  _buildDirectionChip(
                    'forward',
                    'Toward end',
                    _kGreen500,
                    Icons.arrow_forward,
                  ),
                  _buildDirectionChip(
                    'backward',
                    'Toward start',
                    _kOrange500,
                    Icons.arrow_back,
                  ),
                  _buildDirectionChip(
                    'nextLine',
                    'Line below',
                    _kBlue500,
                    Icons.arrow_downward,
                  ),
                  _buildDirectionChip(
                    'previousLine',
                    'Line above',
                    _kCyan700,
                    Icons.arrow_upward,
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                'SelectionExtendDirection.forward\n'
                'SelectionExtendDirection.backward\n'
                'SelectionExtendDirection.nextLine\n'
                'SelectionExtendDirection.previousLine',
              ),
            ],
          ),
        ),

        // Section 3: dx Property
        _buildSectionHeader('dx Property', Icons.straighten),
        _buildCard(
          'Horizontal Position Value',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyRow(
                'dx',
                'double - horizontal position',
                Icons.swap_horiz,
                _kBlue600,
              ),
              SizedBox(height: 8),
              Text(
                'The dx property stores the horizontal position for line-based '
                'navigation. When extending to next/previous line, dx helps '
                'maintain the cursor column position.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                'var event = DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.nextLine,\n'
                ');\n'
                'print(event.dx); // 100.0',
              ),
            ],
          ),
        ),

        // Section 4: isEnd Property
        _buildSectionHeader('isEnd Property', Icons.compare_arrows),
        _buildCard(
          'Which Selection Boundary to Extend',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kGreen500.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _kGreen500),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.last_page, color: _kGreen500, size: 24),
                          SizedBox(height: 4),
                          Text(
                            'isEnd = true',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _kGreen500,
                            ),
                          ),
                          Text(
                            'Extend end boundary',
                            style: TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kOrange500.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _kOrange500),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.first_page, color: _kOrange500, size: 24),
                          SizedBox(height: 4),
                          Text(
                            'isEnd = false',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _kOrange500,
                            ),
                          ),
                          Text(
                            'Extend start boundary',
                            style: TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 5: Forward Selection
        _buildSectionHeader('Forward Selection', Icons.arrow_forward),
        _buildCard(
          'Extending Selection Forward',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSelectionVisual('Hello World', 0, 5, true, 'Initial: "Hello"'),
              _buildSelectionVisual('Hello World', 0, 6, true, 'After forward: "Hello "'),
              SizedBox(height: 8),
              Text(
                'Forward extension moves the selection boundary toward '
                'the end of the text. Typically triggered by Shift+Right Arrow.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                'var event = DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');',
              ),
            ],
          ),
          accentColor: _kGreen500,
        ),

        // Section 6: Backward Selection
        _buildSectionHeader('Backward Selection', Icons.arrow_back),
        _buildCard(
          'Extending Selection Backward',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSelectionVisual('Hello World', 6, 11, false, 'Initial: "World"'),
              _buildSelectionVisual('Hello World', 5, 11, false, 'After backward: " World"'),
              SizedBox(height: 8),
              Text(
                'Backward extension moves the selection boundary toward '
                'the start of the text. Typically triggered by Shift+Left Arrow.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                'var event = DirectionallyExtendSelectionEvent(\n'
                '  dx: 50.0,\n'
                '  isEnd: false,\n'
                '  direction: SelectionExtendDirection.backward,\n'
                ');',
              ),
            ],
          ),
          accentColor: _kOrange500,
        ),

        // Section 7: By Character
        _buildSectionHeader('Character-Level Extension', Icons.text_fields),
        _buildCard(
          'Single Character Movement',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Character-level extension moves the selection one character '
                'at a time. This is the most granular form of selection extension.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kBlue50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keyboard Shortcuts:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _kBlue800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.keyboard, color: _kBlue600, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Shift + Right Arrow = forward',
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.keyboard, color: _kBlue600, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Shift + Left Arrow = backward',
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 8: By Word
        _buildSectionHeader('Word-Level Extension', Icons.short_text),
        _buildCard(
          'Word Boundary Movement',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Word-level extension is typically handled by '
                'GranularlyExtendSelectionEvent rather than DirectionallyExtendSelectionEvent. '
                'However, directional events can work with word-aware text widgets.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildSelectionVisual('Hello World Test', 0, 5, true, 'Word: "Hello"'),
              _buildSelectionVisual('Hello World Test', 0, 11, true, 'Next word: "Hello World"'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kAmber500.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAmber500),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: _kAmber500, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Ctrl+Shift+Arrow typically uses GranularlyExtendSelectionEvent',
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          accentColor: _kAmber500,
        ),

        // Section 9: By Line
        _buildSectionHeader('Line-Level Extension', Icons.format_line_spacing),
        _buildCard(
          'Line Navigation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kBlue100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_downward, color: _kBlue700, size: 28),
                          SizedBox(height: 4),
                          Text(
                            'nextLine',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kBlue800,
                            ),
                          ),
                          Text(
                            'Shift+Down',
                            style: TextStyle(fontSize: 10, color: _kBlue600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kCyan500.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_upward, color: _kCyan700, size: 28),
                          SizedBox(height: 4),
                          Text(
                            'previousLine',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kCyan700,
                            ),
                          ),
                          Text(
                            'Shift+Up',
                            style: TextStyle(fontSize: 10, color: _kCyan700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Line navigation extends selection across text lines. '
                'The dx property maintains the horizontal cursor position '
                'when moving between lines of different lengths.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                '// Extend to next line at x=75\n'
                'var event = DirectionallyExtendSelectionEvent(\n'
                '  dx: 75.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.nextLine,\n'
                ');',
              ),
            ],
          ),
        ),

        // Section 10: Event Comparison
        _buildSectionHeader('Selection Event Family', Icons.compare),
        _buildCard(
          'Related Selection Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEventComparisonRow(
                'DirectionallyExtendSelectionEvent',
                'Extends by direction (forward, backward, up, down)',
                _kBlue600,
              ),
              _buildEventComparisonRow(
                'GranularlyExtendSelectionEvent',
                'Extends by granularity (character, word, line)',
                _kTeal500,
              ),
              _buildEventComparisonRow(
                'SelectWordSelectionEvent',
                'Selects entire word (double-tap)',
                _kOrange500,
              ),
              _buildEventComparisonRow(
                'SelectParagraphSelectionEvent',
                'Selects entire paragraph (triple-tap)',
                _kGreen500,
              ),
              _buildEventComparisonRow(
                'SelectAllSelectionEvent',
                'Selects all content (Ctrl+A)',
                _kCyan700,
              ),
              _buildEventComparisonRow(
                'ClearSelectionEvent',
                'Clears current selection (tap away)',
                _kRed500,
              ),
            ],
          ),
        ),

        // Practical Use Cases
        _buildSectionHeader('Practical Use Cases', Icons.build),
        _buildCard(
          'Real-World Applications',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: _kGreen500.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: _kGreen500, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Text Editor: Keyboard-based selection with shift+arrows',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: _kBlue500.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.code, color: _kBlue500, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Code Editor: Multi-line selection for code blocks',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: _kCyan500.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.article, color: _kCyan500, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Document Viewer: Text selection for copy/paste',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Constructor Reference
        _buildSectionHeader('Constructor Reference', Icons.construction),
        _buildCard(
          'DirectionallyExtendSelectionEvent Constructor',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeSnippet(
                'DirectionallyExtendSelectionEvent({\n'
                '  required double dx,\n'
                '  required bool isEnd,\n'
                '  required SelectionExtendDirection direction,\n'
                '})',
              ),
              SizedBox(height: 12),
              _buildPropertyRow(
                'dx',
                'double - horizontal position',
                Icons.straighten,
                _kBlue600,
              ),
              _buildPropertyRow(
                'isEnd',
                'bool - extend end (true) or start (false)',
                Icons.compare_arrows,
                _kGreen500,
              ),
              _buildPropertyRow(
                'direction',
                'SelectionExtendDirection - direction to extend',
                Icons.directions,
                _kOrange500,
              ),
            ],
          ),
        ),

        // copyWith Method
        _buildSectionHeader('copyWith Method', Icons.copy),
        _buildCard(
          'Creating Modified Copies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The copyWith method creates a new event with modified properties:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeSnippet(
                'var original = DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');\n'
                '\n'
                'var modified = original.copyWith(\n'
                '  dx: 200.0,\n'
                '  direction: SelectionExtendDirection.backward,\n'
                ');\n'
                '\n'
                '// modified.dx == 200.0\n'
                '// modified.isEnd == true (unchanged)\n'
                '// modified.direction == backward',
              ),
            ],
          ),
        ),

        // Summary
        _buildSectionHeader('Summary', Icons.check_circle),
        _buildCard(
          'Key Takeaways',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyRow(
                'Purpose',
                'Extend text selection directionally',
                Icons.select_all,
                _kBlue600,
              ),
              _buildPropertyRow(
                'Directions',
                'forward, backward, nextLine, previousLine',
                Icons.directions,
                _kGreen500,
              ),
              _buildPropertyRow(
                'Key Properties',
                'dx, isEnd, direction',
                Icons.settings,
                _kOrange500,
              ),
              _buildPropertyRow(
                'Common Trigger',
                'Shift + Arrow keys',
                Icons.keyboard,
                _kCyan700,
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kGreen500, _kTeal500],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: _kGreen500.withAlpha(80),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Test Completed Successfully',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),
      ],
    ),
  );
}
