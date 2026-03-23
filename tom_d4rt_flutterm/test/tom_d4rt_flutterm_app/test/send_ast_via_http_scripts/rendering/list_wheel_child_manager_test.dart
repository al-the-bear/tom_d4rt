// ignore_for_file: avoid_print
// D4rt Flutter demo: ListWheelChildManager - manages child lifecycle
// in ListWheelScrollView. Demonstrates 3D wheel effects, lazy creation,
// child reuse, and practical picker/selector implementations.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kAmber500 = Color(0xFFF59E0B);
const _kIndigo500 = Color(0xFF6366F1);
const _kAmber100 = Color(0xFFFEF3C7);
const _kIndigo100 = Color(0xFFE0E7FF);
const _kAmber700 = Color(0xFFB45309);
const _kIndigo700 = Color(0xFF4338CA);
const _kAmber50 = Color(0xFFFFFBEB);
const _kIndigo50 = Color(0xFFEEF2FF);
const _kGray100 = Color(0xFFF3F4F6);
const _kGray700 = Color(0xFF374151);
const _kGray500 = Color(0xFF6B7280);
const _kGray300 = Color(0xFFD1D5DB);
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
        colors: [_kAmber500, _kIndigo500],
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
            color: _kIndigo700,
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
// Wheel item visual — simulates a curved list item
// ---------------------------------------------------------------------------
Widget _buildWheelItem(
  String label,
  int index,
  int selectedIndex,
  double itemExtent,
) {
  final isSelected = index == selectedIndex;
  final distance = (index - selectedIndex).abs();
  final opacity = distance == 0 ? 255 : (distance == 1 ? 180 : 100);
  final scale = distance == 0 ? 1.0 : (distance == 1 ? 0.85 : 0.7);

  return Container(
    width: double.infinity,
    height: itemExtent,
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: isSelected
          ? _kAmber500.withAlpha(40)
          : _kGray100.withAlpha(opacity),
      border: isSelected
          ? Border.all(color: _kAmber500, width: 2)
          : Border.all(color: _kGray300.withAlpha(opacity), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        if (isSelected) Icon(Icons.arrow_right, color: _kAmber500, size: 20),
        Expanded(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? _kAmber700 : _kGray700.withAlpha(opacity),
              ),
            ),
          ),
        ),
        Text(
          'idx:$index',
          style: TextStyle(fontSize: 10, color: _kGray500.withAlpha(opacity)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Lifecycle step visual
// ---------------------------------------------------------------------------
Widget _buildLifecycleStep(
  String phase,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      border: Border.all(color: color.withAlpha(60), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                phase,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Responsibility card
// ---------------------------------------------------------------------------
Widget _buildResponsibilityCard(
  String title,
  String detail,
  IconData icon,
  Color bg,
  Color accent,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(60)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 22),
        SizedBox(width: 12),
        Expanded(
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
              SizedBox(height: 4),
              Text(
                detail,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Picker column visual
// ---------------------------------------------------------------------------
Widget _buildPickerColumn(
  String label,
  List<String> items,
  int selected,
  Color accent,
) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withAlpha(60)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          SizedBox(height: 6),
          ...items.asMap().entries.map((e) {
            final isSel = e.key == selected;
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 1),
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: isSel ? accent.withAlpha(25) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: isSel
                    ? Border.all(color: accent.withAlpha(120), width: 1)
                    : null,
              ),
              child: Center(
                child: Text(
                  e.value,
                  style: TextStyle(
                    fontSize: isSel ? 14 : 12,
                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w400,
                    color: isSel ? accent : _kGray500,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
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
  print('=== ListWheelChildManager Demo ===');
  print('ListWheelChildManager is an abstract class / mixin.');
  print('It manages child creation and destruction in ListWheelScrollView.');
  print('Key concept: lazy child building for visible items only.');
  print('ListWheelScrollView creates a 3D cylindrical wheel effect.');

  final hours = List.generate(24, (i) => i.toString().padLeft(2, '0'));
  final minutes = List.generate(60, (i) => i.toString().padLeft(2, '0'));
  print('Hours list: ${hours.length} items');
  print('Minutes list: ${minutes.length} items');
  print('First hour: ${hours.first}, Last hour: ${hours.last}');

  final selectedHour = 14;
  final selectedMinute = 30;
  print('Selected time: ${hours[selectedHour]}:${minutes[selectedMinute]}');

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  print('Months: ${months.length}');

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      color: _kAmber50,
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
                colors: [_kAmber700, _kIndigo700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kIndigo500.withAlpha(60),
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
                    Icon(Icons.view_carousel, color: _kWhite, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'ListWheelChildManager',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Managing child lifecycle in 3D wheel scroll views',
                  style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(204)),
                ),
                SizedBox(height: 4),
                Text(
                  'rendering library • ListWheelScrollView • ListWheelViewport',
                  style: TextStyle(fontSize: 12, color: _kWhite.withAlpha(153)),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 1: What is ListWheelChildManager?
          // ================================================================
          _buildSectionHeader(
            '01',
            'What is ListWheelChildManager?',
            'Abstract interface for managing wheel children lifecycle',
          ),

          _buildInfoCard(
            'Definition',
            'ListWheelChildManager is a mixin/abstract class that defines the '
                'protocol for creating and removing children in a ListWheelViewport. '
                'It enables lazy instantiation — only visible items on the wheel are '
                'built, dramatically reducing memory usage for large datasets.',
            _kAmber500,
          ),

          _buildInfoCard(
            'Key Methods',
            '• childCount — total number of items available\n'
                '• createChild(index, after:) — build a child at given index\n'
                '• removeChild(child) — dispose of a child no longer visible\n\n'
                'The viewport calls these methods as the wheel scrolls, creating '
                'children entering the visible area and removing ones leaving it.',
            _kIndigo500,
          ),

          _buildCodeSnippet(
            'ListWheelChildManager interface',
            'abstract mixin class ListWheelChildManager {\n'
                '  /// Number of children available.\n'
                '  int get childCount;\n'
                '\n'
                '  /// Creates a child for the given index.\n'
                '  /// [after] is the child to insert after.\n'
                '  void createChild(\n'
                '    int index, {\n'
                '    required RenderBox? after,\n'
                '  });\n'
                '\n'
                '  /// Removes the specified child.\n'
                '  void removeChild(RenderBox child);\n'
                '}\n',
          ),

          // ================================================================
          // Section 2: 3D Wheel Effect
          // ================================================================
          _buildSectionHeader(
            '02',
            'The 3D Wheel Effect',
            'How ListWheelScrollView creates a cylindrical scroll experience',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAmber500.withAlpha(60)),
            ),
            child: Column(
              children: [
                Text(
                  '🎡 Cylindrical Wheel Viewport',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kAmber700,
                  ),
                ),
                SizedBox(height: 12),
                // Simulated wheel view
                ...List.generate(7, (i) {
                  final centerIdx = 3;
                  final itemLabel = months[(i + 1) % months.length];
                  return _buildWheelItem(itemLabel, i, centerIdx, 36);
                }),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kAmber50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Items scale down and fade as they move away from the center. '
                    'The wheel maps a flat scroll offset to positions on a cylinder, '
                    'giving a 3D perspective effect. Only visible items exist in memory.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _kGray700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          _buildCodeSnippet(
            'ListWheelScrollView usage',
            'ListWheelScrollView(\n'
                '  itemExtent: 42,\n'
                '  diameterRatio: 1.5,\n'
                '  perspective: 0.003,\n'
                '  physics: FixedExtentScrollPhysics(),\n'
                '  children: List.generate(100, (i) =>\n'
                '    Center(child: Text("Item \$i")),\n'
                '  ),\n'
                ')\n',
          ),

          // ================================================================
          // Section 3: Child Manager Responsibilities
          // ================================================================
          _buildSectionHeader(
            '03',
            'Manager Responsibilities',
            'What the child manager handles during wheel scrolling',
          ),

          _buildResponsibilityCard(
            'Lazy Creation',
            'Only builds children visible on the wheel surface. For a list of '
                '10,000 items, typically only 7-15 are in memory at once.',
            Icons.add_circle_outline,
            _kAmber100,
            _kAmber700,
          ),
          _buildResponsibilityCard(
            'Child Recycling',
            'When a child scrolls off the visible area, it is removed. The slot '
                'is freed for a new child entering from the other side.',
            Icons.recycling,
            _kIndigo100,
            _kIndigo700,
          ),
          _buildResponsibilityCard(
            'Index Management',
            'Maps absolute item indices to child widgets. Handles the translation '
                'between scroll offset and which items need to exist.',
            Icons.format_list_numbered,
            _kAmber100,
            _kAmber700,
          ),
          _buildResponsibilityCard(
            'Builder Delegation',
            'In ListWheelScrollView.builder mode, the manager calls the builder '
                'callback to create items on demand, enabling infinite lists.',
            Icons.build_circle,
            _kIndigo100,
            _kIndigo700,
          ),

          // ================================================================
          // Section 4: Child Lifecycle
          // ================================================================
          _buildSectionHeader(
            '04',
            'Child Lifecycle',
            'Creation → display → removal cycle as the wheel scrolls',
          ),

          _buildLifecycleStep(
            'Request',
            'Viewport calculates which indices are visible on the wheel surface '
                'based on scroll offset and item extent.',
            Icons.calculate,
            _kAmber500,
          ),
          _buildLifecycleStep(
            'Create',
            'Manager.createChild(index) is called. Builder constructs the widget, '
                'which gets inflated into the render tree.',
            Icons.add_box,
            _kIndigo500,
          ),
          _buildLifecycleStep(
            'Layout',
            'Child receives tight constraints from the wheel viewport. Parent data '
                'stores the offset from the wheel center.',
            Icons.straighten,
            _kAmber500,
          ),
          _buildLifecycleStep(
            'Paint',
            'Child is painted with cylindrical transform — rotation, perspective, '
                'and opacity based on distance from center.',
            Icons.brush,
            _kIndigo500,
          ),
          _buildLifecycleStep(
            'Remove',
            'When child scrolls beyond the visible range, Manager.removeChild() '
                'is called to dispose of it and free memory.',
            Icons.delete_outline,
            _kAmber500,
          ),

          _buildCodeSnippet(
            'Child lifecycle in viewport',
            '// During layout, viewport determines visible range\n'
                'final firstVisible = scrollOffsetToIndex(offset);\n'
                'final lastVisible = firstVisible + maxVisibleCount;\n'
                '\n'
                '// Create children that need to exist\n'
                'for (var i = firstVisible; i <= lastVisible; i++) {\n'
                '  if (!hasChild(i)) {\n'
                '    manager.createChild(i, after: lastChild);\n'
                '  }\n'
                '}\n'
                '\n'
                '// Remove children outside visible range\n'
                'removeChildrenOutsideRange(\n'
                '    firstVisible, lastVisible);\n',
          ),

          // ================================================================
          // Section 5: Time Picker Example
          // ================================================================
          _buildSectionHeader(
            '05',
            'Time Picker Example',
            'Classic use case: hour/minute selectors using wheel views',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kIndigo500.withAlpha(60)),
            ),
            child: Column(
              children: [
                Text(
                  'Time Selector: ${hours[selectedHour]}:${minutes[selectedMinute]}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kIndigo700,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _buildPickerColumn(
                      'Hour',
                      hours.sublist(12, 17),
                      2,
                      _kAmber500,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _kGray700,
                        ),
                      ),
                    ),
                    _buildPickerColumn(
                      'Minute',
                      minutes.sublist(28, 33),
                      2,
                      _kIndigo500,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kIndigo50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Each column is a ListWheelScrollView with its own child manager. '
                    'Hours: 24 total items, ~5 visible. Minutes: 60 total, ~5 visible. '
                    'Memory: only 10 widgets instead of 84.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _kGray700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 6: Month Picker Example
          // ================================================================
          _buildSectionHeader(
            '06',
            'Month Picker Example',
            'Scrollable month selector with wheel physics',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAmber500.withAlpha(60)),
            ),
            child: Column(
              children: [
                Text(
                  'Select Month',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kAmber700,
                  ),
                ),
                SizedBox(height: 10),
                ...months.asMap().entries.map((e) {
                  final isSelected = e.key == 2; // March
                  return _buildWheelItem(
                    e.value,
                    e.key,
                    2,
                    isSelected ? 40.0 : 32.0,
                  );
                }),
                SizedBox(height: 10),
                Text(
                  'Selected: ${months[2]}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kAmber700,
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 7: Builder vs Children Mode
          // ================================================================
          _buildSectionHeader(
            '07',
            'Builder vs Children Mode',
            'Two approaches to providing items to the wheel',
          ),

          _buildInfoCard(
            'ListWheelScrollView (children mode)',
            'All children are provided upfront as a List<Widget>. Manager wraps '
                'them but they are all inflated at build time.\n\n'
                'Best for: Small, fixed lists (< 50 items)\n'
                'Memory: All children in memory\n'
                'Child manager role: Simple index-to-child mapping',
            _kAmber500,
          ),

          _buildInfoCard(
            'ListWheelScrollView.builder (builder mode)',
            'Children are created on-demand via an IndexedWidgetBuilder callback. '
                'Manager creates/destroys as the wheel scrolls.\n\n'
                'Best for: Large or infinite lists\n'
                'Memory: Only visible children in memory\n'
                'Child manager role: Full lazy lifecycle management',
            _kIndigo500,
          ),

          _buildCodeSnippet(
            'Builder mode example',
            'ListWheelScrollView.builder(\n'
                '  itemExtent: 50,\n'
                '  childCount: 10000,\n'
                '  diameterRatio: 2.0,\n'
                '  physics: FixedExtentScrollPhysics(),\n'
                '  itemBuilder: (context, index) {\n'
                '    // Called lazily by child manager\n'
                '    return Container(\n'
                '      alignment: Alignment.center,\n'
                '      child: Text(\n'
                '        "Item \$index",\n'
                '        style: TextStyle(fontSize: 18),\n'
                '      ),\n'
                '    );\n'
                '  },\n'
                ')\n',
          ),

          // ================================================================
          // Section 8: Configuration Parameters
          // ================================================================
          _buildSectionHeader(
            '08',
            'Wheel Configuration',
            'Parameters that affect what the child manager needs to handle',
          ),

          ...[
            ['itemExtent', '42.0', 'Height of each item on the wheel'],
            ['diameterRatio', '1.5', 'Cylinder diameter / viewport height'],
            ['perspective', '0.003', 'Perspective depth effect strength'],
            ['squeeze', '1.0', 'Density of items on the wheel'],
            ['offAxisFraction', '0.0', 'Horizontal offset for 3D tilt'],
            ['overAndUnderCenterOpacity', '0.5', 'Fade for off-center items'],
          ].map(
            (params) => Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 3),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _kWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _kGray100),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      params[0],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                        color: _kIndigo700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      params[1],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _kAmber700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      params[2],
                      style: TextStyle(fontSize: 12, color: _kGray500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          _buildExplanationStep(
            1,
            'Higher diameterRatio → flatter wheel → more visible items → manager creates more children.',
            _kAmber500,
          ),
          _buildExplanationStep(
            2,
            'Smaller itemExtent → more items fit in viewport → manager keeps more children alive.',
            _kIndigo500,
          ),
          _buildExplanationStep(
            3,
            'squeeze > 1.0 packs items tighter, increasing visible count without changing itemExtent.',
            _kAmber500,
          ),

          // Footer
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kIndigo50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kIndigo500.withAlpha(40)),
            ),
            child: Text(
              'ListWheelChildManager is the bridge between the data source and '
              'the 3D wheel viewport. By lazily creating and disposing children, '
              'it makes ListWheelScrollView practical for any dataset size — '
              'from 12-month pickers to infinite scroll feeds.',
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
