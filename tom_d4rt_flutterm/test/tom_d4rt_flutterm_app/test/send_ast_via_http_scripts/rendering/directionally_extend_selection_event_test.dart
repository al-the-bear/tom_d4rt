// D4rt deep demo script: DirectionallyExtendSelectionEvent
//
// DirectionallyExtendSelectionEvent is a selection event from Flutter's rendering
// library. It extends text selection in a specific direction, enabling keyboard-based
// selection navigation in editable text widgets. This event is dispatched when users
// hold Shift and press arrow keys to extend their current text selection.
//
// Key properties demonstrated:
//   - direction: SelectionExtendDirection (forward, backward, nextLine, previousLine)
//   - dx: horizontal position for line-based navigation
//   - isEnd: whether to extend the end (true) or start (false) of selection
//
// Sections covered in this demo:
//   1. DirectionallyExtendSelectionEvent overview
//   2. isEnd property behavior
//   3. direction property (forward/backward)
//   4. SelectionEvent base class relationship
//   5. Visual representation of directional selection
//   6. Sample event parameters
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE - Deep Blue Selection Theme
// ═══════════════════════════════════════════════════════════════════════════

var _kBlue50 = Color(0xFFE3F2FD);
var _kBlue300 = Color(0xFF64B5F6);
var _kBlue500 = Color(0xFF2196F3);
var _kBlue600 = Color(0xFF1E88E5);
var _kBlue700 = Color(0xFF1976D2);
var _kBlue800 = Color(0xFF1565C0);
var _kBlue900 = Color(0xFF0D47A1);

var _kCyan400 = Color(0xFF26C6DA);
var _kCyan500 = Color(0xFF00BCD4);
var _kCyan600 = Color(0xFF00ACC1);
var _kCyan700 = Color(0xFF0097A7);

var _kTeal400 = Color(0xFF26A69A);
var _kTeal500 = Color(0xFF009688);
var _kTeal600 = Color(0xFF00897B);

var _kAmber400 = Color(0xFFFFCA28);
var _kAmber500 = Color(0xFFFFC107);
var _kAmber600 = Color(0xFFFFB300);

var _kOrange500 = Color(0xFFFF9800);
var _kOrange600 = Color(0xFFFB8C00);

var _kGreen400 = Color(0xFF66BB6A);
var _kGreen500 = Color(0xFF4CAF50);
var _kGreen600 = Color(0xFF43A047);

var _kRed400 = Color(0xFFEF5350);
var _kRed500 = Color(0xFFF44336);

var _kPurple400 = Color(0xFFAB47BC);
var _kPurple500 = Color(0xFF9C27B0);

var _kSurface = Color(0xFFE8F4FD);
var _kCardBg = Color(0xFFFFFFFF);
var _kCodeBg = Color(0xFF263238);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Section Headers and Cards
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon, Color startColor, Color endColor) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [startColor, endColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: startColor.withAlpha(90),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String title, Widget content, {Color? borderColor}) {
  var color = borderColor ?? _kBlue500;
  return Container(
    margin: EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(70), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
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
        Padding(
          padding: EdgeInsets.all(16),
          child: content,
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String label, String value, IconData icon, Color iconColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kBlue900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: _kBlue700.withAlpha(200),
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

Widget _buildDirectionBadge(String name, String description, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.only(right: 10, bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: color.withAlpha(120)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: color.withAlpha(180),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFF80CBC4),
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _buildSelectionVisualization(
  String text,
  int selectionStart,
  int selectionEnd,
  bool isForwardDirection,
  String label,
  Color highlightColor,
) {
  var characters = text.split('');
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: highlightColor.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _kBlue800,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var idx = 0; idx < characters.length; idx++)
                Container(
                  width: 22,
                  height: 28,
                  margin: EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    color: (idx >= selectionStart && idx < selectionEnd)
                        ? highlightColor.withAlpha(180)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: (idx >= selectionStart && idx < selectionEnd)
                          ? highlightColor
                          : _kBlue300,
                      width: (idx >= selectionStart && idx < selectionEnd) ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      characters[idx],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: (idx >= selectionStart && idx < selectionEnd)
                            ? Colors.white
                            : _kBlue900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              isForwardDirection ? Icons.arrow_forward : Icons.arrow_back,
              color: isForwardDirection ? _kGreen500 : _kOrange500,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              isForwardDirection ? 'Forward Direction' : 'Backward Direction',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isForwardDirection ? _kGreen500 : _kOrange500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(String eventType, String purpose, Color accentColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: accentColor.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withAlpha(50)),
    ),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventType,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              Text(
                purpose,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyboardShortcutRow(String keys, String action, IconData arrowIcon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _kBlue800,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            keys,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(arrowIcon, color: color, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            action,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTagChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(16),
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
  print('DirectionallyExtendSelectionEvent deep demo executing');
  print('=' * 70);

  // Create sample event instances for demonstration purposes
  var forwardExtendEvent = DirectionallyExtendSelectionEvent(
    dx: 150.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );

  var backwardExtendEvent = DirectionallyExtendSelectionEvent(
    dx: 80.0,
    isEnd: false,
    direction: SelectionExtendDirection.backward,
  );

  var nextLineExtendEvent = DirectionallyExtendSelectionEvent(
    dx: 120.0,
    isEnd: true,
    direction: SelectionExtendDirection.nextLine,
  );

  var previousLineExtendEvent = DirectionallyExtendSelectionEvent(
    dx: 90.0,
    isEnd: true,
    direction: SelectionExtendDirection.previousLine,
  );

  // Section 1: DirectionallyExtendSelectionEvent Overview
  print('\n[SECTION 1] DirectionallyExtendSelectionEvent Overview');
  print('-' * 60);
  print('DirectionallyExtendSelectionEvent extends text selection');
  print('in a specific direction using arrow key navigation.');
  print('It is part of Flutter rendering library selection system.');
  print('This event is dispatched when Shift+Arrow keys are pressed.');
  print('The event carries direction, dx position, and isEnd flag.');

  // Section 2: isEnd Property Behavior
  print('\n[SECTION 2] isEnd Property Behavior');
  print('-' * 60);
  print('isEnd determines which selection boundary moves:');
  print('  - isEnd=true: Moves the end/right boundary of selection');
  print('  - isEnd=false: Moves the start/left boundary of selection');
  print('Example with forward event:');
  print('  forwardExtendEvent.isEnd = ${forwardExtendEvent.isEnd}');
  print('Example with backward event:');
  print('  backwardExtendEvent.isEnd = ${backwardExtendEvent.isEnd}');

  // Section 3: Direction Property (Forward/Backward)
  print('\n[SECTION 3] Direction Property (Forward/Backward)');
  print('-' * 60);
  print('SelectionExtendDirection enum values:');
  for (var dir in SelectionExtendDirection.values) {
    print('  - $dir');
  }
  print('Total direction values: ${SelectionExtendDirection.values.length}');
  print('Forward event direction: ${forwardExtendEvent.direction}');
  print('Backward event direction: ${backwardExtendEvent.direction}');
  print('NextLine event direction: ${nextLineExtendEvent.direction}');
  print('PreviousLine event direction: ${previousLineExtendEvent.direction}');

  // Section 4: SelectionEvent Base Class
  print('\n[SECTION 4] SelectionEvent Base Class');
  print('-' * 60);
  print('DirectionallyExtendSelectionEvent extends SelectionEvent');
  print('SelectionEvent is the base class for all selection events.');
  print('It provides the type property for event identification.');
  print('Forward event type: ${forwardExtendEvent.type}');
  print('SelectionEvent hierarchy enables polymorphic handling.');

  // Section 5: Visual Representation of Directional Selection
  print('\n[SECTION 5] Visual Representation of Directional Selection');
  print('-' * 60);
  print('Text: "Flutter Selection Demo"');
  print('Initial selection: [Flutter] (0-7)');
  print('After forward extend: [Flutter ] (0-8)');
  print('After backward extend: [ Flutter] with adjusted start');
  print('Selection visually highlights the affected characters.');

  // Section 6: Sample Event Parameters
  print('\n[SECTION 6] Sample Event Parameters');
  print('-' * 60);
  print('Forward Extend Event Parameters:');
  print('  dx: ${forwardExtendEvent.dx}');
  print('  isEnd: ${forwardExtendEvent.isEnd}');
  print('  direction: ${forwardExtendEvent.direction}');
  print('Backward Extend Event Parameters:');
  print('  dx: ${backwardExtendEvent.dx}');
  print('  isEnd: ${backwardExtendEvent.isEnd}');
  print('  direction: ${backwardExtendEvent.direction}');
  print('NextLine Extend Event Parameters:');
  print('  dx: ${nextLineExtendEvent.dx}');
  print('  isEnd: ${nextLineExtendEvent.isEnd}');
  print('  direction: ${nextLineExtendEvent.direction}');
  print('PreviousLine Extend Event Parameters:');
  print('  dx: ${previousLineExtendEvent.dx}');
  print('  isEnd: ${previousLineExtendEvent.isEnd}');
  print('  direction: ${previousLineExtendEvent.direction}');

  // Additional demonstration: copyWith method
  print('\n[ADDITIONAL] copyWith Method Demonstration');
  print('-' * 60);
  var modifiedEvent = forwardExtendEvent.copyWith(dx: 200.0);
  print('Original forwardExtendEvent.dx: ${forwardExtendEvent.dx}');
  print('Modified event dx after copyWith: ${modifiedEvent.dx}');
  print('Direction preserved: ${modifiedEvent.direction}');
  print('isEnd preserved: ${modifiedEvent.isEnd}');

  var directionChangedEvent = forwardExtendEvent.copyWith(
    direction: SelectionExtendDirection.backward,
  );
  print('Direction changed via copyWith: ${directionChangedEvent.direction}');

  print('\n' + '=' * 70);
  print('DirectionallyExtendSelectionEvent deep demo completed');
  print('=' * 70);

  // Build the visual UI representation
  return SingleChildScrollView(
    padding: EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kBlue900, _kBlue700, _kCyan600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: _kBlue800.withAlpha(120),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.select_all, color: Colors.white, size: 36),
              ),
              SizedBox(height: 16),
              Text(
                'DirectionallyExtendSelectionEvent',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Rendering Selection Event for Directional Extend',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTagChip('rendering', _kCyan400),
                  SizedBox(width: 10),
                  _buildTagChip('SelectionEvent', _kAmber400),
                  SizedBox(width: 10),
                  _buildTagChip('flutter', _kGreen400),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 28),

        // Section 1: DirectionallyExtendSelectionEvent Overview
        _buildSectionHeader(
          'DirectionallyExtendSelectionEvent Overview',
          Icons.info_outline,
          _kBlue800,
          _kBlue600,
        ),
        _buildInfoCard(
          'What is DirectionallyExtendSelectionEvent?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DirectionallyExtendSelectionEvent is a selection event class from '
                'Flutter\'s rendering library that extends the current text selection '
                'in a specific direction. It is typically dispatched when users press '
                'Shift combined with arrow keys to extend their selection.',
                style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildPropertyRow(
                'Class Hierarchy',
                'extends SelectionEvent',
                Icons.account_tree,
                _kBlue600,
              ),
              _buildPropertyRow(
                'Package Location',
                'package:flutter/rendering.dart',
                Icons.folder_open,
                _kCyan600,
              ),
              _buildPropertyRow(
                'Primary Purpose',
                'Keyboard-based selection extension',
                Icons.keyboard,
                _kTeal500,
              ),
              _buildPropertyRow(
                'Common Trigger',
                'Shift + Arrow Keys',
                Icons.arrow_forward,
                _kGreen500,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Event Construction Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DirectionallyExtendSelectionEvent requires three named parameters:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,           // horizontal position\n'
                '  isEnd: true,         // which boundary to extend\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ')',
              ),
            ],
          ),
          borderColor: _kTeal500,
        ),

        // Section 2: isEnd Property
        _buildSectionHeader(
          'isEnd Property',
          Icons.compare_arrows,
          _kCyan700,
          _kCyan500,
        ),
        _buildInfoCard(
          'Understanding the isEnd Property',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The isEnd property determines which boundary of the selection '
                'will be modified when the event is processed. This is crucial for '
                'understanding how selection extension works in text editing.',
                style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _kGreen500.withAlpha(20),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _kGreen500, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.last_page, color: _kGreen500, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'isEnd = true',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _kGreen500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Extends the END boundary of the selection',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _kOrange500.withAlpha(20),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _kOrange500, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.first_page, color: _kOrange500, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'isEnd = false',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _kOrange500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Extends the START boundary of the selection',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildCodeBlock(
                '// Extending the end boundary (right side)\n'
                'var endExtend = DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,\n'
                '  isEnd: true,  // <-- extends END\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');\n\n'
                '// Extending the start boundary (left side)\n'
                'var startExtend = DirectionallyExtendSelectionEvent(\n'
                '  dx: 50.0,\n'
                '  isEnd: false,  // <-- extends START\n'
                '  direction: SelectionExtendDirection.backward,\n'
                ');',
              ),
            ],
          ),
        ),

        // Section 3: Direction Property (Forward/Backward)
        _buildSectionHeader(
          'Direction Property (Forward/Backward)',
          Icons.swap_horiz,
          _kTeal600,
          _kTeal400,
        ),
        _buildInfoCard(
          'SelectionExtendDirection Enum',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The direction property uses the SelectionExtendDirection enum '
                'to specify which direction the selection should extend:',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Wrap(
                children: [
                  _buildDirectionBadge(
                    'forward',
                    'Toward text end',
                    _kGreen500,
                    Icons.arrow_forward,
                  ),
                  _buildDirectionBadge(
                    'backward',
                    'Toward text start',
                    _kOrange500,
                    Icons.arrow_back,
                  ),
                  _buildDirectionBadge(
                    'nextLine',
                    'To line below',
                    _kBlue500,
                    Icons.arrow_downward,
                  ),
                  _buildDirectionBadge(
                    'previousLine',
                    'To line above',
                    _kPurple500,
                    Icons.arrow_upward,
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Forward Direction Explained',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SelectionExtendDirection.forward moves the selection boundary '
                'toward the end of the text. This is typically triggered when '
                'the user presses Shift + Right Arrow.',
                style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
              ),
              SizedBox(height: 12),
              _buildSelectionVisualization(
                'Hello World Demo',
                0,
                5,
                true,
                'Initial: "Hello" selected',
                _kGreen500,
              ),
              _buildSelectionVisualization(
                'Hello World Demo',
                0,
                6,
                true,
                'After forward: "Hello " selected',
                _kGreen600,
              ),
              _buildCodeBlock(
                'var forwardEvent = DirectionallyExtendSelectionEvent(\n'
                '  dx: 150.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');',
              ),
            ],
          ),
          borderColor: _kGreen500,
        ),
        _buildInfoCard(
          'Backward Direction Explained',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SelectionExtendDirection.backward moves the selection boundary '
                'toward the start of the text. This is typically triggered when '
                'the user presses Shift + Left Arrow.',
                style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
              ),
              SizedBox(height: 12),
              _buildSelectionVisualization(
                'Hello World Demo',
                6,
                11,
                false,
                'Initial: "World" selected',
                _kOrange500,
              ),
              _buildSelectionVisualization(
                'Hello World Demo',
                5,
                11,
                false,
                'After backward: " World" selected',
                _kOrange600,
              ),
              _buildCodeBlock(
                'var backwardEvent = DirectionallyExtendSelectionEvent(\n'
                '  dx: 80.0,\n'
                '  isEnd: false,\n'
                '  direction: SelectionExtendDirection.backward,\n'
                ');',
              ),
            ],
          ),
          borderColor: _kOrange500,
        ),

        // Section 4: SelectionEvent Base Class
        _buildSectionHeader(
          'SelectionEvent Base Class',
          Icons.account_tree,
          _kPurple500,
          _kPurple400,
        ),
        _buildInfoCard(
          'SelectionEvent Class Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DirectionallyExtendSelectionEvent is one of several selection '
                'event types that extend the abstract SelectionEvent base class. '
                'This inheritance allows for polymorphic handling of selection events.',
                style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildComparisonRow(
                'SelectionEvent',
                'Abstract base class for all selection events',
                _kBlue600,
              ),
              _buildComparisonRow(
                'DirectionallyExtendSelectionEvent',
                'Directional extension (arrow keys)',
                _kGreen500,
              ),
              _buildComparisonRow(
                'GranularlyExtendSelectionEvent',
                'Word/line granularity extension',
                _kTeal500,
              ),
              _buildComparisonRow(
                'SelectWordSelectionEvent',
                'Double-tap word selection',
                _kOrange500,
              ),
              _buildComparisonRow(
                'SelectAllSelectionEvent',
                'Select all text (Ctrl+A)',
                _kAmber600,
              ),
              _buildComparisonRow(
                'ClearSelectionEvent',
                'Clear selection (tap away)',
                _kRed500,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'The type Property',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Every SelectionEvent has a type property that identifies the '
                'kind of selection event. This is useful for event handling and '
                'debugging purposes.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'var event = DirectionallyExtendSelectionEvent(\n'
                '  dx: 100.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');\n\n'
                'print(event.type);\n'
                '// Output: SelectionEventType.directionallyExtendSelection',
              ),
            ],
          ),
          borderColor: _kPurple400,
        ),

        // Section 5: Visual Representation of Directional Selection
        _buildSectionHeader(
          'Visual Representation of Directional Selection',
          Icons.visibility,
          _kAmber600,
          _kAmber400,
        ),
        _buildInfoCard(
          'Character-by-Character Selection Display',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The following visualizations show how selection extends '
                'character by character when directional extend events are processed:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 16),
              _buildSelectionVisualization(
                'Flutter Selection',
                0,
                7,
                true,
                'Step 1: "Flutter" selected',
                _kBlue500,
              ),
              _buildSelectionVisualization(
                'Flutter Selection',
                0,
                8,
                true,
                'Step 2: Forward extend adds space',
                _kBlue600,
              ),
              _buildSelectionVisualization(
                'Flutter Selection',
                0,
                11,
                true,
                'Step 3: Continue forward to "Sel"',
                _kBlue700,
              ),
              _buildSelectionVisualization(
                'Flutter Selection',
                0,
                17,
                true,
                'Step 4: Full text selected',
                _kBlue800,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Line-Based Selection Extension',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For nextLine and previousLine directions, the dx property '
                'is crucial as it helps maintain the horizontal cursor position '
                'when moving between lines.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kBlue50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBlue300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Multi-line Text Example:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _kBlue800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Line 1: Hello World\n'
                      'Line 2: Flutter Demo\n'
                      'Line 3: Selection Event',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: _kBlue900,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'When extending to nextLine, dx=120.0 would position '
                      'the selection at roughly the same horizontal offset.',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          borderColor: _kCyan600,
        ),

        // Section 6: Sample Event Parameters
        _buildSectionHeader(
          'Sample Event Parameters',
          Icons.code,
          _kRed500,
          _kRed400,
        ),
        _buildInfoCard(
          'Parameter Reference Table',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyRow(
                'dx (double)',
                'Horizontal position for line navigation',
                Icons.swap_horiz,
                _kBlue600,
              ),
              _buildPropertyRow(
                'isEnd (bool)',
                'true = extend end, false = extend start',
                Icons.compare_arrows,
                _kGreen600,
              ),
              _buildPropertyRow(
                'direction (enum)',
                'SelectionExtendDirection value',
                Icons.directions,
                _kOrange600,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Keyboard Shortcuts Mapping',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common keyboard shortcuts and their corresponding '
                'DirectionallyExtendSelectionEvent parameters:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 14),
              _buildKeyboardShortcutRow(
                'Shift+Right',
                'direction: forward, isEnd: true',
                Icons.arrow_forward,
                _kGreen500,
              ),
              _buildKeyboardShortcutRow(
                'Shift+Left',
                'direction: backward, isEnd: true',
                Icons.arrow_back,
                _kOrange500,
              ),
              _buildKeyboardShortcutRow(
                'Shift+Down',
                'direction: nextLine, isEnd: true',
                Icons.arrow_downward,
                _kBlue500,
              ),
              _buildKeyboardShortcutRow(
                'Shift+Up',
                'direction: previousLine, isEnd: true',
                Icons.arrow_upward,
                _kPurple500,
              ),
            ],
          ),
          borderColor: _kAmber500,
        ),
        _buildInfoCard(
          'Complete Code Examples',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Creating and using DirectionallyExtendSelectionEvent:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kBlue800,
                ),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                '// Example 1: Forward Selection\n'
                'var forwardEvent = DirectionallyExtendSelectionEvent(\n'
                '  dx: 150.0,\n'
                '  isEnd: true,\n'
                '  direction: SelectionExtendDirection.forward,\n'
                ');\n'
                'print(forwardEvent.dx);        // 150.0\n'
                'print(forwardEvent.isEnd);     // true\n'
                'print(forwardEvent.direction); // forward\n'
                'print(forwardEvent.type);      // directionallyExtendSelection',
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Example 2: Using copyWith\n'
                'var modified = forwardEvent.copyWith(\n'
                '  dx: 200.0,\n'
                '  direction: SelectionExtendDirection.nextLine,\n'
                ');\n'
                'print(modified.dx);        // 200.0\n'
                'print(modified.direction); // nextLine\n'
                'print(modified.isEnd);     // true (preserved)',
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Example 3: All Directions\n'
                'var directions = [\n'
                '  SelectionExtendDirection.forward,\n'
                '  SelectionExtendDirection.backward,\n'
                '  SelectionExtendDirection.nextLine,\n'
                '  SelectionExtendDirection.previousLine,\n'
                '];\n'
                'for (var dir in directions) {\n'
                '  var event = DirectionallyExtendSelectionEvent(\n'
                '    dx: 100.0,\n'
                '    isEnd: true,\n'
                '    direction: dir,\n'
                '  );\n'
                '  print(event.direction);\n'
                '}',
              ),
            ],
          ),
          borderColor: _kTeal600,
        ),

        // Footer
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _kBlue50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBlue300),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kGreen500, size: 36),
              SizedBox(height: 10),
              Text(
                'DirectionallyExtendSelectionEvent Deep Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kBlue800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text(
                'All sections covered: overview, isEnd, direction, '
                'SelectionEvent base, visual representation, and sample parameters.',
                style: TextStyle(
                  fontSize: 12,
                  color: _kBlue700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}
