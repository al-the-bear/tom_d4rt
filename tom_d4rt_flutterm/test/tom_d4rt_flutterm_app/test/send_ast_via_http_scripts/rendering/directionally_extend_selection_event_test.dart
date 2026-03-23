// ignore_for_file: avoid_print
// D4rt deep demo script: DirectionallyExtendSelectionEvent
//
// DirectionallyExtendSelectionEvent represents a text selection extension event
// in Flutter's rendering system. It allows programmatic extension of text selections
// in specific directions, commonly triggered by Shift+Arrow key combinations.
//
// This event enables precise control over text selection behavior by specifying:
//   - The direction to extend (forward, backward, nextLine, previousLine)
//   - The horizontal position hint (dx) for line navigation
//   - Whether to extend the end or start of the selection (isEnd)
//
// Sections demonstrated:
//   1. Overview of selection events
//   2. SelectionExtendDirection values
//   3. Forward/backward extension demos
//   4. Visual text selection simulation
//   5. Selection boundaries demo
//   6. Granularity context

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

var _kPrimary = Color(0xFF1565C0);
var _kPrimaryLight = Color(0xFF42A5F5);

var _kAccent = Color(0xFF00ACC1);
var _kAccentLight = Color(0xFF4DD0E1);

var _kSuccess = Color(0xFF43A047);
var _kSuccessLight = Color(0xFF66BB6A);

var _kWarning = Color(0xFFFF8F00);
var _kWarningLight = Color(0xFFFFB300);

var _kError = Color(0xFFE53935);

var _kPurple = Color(0xFF7B1FA2);
var _kPurpleLight = Color(0xFFAB47BC);

var _kTeal = Color(0xFF00897B);
var _kTealLight = Color(0xFF26A69A);

var _kGrey700 = Color(0xFF616161);
var _kGrey500 = Color(0xFF9E9E9E);

var _kSurface = Color(0xFFF8FAFC);
var _kCardBg = Color(0xFFFFFFFF);
var _kCodeBg = Color(0xFF263238);
var _kCodeText = Color(0xFF80CBC4);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary, _kPrimaryLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kPrimary.withAlpha(80),
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
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(Icons.text_fields, color: Colors.white, size: 36),
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(220),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, IconData icon, Color primary, Color secondary) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: primary.withAlpha(60),
          blurRadius: 12,
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
            color: Colors.white.withAlpha(35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String title, Widget content, {Color? accentColor}) {
  var color = accentColor ?? _kPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(8),
          blurRadius: 12,
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
            color: color.withAlpha(15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
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

Widget _buildPropertyItem(String name, String value, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kGrey700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
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

Widget _buildDirectionChip(String label, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(100)),
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
              label,
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

Widget _buildCodeSnippet(String code) {
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
        color: _kCodeText,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SELECTION VISUALIZATION HELPERS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildTextSelectionVisual(
  String text,
  int selectStart,
  int selectEnd,
  String directionLabel,
  Color selectionColor,
  bool extendForward,
) {
  var chars = text.split('');
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: selectionColor.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              extendForward ? Icons.arrow_forward : Icons.arrow_back,
              color: selectionColor,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              directionLabel,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: selectionColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < chars.length; i++)
                Container(
                  width: 24,
                  height: 32,
                  margin: EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                    color: (i >= selectStart && i < selectEnd)
                        ? selectionColor.withAlpha(200)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: (i >= selectStart && i < selectEnd)
                          ? selectionColor
                          : _kGrey500,
                      width: (i >= selectStart && i < selectEnd) ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      chars[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (i >= selectStart && i < selectEnd)
                            ? Colors.white
                            : _kGrey700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Selection: [$selectStart, $selectEnd)',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: _kGrey500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoundaryMarker(String label, Color color, bool isStart) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isStart ? Icons.first_page : Icons.last_page,
          color: color,
          size: 16,
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildGranularityItem(String granularity, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
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
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: _kGrey700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: OVERVIEW OF SELECTION EVENTS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'Overview of Selection Events',
        Icons.info_outline,
        _kPrimary,
        _kPrimaryLight,
      ),
      _buildInfoCard(
        'DirectionallyExtendSelectionEvent',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A specialized selection event that extends the current text selection '
              'in a specified direction. This event is central to keyboard-based '
              'text selection operations.',
              style: TextStyle(
                fontSize: 13,
                color: _kGrey700,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),
            _buildPropertyItem(
              'Event Type',
              'SelectionEventType.directionallyExtendSelection',
              Icons.category,
              _kPrimary,
            ),
            _buildPropertyItem(
              'Base Class',
              'SelectionEvent',
              Icons.account_tree,
              _kAccent,
            ),
            _buildPropertyItem(
              'Package',
              'flutter/rendering.dart',
              Icons.folder,
              _kPurple,
            ),
          ],
        ),
        accentColor: _kPrimary,
      ),
      _buildInfoCard(
        'Event Properties',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyItem(
              'direction',
              'SelectionExtendDirection',
              Icons.navigation,
              _kSuccess,
            ),
            _buildPropertyItem(
              'dx',
              'double - horizontal position hint',
              Icons.swap_horiz,
              _kWarning,
            ),
            _buildPropertyItem(
              'isEnd',
              'bool - extend end or start',
              Icons.adjust,
              _kTeal,
            ),
          ],
        ),
        accentColor: _kAccent,
      ),
      _buildInfoCard(
        'Common Use Cases',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              '// Shift+Right Arrow - extend forward\n'
              'DirectionallyExtendSelectionEvent(\n'
              '  dx: cursorX,\n'
              '  isEnd: true,\n'
              '  direction: SelectionExtendDirection.forward,\n'
              ')\n\n'
              '// Shift+Up Arrow - extend to previous line\n'
              'DirectionallyExtendSelectionEvent(\n'
              '  dx: cursorX,\n'
              '  isEnd: true,\n'
              '  direction: SelectionExtendDirection.previousLine,\n'
              ')',
            ),
          ],
        ),
        accentColor: _kPurple,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: SELECTION EXTEND DIRECTION VALUES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDirectionValuesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'SelectionExtendDirection Values',
        Icons.explore,
        _kSuccess,
        _kSuccessLight,
      ),
      _buildInfoCard(
        'Available Directions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                _buildDirectionChip(
                  'forward',
                  'Extend to the right',
                  Icons.arrow_forward,
                  _kSuccess,
                ),
                _buildDirectionChip(
                  'backward',
                  'Extend to the left',
                  Icons.arrow_back,
                  _kWarning,
                ),
                _buildDirectionChip(
                  'nextLine',
                  'Extend to next line',
                  Icons.arrow_downward,
                  _kAccent,
                ),
                _buildDirectionChip(
                  'previousLine',
                  'Extend to previous line',
                  Icons.arrow_upward,
                  _kPurple,
                ),
              ],
            ),
          ],
        ),
        accentColor: _kSuccess,
      ),
      _buildInfoCard(
        'Direction Enum Details',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              'enum SelectionExtendDirection {\n'
              '  forward,      // index: 0\n'
              '  backward,     // index: 1\n'
              '  nextLine,     // index: 2\n'
              '  previousLine, // index: 3\n'
              '}',
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSuccess.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: _kSuccess, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Line-based directions use dx to maintain horizontal cursor position',
                      style: TextStyle(
                        fontSize: 12,
                        color: _kGrey700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kTeal,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: FORWARD/BACKWARD EXTENSION DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildForwardBackwardSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'Forward/Backward Extension Demos',
        Icons.compare_arrows,
        _kWarning,
        _kWarningLight,
      ),
      _buildInfoCard(
        'Forward Extension (Shift+Right)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Extending selection forward adds characters to the right of the current selection.',
              style: TextStyle(fontSize: 13, color: _kGrey700),
            ),
            SizedBox(height: 14),
            _buildTextSelectionVisual(
              'Hello World',
              0,
              5,
              'Initial Selection',
              _kGrey500,
              true,
            ),
            _buildTextSelectionVisual(
              'Hello World',
              0,
              6,
              'After Forward Extend (1 char)',
              _kSuccess,
              true,
            ),
            _buildTextSelectionVisual(
              'Hello World',
              0,
              8,
              'After Forward Extend (3 chars)',
              _kSuccess,
              true,
            ),
          ],
        ),
        accentColor: _kSuccess,
      ),
      _buildInfoCard(
        'Backward Extension (Shift+Left)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Extending selection backward adds characters to the left of the current selection.',
              style: TextStyle(fontSize: 13, color: _kGrey700),
            ),
            SizedBox(height: 14),
            _buildTextSelectionVisual(
              'Hello World',
              6,
              11,
              'Initial Selection',
              _kGrey500,
              false,
            ),
            _buildTextSelectionVisual(
              'Hello World',
              5,
              11,
              'After Backward Extend (1 char)',
              _kWarning,
              false,
            ),
            _buildTextSelectionVisual(
              'Hello World',
              3,
              11,
              'After Backward Extend (3 chars)',
              _kWarning,
              false,
            ),
          ],
        ),
        accentColor: _kWarning,
      ),
      _buildInfoCard(
        'isEnd Property Effect',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _kSuccess.withAlpha(15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'isEnd: true',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _kSuccess,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Moves selection end point',
                          style: TextStyle(fontSize: 11, color: _kGrey700),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _kWarning.withAlpha(15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'isEnd: false',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _kWarning,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Moves selection start point',
                          style: TextStyle(fontSize: 11, color: _kGrey700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        accentColor: _kPrimary,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: VISUAL TEXT SELECTION SIMULATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualSimulationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'Visual Text Selection Simulation',
        Icons.text_snippet,
        _kAccent,
        _kAccentLight,
      ),
      _buildInfoCard(
        'Multi-Line Selection Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simulating Shift+Down Arrow selection across multiple lines:',
              style: TextStyle(fontSize: 13, color: _kGrey700),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextLine('Line 1: First', 0, 8, _kAccent),
                  _buildTextLine('Line 2: Second', 0, 14, _kAccent),
                  _buildTextLine('Line 3: Third', 0, 6, _kAccent),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text(
              'dx property maintains horizontal alignment across lines',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: _kGrey500,
              ),
            ),
          ],
        ),
        accentColor: _kAccent,
      ),
      _buildInfoCard(
        'Selection Rectangle Visualization',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kGrey500.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSelectionRect('Start', _kSuccess, 40),
                      SizedBox(width: 8),
                      _buildSelectionRect('Middle', _kAccent, 80),
                      SizedBox(width: 8),
                      _buildSelectionRect('End', _kWarning, 40),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBoundaryMarker('baseOffset', _kSuccess, true),
                      _buildBoundaryMarker('extentOffset', _kWarning, false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kPurple,
      ),
    ],
  );
}

Widget _buildTextLine(String text, int start, int end, Color highlight) {
  return Container(
    margin: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        for (var i = 0; i < text.length; i++)
          Container(
            width: 14,
            height: 20,
            margin: EdgeInsets.only(right: 1),
            decoration: BoxDecoration(
              color: (i >= start && i < end) ? highlight.withAlpha(180) : Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Text(
                text[i],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: (i >= start && i < end) ? Colors.white : _kGrey700,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildSelectionRect(String label, Color color, double width) {
  return Container(
    width: width,
    height: 32,
    decoration: BoxDecoration(
      color: color.withAlpha(120),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color, width: 2),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: SELECTION BOUNDARIES DEMO
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildBoundariesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'Selection Boundaries Demo',
        Icons.crop_square,
        _kPurple,
        _kPurpleLight,
      ),
      _buildInfoCard(
        'Boundary Behavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selection extension respects content boundaries and handles edge cases:',
              style: TextStyle(fontSize: 13, color: _kGrey700),
            ),
            SizedBox(height: 16),
            _buildBoundaryCase(
              'Start of Content',
              'Cannot extend backward past position 0',
              Icons.first_page,
              _kError,
            ),
            _buildBoundaryCase(
              'End of Content',
              'Cannot extend forward past last character',
              Icons.last_page,
              _kError,
            ),
            _buildBoundaryCase(
              'First Line',
              'previousLine returns SelectionResult.previous',
              Icons.vertical_align_top,
              _kWarning,
            ),
            _buildBoundaryCase(
              'Last Line',
              'nextLine returns SelectionResult.next',
              Icons.vertical_align_bottom,
              _kWarning,
            ),
          ],
        ),
        accentColor: _kPurple,
      ),
      _buildInfoCard(
        'SelectionResult Values',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              'enum SelectionResult {\n'
              '  next,     // Selection passed boundary\n'
              '  previous, // Selection at start\n'
              '  end,      // Selection ended here\n'
              '  pending,  // Waiting for more input\n'
              '  none,     // No selection change\n'
              '}',
            ),
          ],
        ),
        accentColor: _kTeal,
      ),
      _buildInfoCard(
        'Edge Detection Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildFlowStep('1', 'Receive extend event', _kPrimary),
                  _buildFlowArrow(),
                  _buildFlowStep('2', 'Check boundary conditions', _kAccent),
                  _buildFlowArrow(),
                  _buildFlowStep('3', 'Compute new selection', _kSuccess),
                  _buildFlowArrow(),
                  _buildFlowStep('4', 'Return SelectionResult', _kPurple),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kAccent,
      ),
    ],
  );
}

Widget _buildBoundaryCase(String title, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: _kGrey700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(String number, String label, Color color) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _kGrey700,
        ),
      ),
    ],
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Container(
      width: 2,
      height: 14,
      color: _kGrey500,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: GRANULARITY CONTEXT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildGranularitySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        'Granularity Context',
        Icons.tune,
        _kTeal,
        _kTealLight,
      ),
      _buildInfoCard(
        'TextGranularity Enum',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selection granularity determines the unit of selection movement:',
              style: TextStyle(fontSize: 13, color: _kGrey700),
            ),
            SizedBox(height: 14),
            _buildGranularityItem(
              'character',
              'Move by single characters (default arrow key behavior)',
              Icons.text_fields,
              _kPrimary,
            ),
            _buildGranularityItem(
              'word',
              'Move by whole words (Ctrl/Option + Arrow)',
              Icons.short_text,
              _kSuccess,
            ),
            _buildGranularityItem(
              'line',
              'Move by line (Home/End keys)',
              Icons.wrap_text,
              _kWarning,
            ),
            _buildGranularityItem(
              'document',
              'Move to document start/end (Ctrl+Home/End)',
              Icons.article,
              _kPurple,
            ),
          ],
        ),
        accentColor: _kTeal,
      ),
      _buildInfoCard(
        'Granularity and Direction Interaction',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeSnippet(
              '// Character granularity with forward direction\n'
              '// "Hello" -> "Hello " (1 char forward)\n\n'
              '// Word granularity with forward direction\n'
              '// "Hello World" -> selects "World" entirely\n\n'
              '// Line granularity with nextLine direction\n'
              '// Selects to end of current + next line',
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kTeal.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: _kTeal, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'DirectionallyExtendSelectionEvent works with text granularity '
                      'settings to determine actual movement distance',
                      style: TextStyle(
                        fontSize: 12,
                        color: _kGrey700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kAccent,
      ),
      _buildInfoCard(
        'Platform Keyboard Shortcuts',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShortcutRow('Shift + Right Arrow', 'forward + character', _kSuccess),
            _buildShortcutRow('Shift + Left Arrow', 'backward + character', _kWarning),
            _buildShortcutRow('Shift + Down Arrow', 'nextLine', _kAccent),
            _buildShortcutRow('Shift + Up Arrow', 'previousLine', _kPurple),
            _buildShortcutRow('Ctrl+Shift + Right', 'forward + word', _kSuccess),
            _buildShortcutRow('Ctrl+Shift + End', 'document end', _kError),
          ],
        ),
        accentColor: _kPrimary,
      ),
    ],
  );
}

Widget _buildShortcutRow(String shortcut, String effect, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withAlpha(80)),
          ),
          child: Text(
            shortcut,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(Icons.arrow_forward, color: _kGrey500, size: 16),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            effect,
            style: TextStyle(
              fontSize: 12,
              color: _kGrey700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMainHeader(
          'DirectionallyExtendSelectionEvent',
          'Text selection extension event for directional selection operations',
        ),
        SizedBox(height: 24),
        _buildOverviewSection(),
        SizedBox(height: 16),
        _buildDirectionValuesSection(),
        SizedBox(height: 16),
        _buildForwardBackwardSection(),
        SizedBox(height: 16),
        _buildVisualSimulationSection(),
        SizedBox(height: 16),
        _buildBoundariesSection(),
        SizedBox(height: 16),
        _buildGranularitySection(),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kSuccess.withAlpha(30), _kAccent.withAlpha(30)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kSuccess.withAlpha(60)),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _kSuccess, size: 40),
              SizedBox(height: 12),
              Text(
                'Deep Demo Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _kSuccess,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'DirectionallyExtendSelectionEvent demonstration finished',
                style: TextStyle(
                  fontSize: 13,
                  color: _kGrey700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
