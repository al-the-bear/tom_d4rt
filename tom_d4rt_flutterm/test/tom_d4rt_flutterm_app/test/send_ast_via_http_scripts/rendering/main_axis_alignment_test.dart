// D4rt Flutter demo: MainAxisAlignment - child distribution along main axis
// Visual comparison of all 6 values in Row/Column, practical nav bar layouts,
// and real-world spacing patterns for responsive design.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kEmerald500 = Color(0xFF10B981);
const _kPurple500 = Color(0xFFA855F7);
const _kEmerald700 = Color(0xFF047857);
const _kPurple700 = Color(0xFF7E22CE);
const _kEmerald50 = Color(0xFFECFDF5);
const _kPurple50 = Color(0xFFFAF5FF);
const _kGray100 = Color(0xFFF3F4F6);
const _kGray200 = Color(0xFFE5E7EB);
const _kGray700 = Color(0xFF374151);
const _kGray500 = Color(0xFF6B7280);
const _kWhite = Color(0xFFFFFFFF);

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kEmerald500, _kPurple500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number  $title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kWhite,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: _kWhite.withAlpha(204)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Info card
// ---------------------------------------------------------------------------
Widget _buildInfoCard(String title, String content, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      border: Border(left: BorderSide(color: accent, width: 4)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: accent.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _kGray700,
          ),
        ),
        SizedBox(height: 6),
        Text(content, style: TextStyle(fontSize: 13, color: _kGray500)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Code snippet
// ---------------------------------------------------------------------------
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _kPurple700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kWhite,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFF94A3B8),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Row alignment demo — shows a Row with specific MainAxisAlignment
// ---------------------------------------------------------------------------
Widget _buildRowAlignmentDemo(
  String alignmentName,
  MainAxisAlignment alignment,
  Color accent,
  String description,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                alignmentName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: accent,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 11, color: _kGray500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _kGray100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kGray200),
          ),
          child: Row(
            mainAxisAlignment: alignment,
            children: [
              _buildBoxItem('A', accent),
              _buildBoxItem('B', accent.withAlpha(180)),
              _buildBoxItem('C', accent.withAlpha(130)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Column alignment demo — shows a Column with specific MainAxisAlignment
// ---------------------------------------------------------------------------
Widget _buildColumnAlignmentDemo(
  String alignmentName,
  MainAxisAlignment alignment,
  Color accent,
) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withAlpha(60)),
      ),
      child: Column(
        mainAxisAlignment: alignment,
        children: [
          _buildSmallBox('1', accent),
          _buildSmallBox('2', accent.withAlpha(180)),
          _buildSmallBox('3', accent.withAlpha(130)),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Box item for Row demos
// ---------------------------------------------------------------------------
Widget _buildBoxItem(String label, Color color) {
  return Container(
    width: 40,
    height: 36,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kWhite,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Small box for Column demos
// ---------------------------------------------------------------------------
Widget _buildSmallBox(String label, Color color) {
  return Container(
    width: 36,
    height: 28,
    margin: EdgeInsets.symmetric(vertical: 1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _kWhite,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Nav bar item
// ---------------------------------------------------------------------------
Widget _buildNavItem(
  IconData icon,
  String label,
  bool isSelected,
  Color accent,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 22, color: isSelected ? accent : _kGray500),
      SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          color: isSelected ? accent : _kGray500,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Spacing formula card
// ---------------------------------------------------------------------------
Widget _buildSpacingFormula(
  String name,
  String formula,
  String example,
  Color accent,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withAlpha(12),
      border: Border.all(color: accent.withAlpha(60)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: accent,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Formula: $formula',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: _kGray700,
          ),
        ),
        SizedBox(height: 2),
        Text(example, style: TextStyle(fontSize: 12, color: _kGray500)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Numbered explanation step
// ---------------------------------------------------------------------------
Widget _buildExplanationStep(int step, String text, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kWhite,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: _kGray700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Entry point
// ===========================================================================
dynamic build(BuildContext context) {
  // --- Data exploration prints ---
  print('=== MainAxisAlignment Demo ===');
  print('MainAxisAlignment values:');
  for (final value in MainAxisAlignment.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Total values: ${MainAxisAlignment.values.length}');
  print('First: ${MainAxisAlignment.values.first}');
  print('Last: ${MainAxisAlignment.values.last}');

  // Spacing calculations for 3 items (40px each) in 300px container
  final containerWidth = 300.0;
  final itemWidth = 40.0;
  final itemCount = 3;
  final totalItemWidth = itemWidth * itemCount;
  final freeSpace = containerWidth - totalItemWidth;
  print('Container: ${containerWidth}px, Items: ${itemCount}x${itemWidth}px');
  print('Free space: ${freeSpace}px');
  print('spaceBetween gap: ${freeSpace / (itemCount - 1)}px');
  print(
    'spaceAround gap: ${freeSpace / itemCount}px (${freeSpace / (itemCount * 2)}px edges)',
  );
  print('spaceEvenly gap: ${freeSpace / (itemCount + 1)}px');

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      color: _kEmerald50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // Title banner
          // ================================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kEmerald700, _kPurple700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kPurple500.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.view_column, color: _kWhite, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'MainAxisAlignment',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _kWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Controls distribution of children along the main axis',
                  style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(204)),
                ),
                SizedBox(height: 4),
                Text(
                  'rendering library • Row • Column • Flex',
                  style: TextStyle(fontSize: 12, color: _kWhite.withAlpha(153)),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 1: The 6 Values
          // ================================================================
          _buildSectionHeader(
            '01',
            'The 6 Alignment Values',
            'Each value defines how free space is distributed among children',
          ),

          _buildInfoCard(
            'MainAxisAlignment enum',
            'Controls how children are positioned along the main axis when there '
                'is free space in the flex container. The main axis is horizontal in '
                'Row and vertical in Column.\n\n'
                '6 values: start, end, center, spaceBetween, spaceAround, spaceEvenly',
            _kEmerald500,
          ),

          _buildCodeSnippet(
            'MainAxisAlignment values',
            'enum MainAxisAlignment {\n'
                '  start,        // Pack at the start\n'
                '  end,          // Pack at the end\n'
                '  center,       // Pack at the center\n'
                '  spaceBetween, // Even gaps, no edge space\n'
                '  spaceAround,  // Even gaps, half-gap edges\n'
                '  spaceEvenly,  // Equal gaps everywhere\n'
                '}\n',
          ),

          // ================================================================
          // Section 2: Row Demonstrations
          // ================================================================
          _buildSectionHeader(
            '02',
            'Row Alignment Demos',
            'All 6 values applied to a horizontal Row with 3 children',
          ),

          _buildRowAlignmentDemo(
            'start',
            MainAxisAlignment.start,
            _kEmerald500,
            'Children packed at the leading edge (left in LTR)',
          ),
          _buildRowAlignmentDemo(
            'end',
            MainAxisAlignment.end,
            _kPurple500,
            'Children packed at the trailing edge (right in LTR)',
          ),
          _buildRowAlignmentDemo(
            'center',
            MainAxisAlignment.center,
            _kEmerald500,
            'Children grouped at the center of the axis',
          ),
          _buildRowAlignmentDemo(
            'spaceBetween',
            MainAxisAlignment.spaceBetween,
            _kPurple500,
            'First and last children at edges, even gaps between',
          ),
          _buildRowAlignmentDemo(
            'spaceAround',
            MainAxisAlignment.spaceAround,
            _kEmerald500,
            'Equal space around each child, half-space at edges',
          ),
          _buildRowAlignmentDemo(
            'spaceEvenly',
            MainAxisAlignment.spaceEvenly,
            _kPurple500,
            'Equal space between and at edges',
          ),

          // ================================================================
          // Section 3: Column Demonstrations
          // ================================================================
          _buildSectionHeader(
            '03',
            'Column Alignment Demos',
            'Same values but vertical — showing 3 columns side by side',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                // First row of 3 column demos
                Row(
                  children: [
                    _buildColumnAlignmentDemo(
                      'start',
                      MainAxisAlignment.start,
                      _kEmerald500,
                    ),
                    _buildColumnAlignmentDemo(
                      'end',
                      MainAxisAlignment.end,
                      _kPurple500,
                    ),
                    _buildColumnAlignmentDemo(
                      'center',
                      MainAxisAlignment.center,
                      _kEmerald500,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'start',
                      style: TextStyle(fontSize: 10, color: _kEmerald700),
                    ),
                    SizedBox(width: 60),
                    Text(
                      'end',
                      style: TextStyle(fontSize: 10, color: _kPurple700),
                    ),
                    SizedBox(width: 55),
                    Text(
                      'center',
                      style: TextStyle(fontSize: 10, color: _kEmerald700),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Second row of 3 column demos
                Row(
                  children: [
                    _buildColumnAlignmentDemo(
                      'spaceBetween',
                      MainAxisAlignment.spaceBetween,
                      _kPurple500,
                    ),
                    _buildColumnAlignmentDemo(
                      'spaceAround',
                      MainAxisAlignment.spaceAround,
                      _kEmerald500,
                    ),
                    _buildColumnAlignmentDemo(
                      'spaceEvenly',
                      MainAxisAlignment.spaceEvenly,
                      _kPurple500,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'between',
                      style: TextStyle(fontSize: 10, color: _kPurple700),
                    ),
                    SizedBox(width: 46),
                    Text(
                      'around',
                      style: TextStyle(fontSize: 10, color: _kEmerald700),
                    ),
                    SizedBox(width: 46),
                    Text(
                      'evenly',
                      style: TextStyle(fontSize: 10, color: _kPurple700),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 4: Spacing Formulas
          // ================================================================
          _buildSectionHeader(
            '04',
            'Spacing Formulas',
            'How free space is calculated and distributed for each mode',
          ),

          _buildInfoCard(
            'Free Space Calculation',
            'freeSpace = containerSize - sum(childSizes)\n\n'
                'For our demo: $containerWidth - ($itemCount × $itemWidth) = ${freeSpace}px free\n'
                'This free space is distributed differently by each alignment value.',
            _kEmerald500,
          ),

          _buildSpacingFormula(
            'start / end / center',
            'All free space on one side (or split evenly for center)',
            'Free: ${freeSpace}px → gap: 0px between items',
            _kEmerald500,
          ),
          _buildSpacingFormula(
            'spaceBetween',
            'gap = freeSpace / (childCount - 1)',
            '${freeSpace} / ${itemCount - 1} = ${(freeSpace / (itemCount - 1)).toStringAsFixed(0)}px between items',
            _kPurple500,
          ),
          _buildSpacingFormula(
            'spaceAround',
            'gap = freeSpace / childCount; edges = gap/2',
            '${freeSpace} / $itemCount = ${(freeSpace / itemCount).toStringAsFixed(0)}px per child; edges = ${(freeSpace / (itemCount * 2)).toStringAsFixed(0)}px',
            _kEmerald500,
          ),
          _buildSpacingFormula(
            'spaceEvenly',
            'gap = freeSpace / (childCount + 1)',
            '${freeSpace} / ${itemCount + 1} = ${(freeSpace / (itemCount + 1)).toStringAsFixed(0)}px everywhere',
            _kPurple500,
          ),

          // ================================================================
          // Section 5: Navigation Bar Examples
          // ================================================================
          _buildSectionHeader(
            '05',
            'Navigation Bar Patterns',
            'Practical bottom navigation using different alignments',
          ),

          // spaceBetween nav bar
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kEmerald500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bottom Nav — spaceBetween',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kEmerald700,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _kGray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(Icons.home, 'Home', true, _kEmerald500),
                      _buildNavItem(
                        Icons.search,
                        'Search',
                        false,
                        _kEmerald500,
                      ),
                      _buildNavItem(
                        Icons.add_box,
                        'Create',
                        false,
                        _kEmerald500,
                      ),
                      _buildNavItem(
                        Icons.notifications,
                        'Alerts',
                        false,
                        _kEmerald500,
                      ),
                      _buildNavItem(
                        Icons.person,
                        'Profile',
                        false,
                        _kEmerald500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // spaceEvenly nav bar
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPurple500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tab Bar — spaceEvenly',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kPurple700,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _kGray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(Icons.photo, 'Photos', true, _kPurple500),
                      _buildNavItem(
                        Icons.video_library,
                        'Videos',
                        false,
                        _kPurple500,
                      ),
                      _buildNavItem(
                        Icons.music_note,
                        'Music',
                        false,
                        _kPurple500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // spaceAround action bar
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kEmerald500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Action Bar — spaceAround',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kEmerald700,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _kGray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.share, 'Share', false, _kEmerald500),
                      _buildNavItem(
                        Icons.bookmark,
                        'Save',
                        false,
                        _kEmerald500,
                      ),
                      _buildNavItem(
                        Icons.comment,
                        'Comment',
                        false,
                        _kEmerald500,
                      ),
                      _buildNavItem(Icons.favorite, 'Like', true, _kEmerald500),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 6: Header/Footer Layout Patterns
          // ================================================================
          _buildSectionHeader(
            '06',
            'Header & Footer Patterns',
            'Using alignment in app bar and toolbar layouts',
          ),

          // start alignment — left-aligned toolbar
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPurple500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Bar — start (leading icon + title)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kPurple700,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _kPurple500,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_back, color: _kWhite, size: 20),
                      SizedBox(width: 16),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _kWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // end alignment — right-aligned actions
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kEmerald500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Button Row — end (action buttons right-aligned)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kEmerald700,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _kGray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _kGray200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 13, color: _kGray700),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _kEmerald500,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // spaceBetween — title left, actions right
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPurple500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toolbar — spaceBetween (title + actions)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kPurple700,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _kPurple700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My App',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _kWhite,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, color: _kWhite, size: 20),
                          SizedBox(width: 16),
                          Icon(Icons.more_vert, color: _kWhite, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 7: How Flex Layout Works
          // ================================================================
          _buildSectionHeader(
            '07',
            'How Flex Layout Works',
            'The algorithm inside Row/Column that applies MainAxisAlignment',
          ),

          _buildExplanationStep(
            1,
            'Measure all non-flex children to determine their main axis size.',
            _kEmerald500,
          ),
          _buildExplanationStep(
            2,
            'Distribute remaining space to Flexible/Expanded children by flex factor.',
            _kPurple500,
          ),
          _buildExplanationStep(
            3,
            'Calculate total free space = container size - sum(child sizes).',
            _kEmerald500,
          ),
          _buildExplanationStep(
            4,
            'Apply MainAxisAlignment to distribute free space as leading space '
            'and inter-item gaps.',
            _kPurple500,
          ),
          _buildExplanationStep(
            5,
            'Position each child at accumulated offset along the main axis.',
            _kEmerald500,
          ),

          _buildCodeSnippet(
            'Free space distribution in RenderFlex',
            '// Simplified from RenderFlex.performLayout\n'
                'switch (mainAxisAlignment) {\n'
                '  case MainAxisAlignment.start:\n'
                '    leadingSpace = 0; gap = 0;\n'
                '  case MainAxisAlignment.end:\n'
                '    leadingSpace = freeSpace; gap = 0;\n'
                '  case MainAxisAlignment.center:\n'
                '    leadingSpace = freeSpace / 2; gap = 0;\n'
                '  case MainAxisAlignment.spaceBetween:\n'
                '    leadingSpace = 0;\n'
                '    gap = freeSpace / (childCount - 1);\n'
                '  case MainAxisAlignment.spaceAround:\n'
                '    gap = freeSpace / childCount;\n'
                '    leadingSpace = gap / 2;\n'
                '  case MainAxisAlignment.spaceEvenly:\n'
                '    gap = freeSpace / (childCount + 1);\n'
                '    leadingSpace = gap;\n'
                '}\n',
          ),

          // ================================================================
          // Section 8: Quick Reference
          // ================================================================
          _buildSectionHeader(
            '08',
            'Quick Reference',
            'When to use each alignment value',
          ),

          ...[
            [
              'start',
              'Form labels, left-aligned text, icon + title headers',
              _kEmerald500,
            ],
            [
              'end',
              'Action buttons, right-aligned controls, trailing icons',
              _kPurple500,
            ],
            [
              'center',
              'Centered content, loading indicators, empty states',
              _kEmerald500,
            ],
            [
              'spaceBetween',
              'Nav bars, toolbars with title + actions, key-value rows',
              _kPurple500,
            ],
            [
              'spaceAround',
              'Card grids, icon toolbars, content with breathing room',
              _kEmerald500,
            ],
            [
              'spaceEvenly',
              'Tab bars, evenly distributed buttons, dashboard grids',
              _kPurple500,
            ],
          ].map(
            (item) => _buildInfoCard(
              item[0] as String,
              item[1] as String,
              item[2] as Color,
            ),
          ),

          // Footer
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kPurple50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPurple500.withAlpha(40)),
            ),
            child: Text(
              'MainAxisAlignment is one of the most frequently used enums in Flutter. '
              'Understanding the 6 values — and the spacing formulas behind them — '
              'is essential for every layout. Use spaceBetween for navigation, '
              'spaceEvenly for tabs, and center for focal content.',
              style: TextStyle(
                fontSize: 12,
                color: _kGray700,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    ),
  );
}
