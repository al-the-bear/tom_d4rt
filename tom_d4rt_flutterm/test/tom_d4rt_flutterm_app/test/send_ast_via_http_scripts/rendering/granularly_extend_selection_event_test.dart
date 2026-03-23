// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo script: GranularlyExtendSelectionEvent
// Granular text selection extension event for Flutter rendering system
//
// Sections:
//   1. Selection event overview
//   2. TextGranularity values (character, word, line, document)
//   3. Forward/backward directions
//   4. Visual selection demos
//   5. Granularity comparison grid
//
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE - Selection Event Theme
// ═══════════════════════════════════════════════════════════════════════════

var _kTeal50 = Color(0xFFE0F2F1);
var _kTeal300 = Color(0xFF4DB6AC);
var _kTeal500 = Color(0xFF009688);
var _kTeal600 = Color(0xFF00897B);
var _kTeal700 = Color(0xFF00796B);
var _kTeal800 = Color(0xFF00695C);
var _kTeal900 = Color(0xFF004D40);

var _kCyan400 = Color(0xFF26C6DA);
var _kCyan600 = Color(0xFF00ACC1);

var _kBlue400 = Color(0xFF42A5F5);
var _kBlue500 = Color(0xFF2196F3);
var _kBlue600 = Color(0xFF1E88E5);
var _kBlue700 = Color(0xFF1976D2);

var _kIndigo400 = Color(0xFF5C6BC0);
var _kIndigo500 = Color(0xFF3F51B5);
var _kIndigo600 = Color(0xFF3949AB);

var _kPurple400 = Color(0xFFAB47BC);
var _kPurple500 = Color(0xFF9C27B0);
var _kPurple600 = Color(0xFF8E24AA);

var _kDeepPurple400 = Color(0xFF7E57C2);
var _kDeepPurple500 = Color(0xFF673AB7);

var _kGreen400 = Color(0xFF66BB6A);
var _kGreen500 = Color(0xFF4CAF50);
var _kGreen600 = Color(0xFF43A047);
var _kGreen700 = Color(0xFF388E3C);

var _kAmber400 = Color(0xFFFFCA28);
var _kAmber500 = Color(0xFFFFC107);
var _kAmber600 = Color(0xFFFFB300);

var _kOrange400 = Color(0xFFFFA726);
var _kOrange500 = Color(0xFFFF9800);
var _kOrange600 = Color(0xFFFB8C00);

var _kRed500 = Color(0xFFF44336);

var _kGrey200 = Color(0xFFEEEEEE);
var _kGrey300 = Color(0xFFE0E0E0);
var _kGrey600 = Color(0xFF757575);
var _kGrey700 = Color(0xFF616161);
var _kGrey800 = Color(0xFF424242);

var _kSurface = Color(0xFFF0F4F8);
var _kCardBg = Color(0xFFFFFFFF);
var _kCodeBg = Color(0xFF1E1E1E);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Building Blocks
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
                  color: _kGrey800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: _kGrey600,
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

Widget _buildDirectionCard(String direction, String desc, IconData icon, Color color, bool isForward) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 8),
        Text(
          direction,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(fontSize: 11, color: _kGrey700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSelectionVisualization(
  String text,
  int selectionStart,
  int selectionEnd,
  String label,
  Color highlightColor,
  IconData directionIcon,
  String directionText,
  Color directionColor,
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
            color: _kGrey800,
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
                          : _kGrey300,
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
                            : _kGrey800,
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
            Icon(directionIcon, color: directionColor, size: 18),
            SizedBox(width: 6),
            Text(
              directionText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: directionColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildWordSelectionVisualization(
  String text,
  int selectedWordStart,
  int selectedWordEnd,
  String label,
  Color highlightColor,
  bool isForward,
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
            color: _kGrey800,
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
                          : _kGrey300,
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
                          : _kGrey800,
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

Widget _buildLineSelectionVisualization(
  List<String> lines,
  int selectedLineStart,
  int selectedLineEnd,
  String label,
  Color highlightColor,
  bool isForward,
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
            color: _kGrey800,
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
                        : _kGrey300,
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
                            : _kGrey200,
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
                                : _kGrey600,
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
                              : _kGrey800,
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

Widget _buildComparisonGridCell(String granularity, String unit, String shortcut, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          granularity,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Unit: $unit',
          style: TextStyle(fontSize: 11, color: _kGrey700),
        ),
        SizedBox(height: 2),
        Text(
          shortcut,
          style: TextStyle(
            fontSize: 10,
            color: _kGrey600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildGranularityDetailCard(
  String name,
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
                name,
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
                  color: _kGrey700,
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
                    color: _kGrey800,
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

  // Create event instances for demonstration
  var charForward = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.character,
  );

  var wordForward = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.word,
  );

  var lineForward = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.line,
  );

  var documentForward = GranularlyExtendSelectionEvent(
    isEnd: true,
    forward: true,
    granularity: TextGranularity.document,
  );

  var wordBackward = GranularlyExtendSelectionEvent(
    isEnd: false,
    forward: false,
    granularity: TextGranularity.word,
  );

  var paragraphBackward = GranularlyExtendSelectionEvent(
    isEnd: false,
    forward: false,
    granularity: TextGranularity.paragraph,
  );

  // Section 1: Selection Event Overview
  print('\n[SECTION 1] Selection Event Overview');
  print('-' * 60);
  print('GranularlyExtendSelectionEvent is a selection event class');
  print('from Flutter rendering library that extends text selection');
  print('using text granularity units (character, word, line, etc.).');
  print('It is typically triggered by platform keyboard shortcuts:');
  print('  - macOS: Option+Shift+Arrow (word), Cmd+Shift+Arrow (line)');
  print('  - Windows/Linux: Ctrl+Shift+Arrow (word)');
  print('Event type: ${charForward.type}');
  print('Class hierarchy: extends SelectionEvent');

  // Section 2: TextGranularity Values
  print('\n[SECTION 2] TextGranularity Values');
  print('-' * 60);
  print('TextGranularity enum defines the unit of selection extension:');
  for (var gran in TextGranularity.values) {
    print('  - ${gran.name} (index: ${gran.index})');
  }
  print('Total values: ${TextGranularity.values.length}');
  print('Character event: ${charForward.granularity}');
  print('Word event: ${wordForward.granularity}');
  print('Line event: ${lineForward.granularity}');
  print('Document event: ${documentForward.granularity}');
  print('Paragraph event: ${paragraphBackward.granularity}');

  // Section 3: Forward/Backward Directions
  print('\n[SECTION 3] Forward/Backward Directions');
  print('-' * 60);
  print('forward property determines extension direction:');
  print('  - forward=true: extends toward end of text');
  print('  - forward=false: extends toward start of text');
  print('isEnd property determines which boundary moves:');
  print('  - isEnd=true: moves the end boundary');
  print('  - isEnd=false: moves the start boundary');
  print('Word forward event: forward=${wordForward.forward}, isEnd=${wordForward.isEnd}');
  print('Word backward event: forward=${wordBackward.forward}, isEnd=${wordBackward.isEnd}');

  // Section 4: Visual Selection Demos
  print('\n[SECTION 4] Visual Selection Demos');
  print('-' * 60);
  print('Text: "The quick brown fox"');
  print('Character selection: |T| -> |Th| -> |The|');
  print('Word selection: |The| -> |The quick| -> |The quick brown|');
  print('Line selection: |Line 1| -> |Line 1 Line 2|');
  print('Document: Select all from cursor to document boundary');

  // Section 5: Granularity Comparison Grid
  print('\n[SECTION 5] Granularity Comparison Grid');
  print('-' * 60);
  print('┌────────────┬──────────────────┬────────────────────────┐');
  print('│ Granularity│ Unit             │ Platform Shortcut      │');
  print('├────────────┼──────────────────┼────────────────────────┤');
  print('│ character  │ Single character │ Shift+Arrow            │');
  print('│ word       │ Whole word       │ Ctrl/Opt+Shift+Arrow   │');
  print('│ line       │ Full line        │ Shift+Up/Down          │');
  print('│ paragraph  │ Paragraph block  │ Ctrl+Shift+Up/Down     │');
  print('│ document   │ Entire document  │ Cmd/Ctrl+Shift+End     │');
  print('└────────────┴──────────────────┴────────────────────────┘');

  // Additional event testing
  print('\n[ADDITIONAL] Creating Events for All Granularities');
  print('-' * 60);
  for (var gran in TextGranularity.values) {
    var testEvent = GranularlyExtendSelectionEvent(
      isEnd: true,
      forward: true,
      granularity: gran,
    );
    print('Created: ${testEvent.granularity} - forward=${testEvent.forward}');
  }

  print('\n${'=' * 70}');
  print('GranularlyExtendSelectionEvent deep demo completed');
  print('=' * 70);

  // Build the visual UI
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

        // ═══════════════════════════════════════════════════════════════════
        // SECTION 1: Selection Event Overview
        // ═══════════════════════════════════════════════════════════════════
        _buildSectionHeader(
          'Selection Event Overview',
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
                'GranularlyExtendSelectionEvent is a specialized selection event in '
                'Flutter\'s rendering system for extending text selection by semantic '
                'text units. Unlike DirectionallyExtendSelectionEvent which moves by '
                'visual position, this event operates on logical text boundaries.',
                style: TextStyle(fontSize: 13, color: _kGrey700, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildPropertyRow(
                'Event Type',
                'SelectionEventType.granularlyExtendSelection',
                Icons.label,
                _kTeal600,
              ),
              _buildPropertyRow(
                'Package Location',
                'package:flutter/rendering.dart',
                Icons.folder_open,
                _kCyan600,
              ),
              _buildPropertyRow(
                'Class Hierarchy',
                'extends SelectionEvent',
                Icons.account_tree,
                _kBlue500,
              ),
              _buildPropertyRow(
                'Primary Use Case',
                'Keyboard-driven selection extension',
                Icons.keyboard,
                _kGreen500,
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Constructor Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GranularlyExtendSelectionEvent requires three named parameters:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,                      // Which boundary to extend\n'
                '  forward: true,                    // Direction of extension\n'
                '  granularity: TextGranularity.word, // Unit of extension\n'
                ')',
              ),
              SizedBox(height: 14),
              _buildPropertyRow(
                'isEnd (bool)',
                'true = move end boundary, false = move start boundary',
                Icons.compare_arrows,
                _kPurple500,
              ),
              _buildPropertyRow(
                'forward (bool)',
                'true = toward text end, false = toward text start',
                Icons.swap_horiz,
                _kOrange500,
              ),
              _buildPropertyRow(
                'granularity (TextGranularity)',
                'character, word, line, paragraph, or document',
                Icons.format_size,
                _kIndigo500,
              ),
            ],
          ),
          borderColor: _kCyan600,
        ),

        // ═══════════════════════════════════════════════════════════════════
        // SECTION 2: TextGranularity Values
        // ═══════════════════════════════════════════════════════════════════
        _buildSectionHeader(
          'TextGranularity Values',
          Icons.format_size,
          _kIndigo600,
          _kIndigo400,
        ),
        _buildInfoCard(
          'TextGranularity Enum Overview',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextGranularity defines the semantic unit used for selection extension. '
                'Each value represents a different level of text grouping:',
                style: TextStyle(fontSize: 13, color: _kGrey700, height: 1.5),
              ),
              SizedBox(height: 16),
              Wrap(
                children: [
                  _buildGranularityBadge('character', 'Single char', _kBlue500, Icons.text_format),
                  _buildGranularityBadge('word', 'Whole word', _kGreen500, Icons.short_text),
                  _buildGranularityBadge('line', 'Full line', _kOrange500, Icons.notes),
                  _buildGranularityBadge('paragraph', 'Paragraph', _kPurple500, Icons.format_align_left),
                  _buildGranularityBadge('document', 'Entire doc', _kRed500, Icons.article),
                ],
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'TextGranularity.character',
          _buildGranularityDetailCard(
            'Character Granularity',
            'Extends selection by one character at a time. This is the most precise '
            'form of selection extension, similar to single arrow key navigation.',
            'Text: "Hello" | Select "H" | Extend -> "He" | Extend -> "Hel"',
            Icons.text_format,
            _kBlue500,
          ),
          borderColor: _kBlue500,
        ),
        _buildInfoCard(
          'TextGranularity.word',
          _buildGranularityDetailCard(
            'Word Granularity',
            'Extends selection by one word at a time. A word is defined as alphanumeric '
            'characters separated by whitespace or punctuation. Most common granularity.',
            'Text: "Hello World" | Select "Hello" | Extend -> "Hello World"',
            Icons.short_text,
            _kGreen500,
          ),
          borderColor: _kGreen500,
        ),
        _buildInfoCard(
          'TextGranularity.line',
          _buildGranularityDetailCard(
            'Line Granularity',
            'Extends selection to include the entire current line or the next/previous '
            'line boundary. Useful for selecting complete lines of code or text.',
            'Line 1: "First" | Line 2: "Second" | Extend from Line 1 -> Both lines',
            Icons.notes,
            _kOrange500,
          ),
          borderColor: _kOrange500,
        ),
        _buildInfoCard(
          'TextGranularity.document',
          _buildGranularityDetailCard(
            'Document Granularity',
            'Extends selection from current position to document boundary. Forward extends '
            'to document end, backward extends to document start. Maximum selection scope.',
            'Any position -> Extend forward with document -> Select to document end',
            Icons.article,
            _kRed500,
          ),
          borderColor: _kRed500,
        ),

        // ═══════════════════════════════════════════════════════════════════
        // SECTION 3: Forward/Backward Directions
        // ═══════════════════════════════════════════════════════════════════
        _buildSectionHeader(
          'Forward/Backward Directions',
          Icons.swap_horiz,
          _kGreen700,
          _kGreen500,
        ),
        _buildInfoCard(
          'Direction Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The forward and isEnd properties work together to control '
                'exactly how the selection is extended. Understanding their '
                'interaction is key to predicting selection behavior.',
                style: TextStyle(fontSize: 13, color: _kGrey700, height: 1.5),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDirectionCard(
                      'forward = true',
                      'Extends toward text end',
                      Icons.arrow_forward,
                      _kGreen500,
                      true,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _buildDirectionCard(
                      'forward = false',
                      'Extends toward text start',
                      Icons.arrow_back,
                      _kOrange500,
                      false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'isEnd Property Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'isEnd determines which selection boundary is moved during extension:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildDirectionCard(
                      'isEnd = true',
                      'Move END boundary',
                      Icons.last_page,
                      _kBlue500,
                      true,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _buildDirectionCard(
                      'isEnd = false',
                      'Move START boundary',
                      Icons.first_page,
                      _kPurple500,
                      false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              _buildCodeBlock(
                '// Forward extend end (typical right arrow)\n'
                'GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,    // move end marker\n'
                '  forward: true,  // toward text end\n'
                '  granularity: TextGranularity.word,\n'
                ');\n\n'
                '// Backward extend start (typical left arrow)\n'
                'GranularlyExtendSelectionEvent(\n'
                '  isEnd: false,   // move start marker\n'
                '  forward: false, // toward text start\n'
                '  granularity: TextGranularity.word,\n'
                ');',
              ),
            ],
          ),
          borderColor: _kIndigo500,
        ),
        _buildInfoCard(
          'Forward Selection Demo',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Extending selection forward by word granularity:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                0, 1, 'Initial: "The" selected', _kBlue400, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                0, 2, 'After forward extend: "The quick"', _kBlue500, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                0, 3, 'Continue forward: "The quick brown"', _kBlue600, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps',
                0, 5, 'Full forward: All words selected', _kBlue700, true,
              ),
            ],
          ),
          borderColor: _kGreen500,
        ),
        _buildInfoCard(
          'Backward Selection Demo',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Extending selection backward by word granularity:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'Start Middle End',
                2, 3, 'Initial: "End" selected', _kOrange400, false,
              ),
              _buildWordSelectionVisualization(
                'Start Middle End',
                1, 3, 'After backward extend: "Middle End"', _kOrange500, false,
              ),
              _buildWordSelectionVisualization(
                'Start Middle End',
                0, 3, 'Full backward: "Start Middle End"', _kOrange600, false,
              ),
            ],
          ),
          borderColor: _kOrange500,
        ),

        // ═══════════════════════════════════════════════════════════════════
        // SECTION 4: Visual Selection Demos
        // ═══════════════════════════════════════════════════════════════════
        _buildSectionHeader(
          'Visual Selection Demos',
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
                'Character granularity extends one character at a time:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildSelectionVisualization(
                'Flutter Demo',
                0, 3, 'Step 1: "Flu" selected', _kBlue400,
                Icons.arrow_forward, 'character forward', _kGreen500,
              ),
              _buildSelectionVisualization(
                'Flutter Demo',
                0, 4, 'Step 2: Extend -> "Flut"', _kBlue500,
                Icons.arrow_forward, 'character forward', _kGreen500,
              ),
              _buildSelectionVisualization(
                'Flutter Demo',
                0, 5, 'Step 3: Extend -> "Flutt"', _kBlue600,
                Icons.arrow_forward, 'character forward', _kGreen500,
              ),
              _buildSelectionVisualization(
                'Flutter Demo',
                0, 7, 'Step 4: Extend to word boundary "Flutter"', _kBlue700,
                Icons.arrow_forward, 'character forward', _kGreen500,
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
                'Word granularity extends one complete word at a time:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps over lazy dog',
                0, 1, 'Initial: "The" selected', _kGreen400, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps over lazy dog',
                0, 2, 'Word extend: "The quick"', _kGreen500, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps over lazy dog',
                0, 4, 'Two more: "The quick brown fox"', _kGreen600, true,
              ),
              _buildWordSelectionVisualization(
                'The quick brown fox jumps over lazy dog',
                0, 8, 'All words selected', _kGreen700, true,
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
                'Line granularity extends to include entire lines:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildLineSelectionVisualization(
                ['First line of code', 'Second line here', 'Third line follows', 'Fourth and final'],
                0, 1, 'Initial: Line 1 selected', _kOrange400, true,
              ),
              _buildLineSelectionVisualization(
                ['First line of code', 'Second line here', 'Third line follows', 'Fourth and final'],
                0, 2, 'Line extend: Lines 1-2', _kOrange500, true,
              ),
              _buildLineSelectionVisualization(
                ['First line of code', 'Second line here', 'Third line follows', 'Fourth and final'],
                0, 4, 'All lines selected', _kOrange600, true,
              ),
            ],
          ),
          borderColor: _kOrange500,
        ),
        _buildInfoCard(
          'Mixed Direction Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Combining forward and backward extension:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildWordSelectionVisualization(
                'One Two Three Four Five',
                2, 3, 'Initial: "Three" selected (middle)', _kPurple400, true,
              ),
              _buildWordSelectionVisualization(
                'One Two Three Four Five',
                2, 4, 'Forward extend: "Three Four"', _kGreen500, true,
              ),
              _buildWordSelectionVisualization(
                'One Two Three Four Five',
                1, 4, 'Backward extend: "Two Three Four"', _kOrange500, false,
              ),
              _buildWordSelectionVisualization(
                'One Two Three Four Five',
                0, 5, 'Both directions: All selected', _kPurple600, true,
              ),
            ],
          ),
          borderColor: _kPurple500,
        ),

        // ═══════════════════════════════════════════════════════════════════
        // SECTION 5: Granularity Comparison Grid
        // ═══════════════════════════════════════════════════════════════════
        _buildSectionHeader(
          'Granularity Comparison Grid',
          Icons.grid_on,
          _kDeepPurple500,
          _kDeepPurple400,
        ),
        _buildInfoCard(
          'Granularity Summary Table',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick reference for all TextGranularity values and their behavior:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.0,
                children: [
                  _buildComparisonGridCell('character', 'Single char', 'Shift+Arrow', _kBlue500),
                  _buildComparisonGridCell('word', 'Whole word', 'Ctrl+Shift+Arrow', _kGreen500),
                  _buildComparisonGridCell('line', 'Full line', 'Shift+Up/Down', _kOrange500),
                  _buildComparisonGridCell('document', 'Entire doc', 'Cmd+Shift+End', _kRed500),
                ],
              ),
            ],
          ),
        ),
        _buildInfoCard(
          'Platform Keyboard Shortcuts',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common keyboard shortcuts that trigger GranularlyExtendSelectionEvent:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 14),
              _buildPropertyRow(
                'Word Forward (macOS)',
                'Option + Shift + Right Arrow',
                Icons.arrow_forward,
                _kGreen500,
              ),
              _buildPropertyRow(
                'Word Forward (Windows/Linux)',
                'Ctrl + Shift + Right Arrow',
                Icons.arrow_forward,
                _kGreen600,
              ),
              _buildPropertyRow(
                'Word Backward (macOS)',
                'Option + Shift + Left Arrow',
                Icons.arrow_back,
                _kOrange500,
              ),
              _buildPropertyRow(
                'Word Backward (Windows/Linux)',
                'Ctrl + Shift + Left Arrow',
                Icons.arrow_back,
                _kOrange600,
              ),
              _buildPropertyRow(
                'Document End (macOS)',
                'Cmd + Shift + Down Arrow',
                Icons.arrow_downward,
                _kPurple500,
              ),
              _buildPropertyRow(
                'Document Start (macOS)',
                'Cmd + Shift + Up Arrow',
                Icons.arrow_upward,
                _kPurple600,
              ),
            ],
          ),
          borderColor: _kAmber500,
        ),
        _buildInfoCard(
          'Complete Event Creation Examples',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Creating events for all granularity types:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                '// Character forward\n'
                'var charEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true, forward: true,\n'
                '  granularity: TextGranularity.character,\n'
                ');\n'
                'print(charEvent.type); // granularlyExtendSelection\n\n'
                '// Word forward\n'
                'var wordEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true, forward: true,\n'
                '  granularity: TextGranularity.word,\n'
                ');\n\n'
                '// Line backward\n'
                'var lineEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: false, forward: false,\n'
                '  granularity: TextGranularity.line,\n'
                ');\n\n'
                '// Document forward\n'
                'var docEvent = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true, forward: true,\n'
                '  granularity: TextGranularity.document,\n'
                ');',
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
                'All GranularlyExtendSelectionEvent instances have the same type:',
                style: TextStyle(fontSize: 12, color: _kGrey700),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'var event = GranularlyExtendSelectionEvent(\n'
                '  isEnd: true,\n'
                '  forward: true,\n'
                '  granularity: TextGranularity.word,\n'
                ');\n\n'
                'print(event.type);\n'
                '// Output: SelectionEventType.granularlyExtendSelection\n\n'
                '// Can be used in event handlers\n'
                'switch (event.type) {\n'
                '  case SelectionEventType.granularlyExtendSelection:\n'
                '    handleGranularExtend(event);\n'
                '    break;\n'
                '  // other cases...\n'
                '}',
              ),
            ],
          ),
          borderColor: _kIndigo500,
        ),
        _buildInfoCard(
          'Selection Event Family',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GranularlyExtendSelectionEvent is part of the SelectionEvent hierarchy:',
                style: TextStyle(fontSize: 13, color: _kGrey700, height: 1.5),
              ),
              SizedBox(height: 16),
              _buildPropertyRow(
                'SelectionEvent',
                'Abstract base class for all selection events',
                Icons.account_tree,
                _kBlue600,
              ),
              _buildPropertyRow(
                'GranularlyExtendSelectionEvent',
                'Granular text unit extension',
                Icons.format_size,
                _kTeal500,
              ),
              _buildPropertyRow(
                'DirectionallyExtendSelectionEvent',
                'Arrow key directional extension',
                Icons.swap_horiz,
                _kGreen500,
              ),
              _buildPropertyRow(
                'SelectWordSelectionEvent',
                'Double-tap word selection',
                Icons.select_all,
                _kOrange500,
              ),
              _buildPropertyRow(
                'SelectAllSelectionEvent',
                'Select all (Ctrl+A)',
                Icons.select_all,
                _kAmber600,
              ),
              _buildPropertyRow(
                'ClearSelectionEvent',
                'Clear current selection',
                Icons.clear,
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
                'Covered: Selection event overview, TextGranularity values '
                '(character, word, line, document), forward/backward directions, '
                'visual selection demos, and granularity comparison grid.',
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
