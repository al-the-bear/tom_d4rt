// D4rt deep demo script: GranularlyExtendSelectionEvent
//
// GranularlyExtendSelectionEvent is a selection event from Flutter's rendering
// library. It extends text selection using text granularity units like character,
// word, line, or paragraph. This event is typically dispatched when users use
// platform-specific keyboard shortcuts to extend selection by word or line.
//
// Key properties demonstrated:
//   - isEnd: whether to extend the end (true) or start (false) of selection
//   - forward: direction of extension (true = forward, false = backward)
//   - granularity: TextGranularity (character, word, line, paragraph, document)
//
// Sections covered in this demo:
//   1. GranularlyExtendSelectionEvent overview
//   2. isEnd property behavior
//   3. forward property (direction)
//   4. granularity (character/word/line/paragraph)
//   5. Visual selection demo
//   6. Event creation examples
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE - Teal Selection Theme
// ═══════════════════════════════════════════════════════════════════════════

var _kTeal50 = Color(0xFFE0F2F1);
var _kTeal100 = Color(0xFFB2DFDB);
var _kTeal300 = Color(0xFF4DB6AC);
var _kTeal500 = Color(0xFF009688);
var _kTeal600 = Color(0xFF00897B);
var _kTeal700 = Color(0xFF00796B);
var _kTeal800 = Color(0xFF00695C);
var _kTeal900 = Color(0xFF004D40);

var _kCyan400 = Color(0xFF26C6DA);
var _kCyan500 = Color(0xFF00BCD4);
var _kCyan600 = Color(0xFF00ACC1);
var _kCyan700 = Color(0xFF0097A7);

var _kBlue500 = Color(0xFF2196F3);
var _kBlue600 = Color(0xFF1E88E5);
var _kBlue700 = Color(0xFF1976D2);
var _kBlue800 = Color(0xFF1565C0);

var _kAmber400 = Color(0xFFFFCA28);
var _kAmber500 = Color(0xFFFFC107);
var _kAmber600 = Color(0xFFFFB300);

var _kOrange400 = Color(0xFFFFA726);
var _kOrange500 = Color(0xFFFF9800);
var _kOrange600 = Color(0xFFFB8C00);

var _kGreen400 = Color(0xFF66BB6A);
var _kGreen500 = Color(0xFF4CAF50);
var _kGreen600 = Color(0xFF43A047);
var _kGreen700 = Color(0xFF388E3C);

var _kRed400 = Color(0xFFEF5350);
var _kRed500 = Color(0xFFF44336);

var _kPurple400 = Color(0xFFAB47BC);
var _kPurple500 = Color(0xFF9C27B0);
var _kPurple600 = Color(0xFF8E24AA);

var _kIndigo400 = Color(0xFF5C6BC0);
var _kIndigo500 = Color(0xFF3F51B5);
var _kIndigo600 = Color(0xFF3949AB);

var _kSurface = Color(0xFFE0F2F1);
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
  var color = borderColor ?? _kTeal500;
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
                  color: _kTeal900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: _kTeal700.withAlpha(200),
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

Widget _buildGranularityBadge(String name, String description, Color color, IconData icon) {
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

Widget _buildWordSelectionVisualization(
  String text,
  List<int> wordBoundaries,
  int selectedWordStart,
  int selectedWordEnd,
  bool isForward,
  String label,
  Color highlightColor,
) {
  var words = text.split(' ');
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
            color: _kTeal800,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var idx = 0; idx < words.length; idx++)
                Container(
                  margin: EdgeInsets.only(right: 6),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: (idx >= selectedWordStart && idx < selectedWordEnd)
                        ? highlightColor.withAlpha(180)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (idx >= selectedWordStart && idx < selectedWordEnd)
                          ? highlightColor
                          : _kTeal300,
                      width: (idx >= selectedWordStart && idx < selectedWordEnd) ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    words[idx],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: (idx >= selectedWordStart && idx < selectedWordEnd)
                          ? Colors.white
                          : _kTeal900,
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
              isForward ? Icons.arrow_forward : Icons.arrow_back,
              color: isForward ? _kGreen500 : _kOrange500,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              isForward ? 'Forward (toward end)' : 'Backward (toward start)',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isForward ? _kGreen500 : _kOrange500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCharacterSelectionVisualization(
  String text,
  int selectionStart,
  int selectionEnd,
  bool isForward,
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
            color: _kTeal800,
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
                          : _kTeal300,
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
                            : _kTeal900,
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
              isForward ? Icons.arrow_forward : Icons.arrow_back,
              color: isForward ? _kGreen500 : _kOrange500,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              isForward ? 'Forward Direction' : 'Backward Direction',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isForward ? _kGreen500 : _kOrange500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLineSelectionVisualization(
  List<String> lines,
  int selectedLineStart,
  int selectedLineEnd,
  bool isForward,
  String label,
  Color highlightColor,
) {
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
            color: _kTeal800,
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var idx = 0; idx < lines.length; idx++)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: (idx >= selectedLineStart && idx < selectedLineEnd)
                      ? highlightColor.withAlpha(180)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (idx >= selectedLineStart && idx < selectedLineEnd)
                        ? highlightColor
                        : _kTeal300,
                    width: (idx >= selectedLineStart && idx < selectedLineEnd) ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: (idx >= selectedLineStart && idx < selectedLineEnd)
                            ? Colors.white.withAlpha(60)
                            : _kTeal100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '${idx + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: (idx >= selectedLineStart && idx < selectedLineEnd)
                                ? Colors.white
                                : _kTeal700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        lines[idx],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: (idx >= selectedLineStart && idx < selectedLineEnd)
                              ? Colors.white
                              : _kTeal900,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              isForward ? Icons.arrow_downward : Icons.arrow_upward,
              color: isForward ? _kGreen500 : _kOrange500,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              isForward ? 'Forward (down)' : 'Backward (up)',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isForward ? _kGreen500 : _kOrange500,
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
            color: _kTeal800,
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

Widget _buildGranularityCard(
  String granularityName,
  String description,
  String example,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                granularityName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: color.withAlpha(40)),
                ),
                child: Text(
                  example,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: _kTeal900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('GranularlyExtendSelectionEvent deep demo executing');
  print('=' * 70);

  // Create sample event instances for demonstration
  var characterForwardEvent = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.character,
  );

  var wordForwardEvent = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.word,
  );

  var lineForwardEvent = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.line,
  );

  var paragraphForwardEvent = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.paragraph,
  );

  var wordBackwardEvent = GranularlyExtendSelectionEvent(
    isEnd: false,
    forward: false,
    granularity: TextGranularity.word,
  );

  var documentEvent = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.document,
  );

  // Section 1: GranularlyExtendSelectionEvent Overview
  print('\n[SECTION 1] GranularlyExtendSelectionEvent Overview');
  print('-' * 60);
  print('GranularlyExtendSelectionEvent extends text selection');
  print('using text granularity units (character, word, line, etc.).');
  print('This event is dispatched when platform-specific shortcuts');
  print('are used to extend selection by word, line, or paragraph.');
  print('Common triggers: Option+Shift+Arrow (macOS), Ctrl+Shift+Arrow (Windows).');

  // Section 2: isEnd Property Behavior
  print('\n[SECTION 2] isEnd Property Behavior');
  print('-' * 60);
  print('isEnd determines which selection boundary is moved:');
  print('  - isEnd=true: Extends the end (right/bottom) boundary');
  print('  - isEnd=false: Extends the start (left/top) boundary');
  print('Example with word forward event:');
  print('  wordForwardEvent.isEnd = ${wordForwardEvent.isEnd}');
  print('Example with word backward event:');
  print('  wordBackwardEvent.isEnd = ${wordBackwardEvent.isEnd}');

  // Section 3: forward Property (Direction)
  print('\n[SECTION 3] forward Property (Direction)');
  print('-' * 60);
  print('forward property specifies the direction of extension:');
  print('  - forward=true: Extends toward the end of text');
  print('  - forward=false: Extends toward the start of text');
  print('Word forward event: forward = ${wordForwardEvent.forward}');
  print('Word backward event: forward = ${wordBackwardEvent.forward}');
  print('Character forward event: forward = ${characterForwardEvent.forward}');

  // Section 4: granularity (character/word/line/paragraph)
  print('\n[SECTION 4] Granularity (TextGranularity Enum)');
  print('-' * 60);
  print('TextGranularity enum values:');
  for (var gran in TextGranularity.values) {
    print('  - $gran');
  }
  print('Total granularity values: ${TextGranularity.values.length}');
  print('Character event granularity: ${characterForwardEvent.granularity}');
  print('Word event granularity: ${wordForwardEvent.granularity}');
  print('Line event granularity: ${lineForwardEvent.granularity}');
  print('Paragraph event granularity: ${paragraphForwardEvent.granularity}');
  print('Document event granularity: ${documentEvent.granularity}');

  // Section 5: Visual Selection Demo
  print('\n[SECTION 5] Visual Selection Demo');
  print('-' * 60);
  print('Text: "The quick brown fox jumps over"');
  print('Character granularity: extends one character at a time');
  print('Word granularity: extends one word at a time');
  print('Line granularity: extends to line boundary');
  print('Paragraph granularity: extends to paragraph boundary');
  print('Document granularity: extends to document boundary');

  // Section 6: Event Creation Examples
  print('\n[SECTION 6] Event Creation Examples');
  print('-' * 60);
  print('Character Forward Event:');
  print('  isEnd: ${characterForwardEvent.isEnd}');
  print('  forward: ${characterForwardEvent.forward}');
  print('  granularity: ${characterForwardEvent.granularity}');
  print('  type: ${characterForwardEvent.type}');
  print('Word Forward Event:');
  print('  isEnd: ${wordForwardEvent.isEnd}');
  print('  forward: ${wordForwardEvent.forward}');
  print('  granularity: ${wordForwardEvent.granularity}');
  print('  type: ${wordForwardEvent.type}');
  print('Line Forward Event:');
  print('  isEnd: ${lineForwardEvent.isEnd}');
  print('  forward: ${lineForwardEvent.forward}');
  print('  granularity: ${lineForwardEvent.granularity}');
  print('Paragraph Forward Event:');
  print('  isEnd: ${paragraphForwardEvent.isEnd}');
  print('  forward: ${paragraphForwardEvent.forward}');
  print('  granularity: ${paragraphForwardEvent.granularity}');
  print('Document Event:');
  print('  isEnd: ${documentEvent.isEnd}');
  print('  forward: ${documentEvent.forward}');
  print('  granularity: ${documentEvent.granularity}');

  // Event creation for different granularities
  print('\n[ADDITIONAL] Creating Events with Different Granularities');
  print('-' * 60);
  var allGranularities = TextGranularity.values;
  print('Available TextGranularity values: ${allGranularities.length}');
  for (var gran in allGranularities) {
    var testEvent = GranularlyExtendSelectionEvent(
      isEnd: true,
      forward: true,
      granularity: gran,
    );
    print('  Created event with granularity: ${testEvent.granularity}');
  }
  print('All granularity event types created successfully.');

  print('\n' + '=' * 70);
  print('GranularlyExtendSelectionEvent deep demo completed');
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
              colors: [_kTeal900, _kTeal700, _kCyan600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: _kTeal800.withAlpha(120),
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
                child: Icon(Icons.text_fields, color: Colors.white, size: 36),
              ),
              SizedBox(height: 16),
              Text(
                'GranularlyExtendSelectionEvent',
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
                'Granular Text Selection Extension Event',
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
                  _buildTagChip('TextGranularity', _kGreen400),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 28),

        // Section 1: GranularlyExtendSelectionEvent Overview
        _buildSectionHeader(
          'GranularlyExtendSelectionEvent Overview',
          Icons.info_outline,
          _kTeal800,
          _kTeal600,
        ),
        _buildInfoCard(
          'What is GranularlyExtendSelectionEvent?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GranularlyExtendSelectionEvent is a selection event class from '
                'Flutter\'s rendering library that extends the current text selection '
                'using text granularity units. Unlike DirectionallyExtendSelectionEvent '
                'which moves by single characters or lines, this event extends by '
                'logical text units like words or paragraphs.',
                style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildPropertyRow(
                'Class Hierarchy',
                'extends SelectionEvent',
                Icons.account_tree,
                _kTeal600,
              ),
              _buildPropertyRow(
                'Package Location',
                'package:flutter/rendering.dart',
                Icons.folder_open,
                _kCyan600,
              ),
              _buildPropertyRow(
                'Primary Purpose',
                'Granular selection extension',
                Icons.text_fields,
                _kBlue500,
              ),
              _buildPropertyRow(
                'Common Trigger',
                'Ctrl/Option + Shift + Arrow Keys',
                Icons.keyboard,
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
                'GranularlyExtendSelectionEvent requires three named parameters:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,                    // which boundary\n'
                '  forward: true,                  // direction\n'
                '  granularity: TextGranularity.word,  // unit\n'
                ')',
              ),
            ],
          ),
          borderColor: _kCyan600,
        ),
        _buildInfoCard(
          'Key Differences from DirectionallyExtendSelectionEvent',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComparisonRow(
                'DirectionallyExtendSelectionEvent',
                'Uses direction enum (forward, backward, nextLine, previousLine) with dx position',
                _kBlue500,
              ),
              _buildComparisonRow(
                'GranularlyExtendSelectionEvent',
                'Uses granularity enum (character, word, line, paragraph, document)',
                _kTeal500,
              ),
              SizedBox(height: 12),
              Text(
                'GranularlyExtendSelectionEvent is ideal for semantic text navigation, '
                'while DirectionallyExtendSelectionEvent is for positional navigation.',
                style: TextStyle(fontSize: 12, color: Colors.black87, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          borderColor: _kPurple500,
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
                'will be extended when the event is processed. This allows '
                'extending selection from either end.',
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
                            'Extends the END boundary',
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
                            'Extends the START boundary',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                            textAlign: TextAlign.center,
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
        _buildInfoCard(
          'isEnd with Word Granularity Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When isEnd=true and extending forward by word, the end '
                'boundary moves to include the next word:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'The quick brown fox',
                [0, 4, 10, 16],
                0,
                1,
                true,
                'Initial: "The" selected',
                _kBlue500,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox',
                [0, 4, 10, 16],
                0,
                2,
                true,
                'After extend (isEnd=true): "The quick" selected',
                _kBlue600,
              ),
              SizedBox(height: 8),
              _buildCodeBlock(
                'var event = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,   // extend END boundary\n'
                '  forward: true, // forward direction\n'
                '  granularity: TextGranularity.word,\n'
                ');',
              ),
            ],
          ),
          borderColor: _kBlue500,
        ),

        // Section 3: forward Property
        _buildSectionHeader(
          'forward Property',
          Icons.swap_horiz,
          _kGreen600,
          _kGreen400,
        ),
        _buildInfoCard(
          'Understanding the forward Property',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The forward property (bool) specifies the direction in which '
                'the selection should be extended. Unlike DirectionallyExtendSelectionEvent '
                'which uses an enum, GranularlyExtendSelectionEvent uses a simple boolean.',
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
                          Icon(Icons.arrow_forward, color: _kGreen500, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'forward = true',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _kGreen500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Extends toward text end',
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
                          Icon(Icons.arrow_back, color: _kOrange500, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'forward = false',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _kOrange500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Extends toward text start',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                            textAlign: TextAlign.center,
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
        _buildInfoCard(
          'Forward vs Backward Extension',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstrating forward and backward word extension:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'Flutter is great',
                [0, 8, 11],
                1,
                2,
                true,
                'Initial: "is" selected',
                _kPurple500,
              ),
              _buildWordSelectionVisualization(
                'Flutter is great',
                [0, 8, 11],
                1,
                3,
                true,
                'Forward extend: "is great"',
                _kGreen500,
              ),
              _buildWordSelectionVisualization(
                'Flutter is great',
                [0, 8, 11],
                0,
                2,
                false,
                'Backward extend: "Flutter is"',
                _kOrange500,
              ),
            ],
          ),
          borderColor: _kPurple500,
        ),

        // Section 4: granularity (character/word/line/paragraph)
        _buildSectionHeader(
          'Granularity (character/word/line/paragraph)',
          Icons.format_size,
          _kIndigo600,
          _kIndigo400,
        ),
        _buildInfoCard(
          'TextGranularity Enum Values',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The granularity property specifies the text unit for selection extension:',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Wrap(
                children: [
                  _buildGranularityBadge(
                    'character',
                    'Single char',
                    _kBlue500,
                    Icons.text_format,
                  ),
                  _buildGranularityBadge(
                    'word',
                    'Whole word',
                    _kGreen500,
                    Icons.short_text,
                  ),
                  _buildGranularityBadge(
                    'line',
                    'Full line',
                    _kOrange500,
                    Icons.notes,
                  ),
                  _buildGranularityBadge(
                    'paragraph',
                    'Paragraph',
                    _kPurple500,
                    Icons.format_align_left,
                  ),
                  _buildGranularityBadge(
                    'document',
                    'Entire doc',
                    _kRed500,
                    Icons.article,
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Character Granularity',
          _buildGranularityCard(
            'TextGranularity.character',
            'Extends selection by one character at a time. This is the smallest '
            'unit of text selection and behaves similarly to single arrow key navigation.',
            'Text: "Hello" -> H|ello| -> Shift+Right -> He|llo|',
            Icons.text_format,
            _kBlue500,
          ),
          borderColor: _kBlue500,
        ),
        _buildInfoCard(
          'Word Granularity',
          _buildGranularityCard(
            'TextGranularity.word',
            'Extends selection by one word at a time. A word is typically defined '
            'as a sequence of alphanumeric characters separated by whitespace or punctuation.',
            'Text: "Hello World" -> |Hello| -> extend -> |Hello World|',
            Icons.short_text,
            _kGreen500,
          ),
          borderColor: _kGreen500,
        ),
        _buildInfoCard(
          'Line Granularity',
          _buildGranularityCard(
            'TextGranularity.line',
            'Extends selection to include the entire current line or the next/previous '
            'line boundary. Useful for selecting complete lines of text.',
            'Line 1: "First line"\\nLine 2: "Second line"\\nSelect Line 1, extend -> Both lines',
            Icons.notes,
            _kOrange500,
          ),
          borderColor: _kOrange500,
        ),
        _buildInfoCard(
          'Paragraph Granularity',
          _buildGranularityCard(
            'TextGranularity.paragraph',
            'Extends selection to include the entire paragraph. A paragraph is '
            'typically defined as text separated by paragraph breaks (double newlines).',
            'Para 1: "Intro text"\\n\\nPara 2: "Body text"\\nSelect Para 1, extend -> Both paras',
            Icons.format_align_left,
            _kPurple500,
          ),
          borderColor: _kPurple500,
        ),
        _buildInfoCard(
          'Document Granularity',
          _buildGranularityCard(
            'TextGranularity.document',
            'Extends selection to include the entire document. This is equivalent '
            'to selecting all text from the current position to the document boundary.',
            'Any position -> extend forward with document -> select to end of document',
            Icons.article,
            _kRed500,
          ),
          borderColor: _kRed500,
        ),

        // Section 5: Visual Selection Demo
        _buildSectionHeader(
          'Visual Selection Demo',
          Icons.visibility,
          _kAmber600,
          _kAmber400,
        ),
        _buildInfoCard(
          'Character-by-Character Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstrating character granularity selection extension:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCharacterSelectionVisualization(
                'Flutter Demo',
                0,
                3,
                true,
                'Step 1: "Flu" selected',
                _kBlue500,
              ),
              _buildCharacterSelectionVisualization(
                'Flutter Demo',
                0,
                4,
                true,
                'Step 2: Character extend -> "Flut"',
                _kBlue600,
              ),
              _buildCharacterSelectionVisualization(
                'Flutter Demo',
                0,
                5,
                true,
                'Step 3: Character extend -> "Flutt"',
                _kBlue700,
              ),
              _buildCharacterSelectionVisualization(
                'Flutter Demo',
                0,
                7,
                true,
                'Step 4: Full word "Flutter"',
                _kBlue800,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Word-by-Word Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstrating word granularity selection extension:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                [0, 4, 10, 16, 20],
                0,
                1,
                true,
                'Step 1: "The" selected',
                _kGreen400,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                [0, 4, 10, 16, 20],
                0,
                2,
                true,
                'Step 2: Word extend -> "The quick"',
                _kGreen500,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                [0, 4, 10, 16, 20],
                0,
                3,
                true,
                'Step 3: Word extend -> "The quick brown"',
                _kGreen600,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                [0, 4, 10, 16, 20],
                0,
                5,
                true,
                'Step 4: All words selected',
                _kGreen700,
              ),
            ],
          ),
          borderColor: _kGreen500,
        ),
        _buildInfoCard(
          'Line-by-Line Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstrating line granularity selection extension:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildLineSelectionVisualization(
                ['First line of text', 'Second line here', 'Third line follows', 'Fourth and final'],
                0,
                1,
                true,
                'Step 1: Line 1 selected',
                _kOrange400,
              ),
              _buildLineSelectionVisualization(
                ['First line of text', 'Second line here', 'Third line follows', 'Fourth and final'],
                0,
                2,
                true,
                'Step 2: Line extend -> Lines 1-2',
                _kOrange500,
              ),
              _buildLineSelectionVisualization(
                ['First line of text', 'Second line here', 'Third line follows', 'Fourth and final'],
                0,
                4,
                true,
                'Step 3: All lines selected',
                _kOrange600,
              ),
            ],
          ),
          borderColor: _kOrange500,
        ),
        _buildInfoCard(
          'Backward Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demonstrating backward selection with isEnd=false:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'Start Middle End',
                [0, 6, 13],
                2,
                3,
                false,
                'Initial: "End" selected',
                _kPurple400,
              ),
              _buildWordSelectionVisualization(
                'Start Middle End',
                [0, 6, 13],
                1,
                3,
                false,
                'Backward extend: "Middle End"',
                _kPurple500,
              ),
              _buildWordSelectionVisualization(
                'Start Middle End',
                [0, 6, 13],
                0,
                3,
                false,
                'Backward extend: "Start Middle End"',
                _kPurple600,
              ),
              SizedBox(height: 8),
              _buildCodeBlock(
                '// Backward selection event\n'
                'var event = GranularlyExtendSelectionEvent(\n'
                '  isEnd: false,  // extend START boundary\n'
                '  forward: false, // backward direction\n'
                '  granularity: TextGranularity.word,\n'
                ');',
              ),
            ],
          ),
          borderColor: _kPurple500,
        ),

        // Section 6: Event Creation Examples
        _buildSectionHeader(
          'Event Creation Examples',
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
                'isEnd (bool)',
                'true = extend end, false = extend start',
                Icons.compare_arrows,
                _kTeal600,
              ),
              _buildPropertyRow(
                'forward (bool)',
                'true = toward end, false = toward start',
                Icons.swap_horiz,
                _kGreen600,
              ),
              _buildPropertyRow(
                'granularity (enum)',
                'TextGranularity value',
                Icons.format_size,
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
                'GranularlyExtendSelectionEvent parameters:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 14),
              _buildKeyboardShortcutRow(
                'Ctrl+Shift+Right',
                'forward: true, granularity: word (Windows/Linux)',
                Icons.arrow_forward,
                _kGreen500,
              ),
              _buildKeyboardShortcutRow(
                'Option+Shift+Right',
                'forward: true, granularity: word (macOS)',
                Icons.arrow_forward,
                _kGreen500,
              ),
              _buildKeyboardShortcutRow(
                'Ctrl+Shift+Left',
                'forward: false, granularity: word (Windows/Linux)',
                Icons.arrow_back,
                _kOrange500,
              ),
              _buildKeyboardShortcutRow(
                'Option+Shift+Left',
                'forward: false, granularity: word (macOS)',
                Icons.arrow_back,
                _kOrange500,
              ),
              _buildKeyboardShortcutRow(
                'Cmd+Shift+Down',
                'forward: true, granularity: document (macOS)',
                Icons.arrow_downward,
                _kPurple500,
              ),
              _buildKeyboardShortcutRow(
                'Cmd+Shift+Up',
                'forward: false, granularity: document (macOS)',
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
                'Creating and using GranularlyExtendSelectionEvent:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                '// Example 1: Word Selection Forward\n'
                'var wordEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,\n'
                '  forward: true,\n'
                '  granularity: TextGranularity.word,\n'
                ');\n'
                'print(wordEvent.isEnd);       // true\n'
                'print(wordEvent.forward);     // true\n'
                'print(wordEvent.granularity); // TextGranularity.word\n'
                'print(wordEvent.type);        // granularlyExtendSelection',
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Example 2: Line Selection Backward\n'
                'var lineEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: false,\n'
                '  forward: false,\n'
                '  granularity: TextGranularity.line,\n'
                ');\n'
                'print(lineEvent.isEnd);       // false\n'
                'print(lineEvent.forward);     // false\n'
                'print(lineEvent.granularity); // TextGranularity.line',
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Example 3: Using copyWith\n'
                'var modified = wordEvent.copyWith(\n'
                '  granularity: TextGranularity.paragraph,\n'
                ');\n'
                'print(modified.granularity); // TextGranularity.paragraph\n'
                'print(modified.forward);     // true (preserved)\n'
                'print(modified.isEnd);       // true (preserved)',
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Example 4: All Granularities\n'
                'var granularities = [\n'
                '  TextGranularity.character,\n'
                '  TextGranularity.word,\n'
                '  TextGranularity.line,\n'
                '  TextGranularity.paragraph,\n'
                '  TextGranularity.document,\n'
                '];\n'
                'for (var gran in granularities) {\n'
                '  var event = GranularlyExtendSelectionEvent(\n'
                '    isEnd: true,\n'
                '    forward: true,\n'
                '    granularity: gran,\n'
                '  );\n'
                '  print(event.granularity);\n'
                '}',
              ),
            ],
          ),
          borderColor: _kTeal600,
        ),
        _buildInfoCard(
          'Event Type Property',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Every SelectionEvent has a type property for identification:',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'var event = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,\n'
                '  forward: true,\n'
                '  granularity: TextGranularity.word,\n'
                ');\n\n'
                'print(event.type);\n'
                '// Output: SelectionEventType.granularlyExtendSelection',
              ),
              SizedBox(height: 12),
              _buildComparisonRow(
                'SelectionEventType.granularlyExtendSelection',
                'Identifies this event type in event handlers',
                _kTeal600,
              ),
            ],
          ),
          borderColor: _kIndigo500,
        ),
        _buildInfoCard(
          'Selection Event Class Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GranularlyExtendSelectionEvent is one of several selection '
                'event types extending the abstract SelectionEvent base class:',
                style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildComparisonRow(
                'SelectionEvent',
                'Abstract base class for all selection events',
                _kBlue600,
              ),
              _buildComparisonRow(
                'GranularlyExtendSelectionEvent',
                'Granular extension (word, line, paragraph)',
                _kTeal500,
              ),
              _buildComparisonRow(
                'DirectionallyExtendSelectionEvent',
                'Directional extension (arrow keys)',
                _kGreen500,
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
          borderColor: _kBlue500,
        ),

        // Footer
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _kTeal50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kTeal300),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kGreen500, size: 36),
              SizedBox(height: 10),
              Text(
                'GranularlyExtendSelectionEvent Deep Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text(
                'All sections covered: overview, isEnd, forward, '
                'granularity (character/word/line/paragraph), visual demo, and examples.',
                style: TextStyle(
                  fontSize: 12,
                  color: _kTeal700,
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
