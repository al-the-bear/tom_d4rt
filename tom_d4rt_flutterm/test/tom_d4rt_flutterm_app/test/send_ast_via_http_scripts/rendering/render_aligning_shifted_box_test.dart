// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for RenderAligningShiftedBox from rendering
//
// RenderAligningShiftedBox is an abstract render box mixin that positions
// its child using alignment. It serves as the base for RenderPositionedBox,
// RenderConstraintsTransformBox, and other aligned layout render objects.
//
// This demo shows:
//   1. RenderAligningShiftedBox overview - abstract class, alignment property,
//      textDirection, how it shifts child positioning
//   2. Alignment values visual grid - all 9 predefined positions with colored boxes
//   3. Fractional alignment - Alignment(x, y) custom mappings from -1 to 1
//   4. AlignmentDirectional - textDirection effects for RTL support
//   5. heightFactor and widthFactor - constraining the shifted box sizing
//   6. Common subclasses and patterns - Align, Center, FractionallySizedBox
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _kPrimary900 = Color(0xFF1A237E);
Color _kPrimary700 = Color(0xFF303F9F);
Color _kPrimary500 = Color(0xFF3F51B5);
Color _kPrimary300 = Color(0xFF7986CB);
Color _kPrimary200 = Color(0xFF9FA8DA);
Color _kPrimary50 = Color(0xFFE8EAF6);

Color _kAccentOrange = Color(0xFFFF5722);
Color _kAccentAmber = Color(0xFFFFC107);
Color _kAccentTeal = Color(0xFF009688);
Color _kAccentPink = Color(0xFFE91E63);
Color _kAccentCyan = Color(0xFF00BCD4);
Color _kAccentGreen = Color(0xFF4CAF50);
Color _kAccentPurple = Color(0xFF9C27B0);
Color _kAccentRed = Color(0xFFF44336);

Color _kSurface = Color(0xFFF5F5F5);
Color _kCardBg = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGET FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════

// Builds a styled section header with gradient and icon
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary900, _kPrimary500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kPrimary900.withAlpha(80),
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

// Builds a content card with title bar and body
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  Color color = accentColor ?? _kPrimary500;
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

// Builds an alignment demo box that visually shows where a child is placed
Widget _buildAlignmentDemoBox(
  AlignmentGeometry alignment,
  String label,
  Color dotColor, {
  double boxSize = 100,
  double dotSize = 20,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: _kPrimary50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kPrimary300, width: 2),
        ),
        child: Align(
          alignment: alignment,
          child: Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: dotColor.withAlpha(120),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _kPrimary700,
        ),
      ),
    ],
  );
}

// Builds a labeled info row with icon
Widget _buildInfoRow(IconData icon, String label, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _kPrimary500),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _kPrimary700,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Builds a color-tagged chip label
Widget _buildChip(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// Builds a code-style text block
Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFE0E0E0),
        height: 1.5,
      ),
    ),
  );
}

// Builds a gradient divider between sections
Widget _buildDivider() {
  return Container(
    height: 3,
    margin: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kPrimary500.withAlpha(0),
          _kPrimary500.withAlpha(80),
          _kPrimary500.withAlpha(0),
        ],
      ),
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

// Builds a factor demo showing how widthFactor / heightFactor work
Widget _buildFactorDemo(
  String label,
  double? widthFactor,
  double? heightFactor,
  Color color,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          color: _kPrimary50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kPrimary300, width: 1),
        ),
        child: Align(
          alignment: Alignment.center,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(80),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.crop_square, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _kPrimary700,
        ),
      ),
    ],
  );
}

// Builds an RTL/LTR comparison demo
Widget _buildDirectionalityDemo(
  String label,
  AlignmentGeometry alignment,
  TextDirection direction,
  Color color,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: _kPrimary700,
        ),
      ),
      SizedBox(height: 4),
      Directionality(
        textDirection: direction,
        child: Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
            color: _kPrimary50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withAlpha(80), width: 2),
          ),
          child: Align(
            alignment: alignment,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: color.withAlpha(100),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  direction == TextDirection.ltr ? 'L' : 'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Builds a subclass example card
Widget _buildSubclassCard(
  String name,
  String description,
  IconData icon,
  Color color,
  Widget example,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(10),
          blurRadius: 4,
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
            gradient: LinearGradient(
              colors: [color.withAlpha(30), color.withAlpha(10)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: example,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION BUILDERS
// ═══════════════════════════════════════════════════════════════════════════

// Section 1: Overview of RenderAligningShiftedBox
Widget _buildOverviewSection() {
  print('[Section 1] RenderAligningShiftedBox overview');
  print('  Abstract class from rendering library');
  print('  Mixin that adds alignment + textDirection properties');
  print('  Shifts child position within its parent bounds');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '1. RenderAligningShiftedBox Overview',
        Icons.account_tree_outlined,
      ),
      _buildCard(
        'What is RenderAligningShiftedBox?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              Icons.category,
              'Type',
              'Abstract class extending RenderShiftedBox',
            ),
            _buildInfoRow(
              Icons.layers,
              'Library',
              'package:flutter/rendering.dart',
            ),
            _buildInfoRow(
              Icons.description,
              'Purpose',
              'Positions a single child using an AlignmentGeometry value, '
                  'resolving directional alignment based on textDirection',
            ),
            _buildInfoRow(
              Icons.transform,
              'Mechanism',
              'Computes an offset to shift the child within the parent box, '
                  'delegating the actual offset to the parent data',
            ),
            SizedBox(height: 12),
            _buildCodeBlock(
              'abstract class RenderAligningShiftedBox\n'
              '    extends RenderShiftedBox {\n'
              '  AlignmentGeometry _alignment;\n'
              '  TextDirection? _textDirection;\n'
              '\n'
              '  // Resolves alignment to a concrete Alignment\n'
              '  // then computes child offset:\n'
              '  //   offset = alignment.alongOffset(parentSize - childSize)\n'
              '  void alignChild() { ... }\n'
              '}',
            ),
          ],
        ),
      ),
      _buildCard(
        'Type Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeBlock(
              'RenderObject\n'
              '  -> RenderBox\n'
              '       -> RenderShiftedBox\n'
              '            -> RenderAligningShiftedBox\n'
              '                 -> RenderPositionedBox (Align/Center)\n'
              '                 -> RenderConstraintsTransformBox\n'
              '                 -> RenderFractionallySizedOverflowBox',
            ),
            SizedBox(height: 12),
            Wrap(
              children: [
                _buildChip('alignment', _kPrimary500),
                _buildChip('textDirection', _kAccentTeal),
                _buildChip('alignChild()', _kAccentOrange),
                _buildChip('RenderShiftedBox', _kAccentPurple),
              ],
            ),
          ],
        ),
        accentColor: _kAccentTeal,
      ),
      _buildCard(
        'Key Properties',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              Icons.align_horizontal_center,
              'alignment',
              'AlignmentGeometry that determines where the child is placed '
                  'inside the parent. Defaults to Alignment.center in most subclasses.',
            ),
            _buildInfoRow(
              Icons.text_format,
              'textDirection',
              'TextDirection used to resolve AlignmentDirectional values. '
                  'Required when alignment is directional (start/end based).',
            ),
            _buildInfoRow(
              Icons.functions,
              'alignChild()',
              'Protected method that resolves alignment and sets the child '
                  'parentData offset. Called during performLayout() of subclasses.',
            ),
          ],
        ),
        accentColor: _kAccentPurple,
      ),
    ],
  );
}

// Section 2: Alignment values visual grid
Widget _buildAlignmentGridSection() {
  print('[Section 2] Alignment values visual grid');
  print('  Showing all 9 predefined Alignment positions');

  List<MapEntry<Alignment, String>> alignments = [
    MapEntry(Alignment.topLeft, 'topLeft'),
    MapEntry(Alignment.topCenter, 'topCenter'),
    MapEntry(Alignment.topRight, 'topRight'),
    MapEntry(Alignment.centerLeft, 'centerLeft'),
    MapEntry(Alignment.center, 'center'),
    MapEntry(Alignment.centerRight, 'centerRight'),
    MapEntry(Alignment.bottomLeft, 'bottomLeft'),
    MapEntry(Alignment.bottomCenter, 'bottomCenter'),
    MapEntry(Alignment.bottomRight, 'bottomRight'),
  ];

  List<Color> colors = [
    _kAccentRed,
    _kAccentOrange,
    _kAccentAmber,
    _kAccentGreen,
    _kPrimary500,
    _kAccentTeal,
    _kAccentCyan,
    _kAccentPurple,
    _kAccentPink,
  ];

  for (int i = 0; i < alignments.length; i++) {
    MapEntry<Alignment, String> entry = alignments[i];
    print('  ${entry.value}: (${entry.key.x}, ${entry.key.y})');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '2. Alignment Values Grid',
        Icons.grid_on,
      ),
      _buildCard(
        'All 9 Predefined Alignment Constants',
        Column(
          children: [
            Text(
              'Each box shows where a child is positioned using the given Alignment. '
              'The colored dot represents the child element inside the parent container.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            SizedBox(height: 16),
            // Row 1: top alignments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentDemoBox(
                  alignments[0].key, alignments[0].value, colors[0],
                ),
                _buildAlignmentDemoBox(
                  alignments[1].key, alignments[1].value, colors[1],
                ),
                _buildAlignmentDemoBox(
                  alignments[2].key, alignments[2].value, colors[2],
                ),
              ],
            ),
            SizedBox(height: 12),
            // Row 2: center alignments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentDemoBox(
                  alignments[3].key, alignments[3].value, colors[3],
                ),
                _buildAlignmentDemoBox(
                  alignments[4].key, alignments[4].value, colors[4],
                ),
                _buildAlignmentDemoBox(
                  alignments[5].key, alignments[5].value, colors[5],
                ),
              ],
            ),
            SizedBox(height: 12),
            // Row 3: bottom alignments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentDemoBox(
                  alignments[6].key, alignments[6].value, colors[6],
                ),
                _buildAlignmentDemoBox(
                  alignments[7].key, alignments[7].value, colors[7],
                ),
                _buildAlignmentDemoBox(
                  alignments[8].key, alignments[8].value, colors[8],
                ),
              ],
            ),
          ],
        ),
      ),
      _buildCard(
        'Coordinate System',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeBlock(
              'Alignment(x, y)\n'
              '  x: -1.0 = left,   0.0 = center,  1.0 = right\n'
              '  y: -1.0 = top,    0.0 = center,  1.0 = bottom\n'
              '\n'
              'topLeft     = Alignment(-1.0, -1.0)\n'
              'center      = Alignment( 0.0,  0.0)\n'
              'bottomRight = Alignment( 1.0,  1.0)',
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: _kAccentTeal),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'The offset formula: child position = alignment.alongOffset(parentSize - childSize)',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: _kAccentTeal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        accentColor: _kAccentOrange,
      ),
    ],
  );
}

// Section 3: Fractional alignment with custom values
Widget _buildFractionalAlignmentSection() {
  print('[Section 3] Fractional alignment with custom values');

  List<MapEntry<Alignment, String>> customAlignments = [
    MapEntry(Alignment(0.3, -0.7), '(0.3, -0.7)'),
    MapEntry(Alignment(-0.5, 0.5), '(-0.5, 0.5)'),
    MapEntry(Alignment(0.8, 0.2), '(0.8, 0.2)'),
    MapEntry(Alignment(-1.0, 0.0), '(-1.0, 0.0)'),
    MapEntry(Alignment(0.0, 1.0), '(0.0, 1.0)'),
    MapEntry(Alignment(0.6, -0.4), '(0.6, -0.4)'),
  ];

  for (int i = 0; i < customAlignments.length; i++) {
    MapEntry<Alignment, String> entry = customAlignments[i];
    print('  Custom alignment ${entry.value}');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '3. Fractional Alignment',
        Icons.control_camera,
      ),
      _buildCard(
        'Custom Alignment(x, y) Values',
        Column(
          children: [
            Text(
              'Values between -1.0 and 1.0 place the child proportionally. '
              'Values outside this range overshoot the parent bounds.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentDemoBox(
                  customAlignments[0].key,
                  customAlignments[0].value,
                  _kAccentOrange,
                  boxSize: 90,
                ),
                _buildAlignmentDemoBox(
                  customAlignments[1].key,
                  customAlignments[1].value,
                  _kAccentGreen,
                  boxSize: 90,
                ),
                _buildAlignmentDemoBox(
                  customAlignments[2].key,
                  customAlignments[2].value,
                  _kAccentPink,
                  boxSize: 90,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAlignmentDemoBox(
                  customAlignments[3].key,
                  customAlignments[3].value,
                  _kAccentCyan,
                  boxSize: 90,
                ),
                _buildAlignmentDemoBox(
                  customAlignments[4].key,
                  customAlignments[4].value,
                  _kAccentPurple,
                  boxSize: 90,
                ),
                _buildAlignmentDemoBox(
                  customAlignments[5].key,
                  customAlignments[5].value,
                  _kAccentRed,
                  boxSize: 90,
                ),
              ],
            ),
          ],
        ),
      ),
      _buildCard(
        'How Fractional Positioning Works',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              Icons.straighten,
              'Formula',
              'offset = ((parentWidth - childWidth) * (x + 1) / 2, '
                  '(parentHeight - childHeight) * (y + 1) / 2)',
            ),
            _buildInfoRow(
              Icons.calculate,
              'Example',
              'Alignment(0.3, -0.7) in a 200x200 parent with a 50x50 child: '
                  'x_offset = 150 * (0.3 + 1) / 2 = 97.5, '
                  'y_offset = 150 * (-0.7 + 1) / 2 = 22.5',
            ),
            SizedBox(height: 8),
            _buildCodeBlock(
              '// Alignment.alongOffset() implementation:\n'
              'Offset alongOffset(Offset other) {\n'
              '  double centerX = other.dx / 2.0;\n'
              '  double centerY = other.dy / 2.0;\n'
              '  return Offset(\n'
              '    centerX + x * centerX,\n'
              '    centerY + y * centerY,\n'
              '  );\n'
              '}',
            ),
          ],
        ),
        accentColor: _kAccentAmber,
      ),
    ],
  );
}

// Section 4: AlignmentDirectional for RTL support
Widget _buildDirectionalSection() {
  print('[Section 4] AlignmentDirectional for RTL support');
  print('  Comparing LTR vs RTL behavior');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '4. AlignmentDirectional & RTL',
        Icons.swap_horiz,
      ),
      _buildCard(
        'AlignmentDirectional vs Alignment',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AlignmentDirectional uses start/end instead of left/right, '
              'which flips based on TextDirection. This is essential for '
              'proper RTL (right-to-left) language support.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            SizedBox(height: 12),
            _buildCodeBlock(
              '// AlignmentDirectional uses start/end:\n'
              'AlignmentDirectional.topStart  // top-left in LTR, top-right in RTL\n'
              'AlignmentDirectional.topEnd    // top-right in LTR, top-left in RTL\n'
              'AlignmentDirectional.centerStart\n'
              'AlignmentDirectional.centerEnd\n'
              'AlignmentDirectional.bottomStart\n'
              'AlignmentDirectional.bottomEnd',
            ),
          ],
        ),
      ),
      _buildCard(
        'LTR vs RTL Visual Comparison',
        Column(
          children: [
            Text(
              'The same AlignmentDirectional.topStart resolves differently:',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDirectionalityDemo(
                  'LTR + topStart',
                  AlignmentDirectional.topStart,
                  TextDirection.ltr,
                  _kAccentTeal,
                ),
                _buildDirectionalityDemo(
                  'RTL + topStart',
                  AlignmentDirectional.topStart,
                  TextDirection.rtl,
                  _kAccentOrange,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDirectionalityDemo(
                  'LTR + centerEnd',
                  AlignmentDirectional.centerEnd,
                  TextDirection.ltr,
                  _kAccentPurple,
                ),
                _buildDirectionalityDemo(
                  'RTL + centerEnd',
                  AlignmentDirectional.centerEnd,
                  TextDirection.rtl,
                  _kAccentPink,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDirectionalityDemo(
                  'LTR + bottomEnd',
                  AlignmentDirectional.bottomEnd,
                  TextDirection.ltr,
                  _kAccentGreen,
                ),
                _buildDirectionalityDemo(
                  'RTL + bottomEnd',
                  AlignmentDirectional.bottomEnd,
                  TextDirection.rtl,
                  _kAccentRed,
                ),
              ],
            ),
          ],
        ),
        accentColor: _kAccentOrange,
      ),
      _buildCard(
        'textDirection in RenderAligningShiftedBox',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              Icons.text_rotation_none,
              'Property',
              'textDirection is nullable on RenderAligningShiftedBox. '
                  'It is required only when the alignment is directional.',
            ),
            _buildInfoRow(
              Icons.warning_amber,
              'Caution',
              'Passing an AlignmentDirectional without a textDirection '
                  'will throw an error during layout when alignChild() is called.',
            ),
            SizedBox(height: 8),
            _buildCodeBlock(
              '// textDirection is used in resolution:\n'
              'void alignChild() {\n'
              '  final Alignment resolved =\n'
              '      _alignment.resolve(_textDirection);\n'
              '  // For Alignment, textDirection is ignored\n'
              '  // For AlignmentDirectional, it flips start/end\n'
              '}',
            ),
          ],
        ),
        accentColor: _kAccentTeal,
      ),
    ],
  );
}

// Section 5: heightFactor and widthFactor
Widget _buildFactorsSection() {
  print('[Section 5] heightFactor and widthFactor');
  print('  Demonstrating how factors constrain the shifted box sizing');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '5. widthFactor & heightFactor',
        Icons.aspect_ratio,
      ),
      _buildCard(
        'Factor Sizing Behavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In subclasses like RenderPositionedBox (used by Align), '
              'widthFactor and heightFactor control the parent size '
              'relative to the child. When null, the parent expands to fill '
              'available space. When set, the parent shrinks to a multiple '
              'of the child size.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFactorDemo(
                  'No factors\n(fills parent)',
                  null,
                  null,
                  _kPrimary500,
                ),
                _buildFactorDemo(
                  'widthFactor: 2.0\nheightFactor: 1.5',
                  2.0,
                  1.5,
                  _kAccentOrange,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFactorDemo(
                  'widthFactor: 1.0\nheightFactor: 1.0',
                  1.0,
                  1.0,
                  _kAccentTeal,
                ),
                _buildFactorDemo(
                  'widthFactor: 1.5\nheightFactor: 2.0',
                  1.5,
                  2.0,
                  _kAccentPink,
                ),
              ],
            ),
          ],
        ),
      ),
      _buildCard(
        'How Factors Affect Layout',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCodeBlock(
              '// In RenderPositionedBox.performLayout():\n'
              'bool shrinkWrapWidth =\n'
              '    _widthFactor != null ||\n'
              '    constraints.maxWidth == double.infinity;\n'
              'bool shrinkWrapHeight =\n'
              '    _heightFactor != null ||\n'
              '    constraints.maxHeight == double.infinity;\n'
              '\n'
              'if (child != null) {\n'
              '  child!.layout(constraints.loosen(),\n'
              '      parentUsesSize: true);\n'
              '  size = constraints.constrain(Size(\n'
              '    shrinkWrapWidth\n'
              '      ? child!.size.width * (_widthFactor ?? 1.0)\n'
              '      : double.infinity,\n'
              '    shrinkWrapHeight\n'
              '      ? child!.size.height * (_heightFactor ?? 1.0)\n'
              '      : double.infinity,\n'
              '  ));\n'
              '  alignChild();\n'
              '}',
            ),
            SizedBox(height: 12),
            _buildInfoRow(
              Icons.info_outline,
              'Shrink-wrap',
              'When a factor is set, the box "shrink-wraps" on that axis '
                  'to child.size * factor, rather than expanding to fill.',
            ),
            _buildInfoRow(
              Icons.open_in_full,
              'Unbounded',
              'When constraints are unbounded (e.g., inside a ListView), '
                  'factors are also implicitly activated to avoid infinite size.',
            ),
          ],
        ),
        accentColor: _kAccentAmber,
      ),
    ],
  );
}

// Section 6: Common subclasses and patterns
Widget _buildSubclassesSection() {
  print('[Section 6] Common subclasses and patterns');
  print('  RenderPositionedBox, Align, Center, FractionallySizedBox');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        '6. Common Subclasses & Patterns',
        Icons.widgets_outlined,
      ),
      _buildSubclassCard(
        'Align Widget (RenderPositionedBox)',
        'Most common subclass. Positions child within itself using alignment.',
        Icons.align_horizontal_center,
        _kPrimary500,
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: _kPrimary50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kPrimary300),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kPrimary500, _kPrimary700],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Right',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubclassCard(
        'Center Widget',
        'Convenience shorthand for Align with alignment: Alignment.center.',
        Icons.center_focus_strong,
        _kAccentTeal,
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccentTeal.withAlpha(80)),
          ),
          child: Center(
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kAccentTeal, Color(0xFF00796B)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Centered',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubclassCard(
        'FractionallySizedBox',
        'Sizes its child to a fraction of available space, then aligns.',
        Icons.photo_size_select_large,
        _kAccentOrange,
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccentOrange.withAlpha(80)),
          ),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.7,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kAccentOrange, Color(0xFFE64A19)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '60% x 70%',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubclassCard(
        'CustomSingleChildLayout',
        'Uses a delegate for fully custom positioning, building on alignment concepts.',
        Icons.dashboard_customize,
        _kAccentPurple,
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccentPurple.withAlpha(80)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(-0.6, -0.4),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _kAccentPurple.withAlpha(80),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.5, 0.3),
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_kAccentPurple, Color(0xFF7B1FA2)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      'Custom',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      _buildCard(
        'Summary: When to Use What',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              Icons.check_circle_outline,
              'Align',
              'Position a single child anywhere within parent bounds',
            ),
            _buildInfoRow(
              Icons.check_circle_outline,
              'Center',
              'Shorthand when you only need center alignment',
            ),
            _buildInfoRow(
              Icons.check_circle_outline,
              'FractionallySizedBox',
              'Size child as fraction of parent, then align',
            ),
            _buildInfoRow(
              Icons.check_circle_outline,
              'ConstraintsTransformBox',
              'Override constraints before letting child layout',
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kAccentGreen.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kAccentGreen.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: _kAccentGreen),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'All these widgets use RenderAligningShiftedBox under the hood '
                      'to compute the child offset from the alignment property.',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: _kAccentGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        accentColor: _kAccentGreen,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('');
  print('========================================================');
  print('  RenderAligningShiftedBox - Comprehensive Deep Demo');
  print('========================================================');
  print('');
  print('RenderAligningShiftedBox is an abstract class that adds');
  print('alignment-based child positioning to RenderShiftedBox.');
  print('It is the foundation for Align, Center, and other layout');
  print('widgets that need to position a child within a parent box.');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RenderAligningShiftedBox Demo'),
        backgroundColor: _kPrimary700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _kPrimary900,
                    _kPrimary700,
                    _kPrimary500,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _kPrimary900.withAlpha(60),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.account_tree, color: Colors.white, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'RenderAligningShiftedBox',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Abstract render box for alignment-based child positioning',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Section 1: Overview
            _buildOverviewSection(),
            _buildDivider(),

            // Section 2: Alignment Grid
            _buildAlignmentGridSection(),
            _buildDivider(),

            // Section 3: Fractional Alignment
            _buildFractionalAlignmentSection(),
            _buildDivider(),

            // Section 4: Directionality
            _buildDirectionalSection(),
            _buildDivider(),

            // Section 5: Factors
            _buildFactorsSection(),
            _buildDivider(),

            // Section 6: Subclasses
            _buildSubclassesSection(),

            // Footer
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kPrimary50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPrimary200),
              ),
              child: Column(
                children: [
                  Icon(Icons.verified, color: _kPrimary500, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'RenderAligningShiftedBox Demo Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _kPrimary700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Covered: overview, alignment grid, fractional values, '
                    'RTL directionality, sizing factors, and common subclasses',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: _kPrimary500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
