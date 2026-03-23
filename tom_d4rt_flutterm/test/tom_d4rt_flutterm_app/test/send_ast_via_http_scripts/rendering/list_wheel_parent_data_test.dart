// ignore_for_file: avoid_print
// D4rt Flutter demo: ListWheelParentData - layout metadata for wheel children
// Explores how ListWheelScrollView stores offset-from-center and layout info
// in parent data, and how the viewport uses it for cylindrical transforms.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kSky500 = Color(0xFF0EA5E9);
const _kRed500 = Color(0xFFEF4444);
const _kSky700 = Color(0xFF0369A1);
const _kRed700 = Color(0xFFB91C1C);
const _kSky50 = Color(0xFFF0F9FF);
const _kRed50 = Color(0xFFFEF2F2);
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
        colors: [_kSky500, _kRed500],
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
            color: _kSky700,
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
// Property field row
// ---------------------------------------------------------------------------
Widget _buildPropertyRow(String name, String value, Color dotColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: _kGray700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: TextStyle(fontSize: 13, color: _kGray500)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Wheel child offset visual — shows a single child on the cylinder
// ---------------------------------------------------------------------------
Widget _buildWheelChildVisual(
  int index,
  String label,
  double offsetFromCenter,
  bool isCenter,
) {
  final absOffset = offsetFromCenter.abs();
  final opacity = isCenter ? 255 : (absOffset < 80 ? 200 : 120);
  final scale = isCenter ? 1.0 : (1.0 - absOffset / 300.0).clamp(0.6, 1.0);
  final accent = isCenter ? _kSky500 : _kGray300;

  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: isCenter ? _kSky500.withAlpha(30) : _kGray100.withAlpha(opacity),
      border: Border.all(
        color: accent.withAlpha(opacity),
        width: isCenter ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCenter ? _kSky500 : _kGray300.withAlpha(opacity),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isCenter ? _kWhite : _kGray700.withAlpha(opacity),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14 * scale,
              fontWeight: isCenter ? FontWeight.w700 : FontWeight.w400,
              color: _kGray700.withAlpha(opacity),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'offset: ${offsetFromCenter.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: isCenter ? _kSky700 : _kGray500.withAlpha(opacity),
              ),
            ),
            Text(
              'scale: ${scale.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 10,
                color: _kGray500.withAlpha(opacity),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Data point card for offset visualization
// ---------------------------------------------------------------------------
Widget _buildOffsetDataCard(
  String childLabel,
  double offset,
  double angle,
  double paintY,
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
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            childLabel,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _kGray700,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('offset', style: TextStyle(fontSize: 10, color: _kGray500)),
              Text(
                '${offset.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accent,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('angle', style: TextStyle(fontSize: 10, color: _kGray500)),
              Text(
                '${angle.toStringAsFixed(1)}°',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accent,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('paintY', style: TextStyle(fontSize: 10, color: _kGray500)),
              Text(
                '${paintY.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accent,
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

// ---------------------------------------------------------------------------
// Relationship diagram block
// ---------------------------------------------------------------------------
Widget _buildRelationshipBlock(
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      border: Border.all(color: color.withAlpha(80)),
      borderRadius: BorderRadius.circular(10),
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
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.3),
              ),
            ],
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
  print('=== ListWheelParentData Demo ===');
  print('ListWheelParentData stores layout metadata for wheel children.');
  print('Key field: offset from the wheel center.');
  print('Used by: RenderListWheelViewport for cylindrical transforms.');

  final itemExtent = 42.0;
  final diameterRatio = 1.5;
  final viewportHeight = 300.0;
  final radius = viewportHeight * diameterRatio / 2.0;
  print('itemExtent: $itemExtent');
  print('diameterRatio: $diameterRatio');
  print('viewportHeight: $viewportHeight');
  print('Calculated cylinder radius: $radius');

  // Calculate offsets for sample children relative to center
  final childCount = 9;
  final centerIndex = 4;
  final offsets = List.generate(childCount, (i) {
    return (i - centerIndex) * itemExtent;
  });
  print('Child offsets from center: $offsets');
  print('Center child index: $centerIndex');

  final labels = [
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
    'Pluto',
  ];
  print('Demo labels: $labels');

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      color: _kSky50,
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
                colors: [_kSky700, _kRed700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kSky500.withAlpha(60),
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
                    Icon(Icons.data_object, color: _kWhite, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'ListWheelParentData',
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
                  'Layout metadata for children in a cylindrical wheel viewport',
                  style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(204)),
                ),
                SizedBox(height: 4),
                Text(
                  'rendering library • ListWheelScrollView • RenderListWheelViewport',
                  style: TextStyle(fontSize: 12, color: _kWhite.withAlpha(153)),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 1: What is ListWheelParentData?
          // ================================================================
          _buildSectionHeader(
            '01',
            'What is ListWheelParentData?',
            'Parent data class storing wheel layout metadata per child',
          ),

          _buildInfoCard(
            'Definition',
            'ListWheelParentData extends ContainerBoxParentData and stores the '
                'layout information each child needs within a ListWheelViewport. '
                'The key piece of data is the child\'s offset from the wheel center, '
                'which determines its position, rotation angle, and visual appearance.',
            _kSky500,
          ),

          _buildInfoCard(
            'Inheritance Chain',
            'ListWheelParentData\n'
                '  → ContainerBoxParentData<RenderBox>\n'
                '  → BoxParentData (provides offset)\n'
                '  → ParentData\n\n'
                'The sibling pointers from ContainerBoxParentData allow efficient '
                'traversal of wheel children during layout and painting.',
            _kRed500,
          ),

          _buildCodeSnippet(
            'ListWheelParentData structure',
            'class ListWheelParentData\n'
                '    extends ContainerBoxParentData<RenderBox> {\n'
                '  // Inherited:\n'
                '  //   Offset offset;  // position in parent\n'
                '  //   RenderBox? previousSibling;\n'
                '  //   RenderBox? nextSibling;\n'
                '  //\n'
                '  // The viewport uses this to store each\n'
                '  // child\'s scroll offset from center.\n'
                '  // During paint, offset maps to a position\n'
                '  // on the cylinder surface.\n'
                '}\n',
          ),

          // ================================================================
          // Section 2: Data Stored Per Child
          // ================================================================
          _buildSectionHeader(
            '02',
            'Data Stored Per Child',
            'What information the parent data holds for each wheel item',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSky500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parent Data Fields',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 10),
                _buildPropertyRow(
                  'offset',
                  'Final paint position in viewport coords (Offset)',
                  _kSky500,
                ),
                _buildPropertyRow(
                  'previousSibling',
                  'Prior child in the linked list (for traversal)',
                  _kRed500,
                ),
                _buildPropertyRow(
                  'nextSibling',
                  'Next child in the linked list',
                  _kSky500,
                ),
                Divider(color: _kGray100),
                _buildPropertyRow(
                  'index (implicit)',
                  'Child index used to compute scroll offset',
                  _kRed500,
                ),
                _buildPropertyRow(
                  'scrollOffset',
                  'Distance from center in scroll units (computed)',
                  _kSky500,
                ),
              ],
            ),
          ),

          _buildInfoCard(
            'Offset vs ScrollOffset',
            'The parent data\'s offset field stores the final paint position in '
                'parent coordinates. The scroll offset (distance from center in '
                'logical units) is computed from the child\'s index and the current '
                'scroll position. The viewport converts scroll offset → cylinder '
                'angle → paint position during layout.',
            _kSky500,
          ),

          // ================================================================
          // Section 3: Wheel Viewport Visualization
          // ================================================================
          _buildSectionHeader(
            '03',
            'Wheel Viewport Visualization',
            'How children are positioned on the 3D cylinder surface',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kSky500.withAlpha(60)),
            ),
            child: Column(
              children: [
                Text(
                  'Cylindrical Viewport — Child Positions',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kSky700,
                  ),
                ),
                SizedBox(height: 12),
                ...List.generate(childCount, (i) {
                  return _buildWheelChildVisual(
                    i,
                    labels[i],
                    offsets[i],
                    i == centerIndex,
                  );
                }),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kSky50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Each child\'s parent data stores its scroll offset from center. '
                    'The viewport converts this to a position on the cylinder surface. '
                    'Center child (${labels[centerIndex]}) has offset 0.0 — full size and opacity.',
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
          // Section 4: Offset-to-Angle Mapping
          // ================================================================
          _buildSectionHeader(
            '04',
            'Offset to Angle Mapping',
            'How scroll offset converts to a cylinder angle for painting',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offset → Angle → Paint Position',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 10),
                ...List.generate(childCount, (i) {
                  final scrollOff = offsets[i];
                  final angle = scrollOff / radius * 180 / 3.14159;
                  final paintY =
                      viewportHeight / 2 +
                      radius * (scrollOff / radius).clamp(-1.0, 1.0);
                  final accent = i == centerIndex ? _kSky500 : _kRed500;
                  return _buildOffsetDataCard(
                    labels[i],
                    scrollOff,
                    angle,
                    paintY,
                    accent,
                  );
                }),
              ],
            ),
          ),

          _buildCodeSnippet(
            'Offset to cylinder position (simplified)',
            '// Convert scroll offset to paint coordinates\n'
                'double getOffsetToReveal(int index) {\n'
                '  return index * itemExtent;\n'
                '}\n'
                '\n'
                'double scrollOffsetToAngle(double offset) {\n'
                '  return offset / radius; // radians\n'
                '}\n'
                '\n'
                'Offset angleToPosition(double angle) {\n'
                '  final y = radius * sin(angle);\n'
                '  final z = radius * (1 - cos(angle));\n'
                '  // Apply perspective projection\n'
                '  return Offset(0, centerY + y);\n'
                '}\n',
          ),

          // ================================================================
          // Section 5: Relationship with ListWheelChildManager
          // ================================================================
          _buildSectionHeader(
            '05',
            'Relationship with ChildManager',
            'How parent data and child manager work together',
          ),

          _buildRelationshipBlock(
            'ListWheelChildManager',
            'Creates/destroys children as the wheel scrolls. Decides which '
                'indices need to exist in the render tree.',
            Icons.manage_accounts,
            _kSky500,
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Center(
              child: Icon(Icons.swap_vert, color: _kGray500, size: 28),
            ),
          ),

          _buildRelationshipBlock(
            'ListWheelParentData',
            'Stores position metadata on each created child. The viewport reads '
                'this during layout and paint to position items on the cylinder.',
            Icons.data_object,
            _kRed500,
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Center(
              child: Icon(Icons.swap_vert, color: _kGray500, size: 28),
            ),
          ),

          _buildRelationshipBlock(
            'RenderListWheelViewport',
            'The render object that performs layout. Calls child manager to get '
                'children, writes parent data during layout, reads it during paint.',
            Icons.view_in_ar,
            _kSky500,
          ),

          SizedBox(height: 8),

          _buildExplanationStep(
            1,
            'Viewport determines visible index range from current scroll offset.',
            _kSky500,
          ),
          _buildExplanationStep(
            2,
            'ChildManager creates children for visible indices (lazy creation).',
            _kRed500,
          ),
          _buildExplanationStep(
            3,
            'Viewport lays out each child and writes its offset into parent data.',
            _kSky500,
          ),
          _buildExplanationStep(
            4,
            'During paint, viewport reads parent data to apply cylindrical transforms.',
            _kRed500,
          ),
          _buildExplanationStep(
            5,
            'When scrolling, out-of-range children\'s parent data becomes stale; '
            'the child manager removes them.',
            _kSky500,
          ),

          // ================================================================
          // Section 6: Layout Algorithm Detail
          // ================================================================
          _buildSectionHeader(
            '06',
            'Layout Algorithm Detail',
            'How the viewport writes parent data during layout',
          ),

          _buildCodeSnippet(
            'RenderListWheelViewport.performLayout (simplified)',
            'void performLayout() {\n'
                '  size = constraints.biggest;\n'
                '  final centerOffset = size.height / 2;\n'
                '\n'
                '  RenderBox? child = firstChild;\n'
                '  while (child != null) {\n'
                '    final pd = child.parentData\n'
                '        as ListWheelParentData;\n'
                '\n'
                '    // Lay out child with tight width\n'
                '    child.layout(\n'
                '      BoxConstraints.tightFor(\n'
                '        width: size.width,\n'
                '        height: itemExtent,\n'
                '      ),\n'
                '      parentUsesSize: true,\n'
                '    );\n'
                '\n'
                '    // Compute paint offset on cylinder\n'
                '    final scrollDelta = getChildOffset(pd);\n'
                '    pd.offset = Offset(\n'
                '      0,\n'
                '      centerOffset + scrollDelta,\n'
                '    );\n'
                '\n'
                '    child = pd.nextSibling;\n'
                '  }\n'
                '}\n',
          ),

          _buildInfoCard(
            'Tight Constraints',
            'Each child receives tight constraints: full viewport width and '
                'exactly itemExtent height. This ensures uniform sizing on the wheel. '
                'The parent data offset is then set to the calculated paint position.',
            _kRed500,
          ),

          // ================================================================
          // Section 7: Paint Transform
          // ================================================================
          _buildSectionHeader(
            '07',
            'Paint Transform',
            'How parent data offset drives the cylindrical paint effect',
          ),

          _buildInfoCard(
            'Cylindrical Transform Steps',
            '1. Read child offset from parent data\n'
                '2. Compute angle on cylinder: angle = offset / radius\n'
                '3. Apply rotation transform around X-axis\n'
                '4. Apply perspective projection (foreshortening)\n'
                '5. Adjust opacity based on angle (fade at edges)\n'
                '6. Paint child at transformed position',
            _kSky500,
          ),

          _buildCodeSnippet(
            'Paint transform (simplified)',
            'void paintChild(RenderBox child) {\n'
                '  final pd = child.parentData\n'
                '      as ListWheelParentData;\n'
                '  final angle = getAngle(pd.offset.dy);\n'
                '\n'
                '  final transform = Matrix4.identity()\n'
                '    ..setEntry(3, 2, perspective)\n'
                '    ..translate(0.0, pd.offset.dy, 0.0)\n'
                '    ..rotateX(angle);\n'
                '\n'
                '  context.pushTransform(\n'
                '    needsCompositing,\n'
                '    pd.offset,\n'
                '    transform,\n'
                '    (context, offset) {\n'
                '      context.paintChild(child, offset);\n'
                '    },\n'
                '  );\n'
                '}\n',
          ),

          // ================================================================
          // Section 8: Practical Considerations
          // ================================================================
          _buildSectionHeader(
            '08',
            'Practical Considerations',
            'Performance and usage tips for wheel parent data',
          ),

          ...[
            [
              'Memory Efficiency',
              'Only visible children have parent data in memory. For a 10,000 '
                  'item list with 7 visible, only 7 parent data objects exist.',
              _kSky500,
            ],
            [
              'Offset Precision',
              'Parent data offsets are in logical pixels. The viewport handles '
                  'device pixel ratio conversion during painting.',
              _kRed500,
            ],
            [
              'Sibling Chain',
              'The sibling pointers in parent data enable O(n) traversal where '
                  'n is the visible count, not total item count.',
              _kSky500,
            ],
            [
              'Scroll Snapping',
              'FixedExtentScrollPhysics ensures scroll stops at exact item '
                  'boundaries, aligning with parent data offset calculations.',
              _kRed500,
            ],
            [
              'Custom Viewports',
              'You can create custom wheel viewports by overriding how parent '
                  'data offsets map to visual transforms (e.g., spiral wheel).',
              _kSky500,
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
              color: _kRed50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kRed500.withAlpha(40)),
            ),
            child: Text(
              'ListWheelParentData is the data bridge between scroll position and '
              'visual representation on the cylinder. Each child\'s offset from '
              'center drives its rotation angle, opacity, and scale — creating the '
              'iconic iOS-style picker wheel effect in Flutter.',
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
