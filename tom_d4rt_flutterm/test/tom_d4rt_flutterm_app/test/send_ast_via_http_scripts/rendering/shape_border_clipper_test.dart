// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: ShapeBorderClipper
//
// ShapeBorderClipper is a CustomClipper<Path> that clips a widget to the
// outer path of a ShapeBorder. It enables clipping to rounded rectangles,
// stadiums, circles, beveled shapes, and arbitrary ShapeBorder outlines.
//
// This demo visualises:
//   1. What ShapeBorderClipper does and how it relates to CustomClipper
//   2. The ShapeBorder hierarchy (RoundedRectangleBorder, CircleBorder, etc.)
//   3. How getClip() converts a ShapeBorder into a Path
//   4. Various border shapes and their clipping results
//   5. Comparison: ShapeBorderClipper vs manual clipping approaches
//   6. Integration with ClipPath and PhysicalShape
//   7. TextDirection sensitivity for directional borders
//   8. Performance considerations and shouldReclip()
//   9. Custom shape border creation and advanced patterns
//
// All visuals use standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Indigo / LightBlue
// ---------------------------------------------------------------------------
const Color _scPrimary = Color(0xFF283593);
const Color _scPrimaryLight = Color(0xFF3F51B5);
const Color _scAccent = Color(0xFF03A9F4);
const Color _scAccentDark = Color(0xFF0277BD);
const Color _scSurface = Color(0xFFE8EAF6);
const Color _scSurfaceDark = Color(0xFFC5CAE9);
const Color _scOnPrimary = Color(0xFFFFFFFF);
const Color _scTextDark = Color(0xFF1A237E);
const Color _scTextMedium = Color(0xFF3949AB);
const Color _scDivider = Color(0xFF9FA8DA);
const Color _scGreen = Color(0xFF2E7D32);
const Color _scOrange = Color(0xFFE65100);
const Color _scPurple = Color(0xFF6A1B9A);
const Color _scPink = Color(0xFFC2185B);
const Color _scGrey = Color(0xFF757575);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _scSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _scPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _scTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _scDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _scBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _scInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _scPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _scSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _scTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _scTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: shape preview card
// ---------------------------------------------------------------------------
Widget _scShapeCard(String name, ShapeBorder border, Color color) {
  return Container(
    width: 80,
    height: 80,
    decoration: ShapeDecoration(
      color: color.withValues(alpha: 0.15),
      shape: border,
    ),
    alignment: Alignment.center,
    child: Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color)),
  );
}

// ---------------------------------------------------------------------------
// Helper: code snippet
// ---------------------------------------------------------------------------
Widget _scCode(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _scSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _scPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: ShapeBorderClipper Overview
// ---------------------------------------------------------------------------
Widget _scSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _scSectionTitle('1 · ShapeBorderClipper Overview', Icons.crop),
      _scInfoCard(
        'What is ShapeBorderClipper?',
        'A CustomClipper<Path> that produces a clip path from a ShapeBorder. '
            'It calls shape.getOuterPath(rect) to obtain the Path used for '
            'clipping. This lets you clip any widget to the outline of any '
            'ShapeBorder without manual path construction.',
        Icons.content_cut,
      ),
      _scInfoCard(
        'CustomClipper<Path> contract',
        'ShapeBorderClipper extends CustomClipper<Path> and overrides '
            'getClip(Size size) → Path and shouldReclip(). The Path returned '
            'by getClip is used by ClipPath or PhysicalShape to clip their child.',
        Icons.description_outlined,
        accent: _scAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _scBadge('ShapeBorder', _scPrimary, _scOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _scGrey),
                _scBadge('getOuterPath()', _scAccentDark, _scOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _scGrey),
                _scBadge('Path', _scGreen, _scOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'The clipper delegates path generation to the ShapeBorder',
              style: TextStyle(fontSize: 11, color: _scTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: ShapeBorder Hierarchy
// ---------------------------------------------------------------------------
Widget _scSection2Hierarchy() {
  final shapes = <Map<String, dynamic>>[
    {'name': 'RoundedRectangleBorder', 'desc': 'Rectangle with rounded corners', 'icon': Icons.rounded_corner, 'color': _scPrimary},
    {'name': 'CircleBorder', 'desc': 'Perfect circle outline', 'icon': Icons.circle_outlined, 'color': _scAccentDark},
    {'name': 'StadiumBorder', 'desc': 'Pill/stadium shape', 'icon': Icons.sports_soccer, 'color': _scGreen},
    {'name': 'BeveledRectangleBorder', 'desc': 'Rectangle with beveled corners', 'icon': Icons.change_history, 'color': _scOrange},
    {'name': 'ContinuousRectangleBorder', 'desc': 'Superellipse corners (squircle)', 'icon': Icons.crop_square, 'color': _scPurple},
    {'name': 'StarBorder', 'desc': 'Star or polygon outline', 'icon': Icons.star_outline, 'color': _scPink},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('2 · ShapeBorder Hierarchy', Icons.account_tree),
      _scInfoCard(
        'Built-in ShapeBorder subclasses',
        'Flutter provides several ShapeBorder implementations. Each defines '
            'getOuterPath() (the clip path) and getInnerPath() (the content '
            'area). ShapeBorderClipper uses getOuterPath().',
        Icons.category,
      ),
      ...shapes.map((s) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(s['icon'] as IconData, size: 18, color: s['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['name'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _scTextDark)),
                  SizedBox(height: 2),
                  Text(s['desc'] as String, style: TextStyle(fontSize: 11, color: _scTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: getClip() Path Generation
// ---------------------------------------------------------------------------
Widget _scSection3GetClip() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('3 · getClip() Path Generation', Icons.gesture),
      _scInfoCard(
        'Path from ShapeBorder',
        'getClip(Size size) constructs a Rect from Offset.zero & size, then '
            'calls shape.getOuterPath(rect, textDirection: textDirection). The '
            'returned Path is used directly as the clip region.',
        Icons.timeline,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Implementation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _scTextDark)),
            SizedBox(height: 8),
            _scCode('Path getClip(Size size) {'),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode('final rect = Offset.zero & size;'),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode('return shape.getOuterPath('),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: _scCode('rect,'),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: _scCode('textDirection: textDirection,'),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode(');'),
            ),
            SizedBox(height: 2),
            _scCode('}'),
          ],
        ),
      ),
      SizedBox(height: 8),
      _scInfoCard(
        'TextDirection parameter',
        'Some borders (like those with directional corner radii) need '
            'textDirection to resolve start/end corners properly. '
            'ShapeBorderClipper accepts an optional textDirection in its '
            'constructor.',
        Icons.format_textdirection_l_to_r,
        accent: _scOrange,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Shape Visualisation Gallery
// ---------------------------------------------------------------------------
Widget _scSection4Gallery() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('4 · Shape Clip Gallery', Icons.grid_view),
      _scInfoCard(
        'Visual clip results',
        'Each ShapeBorder produces a distinct clip path. Below are previews '
            'of how different borders clip a rectangular area.',
        Icons.photo_library,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _scShapeCard(
                  'Rounded\nRect',
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: _scPrimary, width: 2),
                  ),
                  _scPrimary,
                ),
                _scShapeCard(
                  'Circle',
                  CircleBorder(side: BorderSide(color: _scAccentDark, width: 2)),
                  _scAccentDark,
                ),
                _scShapeCard(
                  'Stadium',
                  StadiumBorder(side: BorderSide(color: _scGreen, width: 2)),
                  _scGreen,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _scShapeCard(
                  'Beveled',
                  BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: _scOrange, width: 2),
                  ),
                  _scOrange,
                ),
                _scShapeCard(
                  'Continuous\n(Squircle)',
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: _scPurple, width: 2),
                  ),
                  _scPurple,
                ),
                _scShapeCard(
                  'Star',
                  StarBorder(
                    side: BorderSide(color: _scPink, width: 2),
                    points: 5,
                  ),
                  _scPink,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Clipper vs Manual Clipping
// ---------------------------------------------------------------------------
Widget _scSection5Comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('5 · ShapeBorderClipper vs Manual Clipping', Icons.compare),
      _scInfoCard(
        'Why use ShapeBorderClipper?',
        'Instead of manually building a Path in a custom clipper, you can '
            'leverage any existing ShapeBorder\'s getOuterPath(). This reduces '
            'code duplication and ensures the clip matches the visual border.',
        Icons.auto_fix_high,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _scSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _scGreen.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 14, color: _scGreen),
                        SizedBox(width: 4),
                        Text('ShapeBorderClipper', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _scGreen)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text('• Reuses ShapeBorder', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• No manual path code', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• Border-consistent clip', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• TextDirection aware', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• shouldReclip built in', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _scSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _scOrange.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.build_circle, size: 14, color: _scOrange),
                        SizedBox(width: 4),
                        Text('Manual clipper', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _scOrange)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text('• Full path control', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• Custom animations', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• Complex shapes', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• Animated transitions', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                    Text('• More boilerplate', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: ClipPath Integration
// ---------------------------------------------------------------------------
Widget _scSection6ClipPath() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('6 · ClipPath & PhysicalShape Integration', Icons.layers),
      _scInfoCard(
        'ClipPath usage',
        'ClipPath accepts a CustomClipper<Path>. By passing a ShapeBorderClipper, '
            'you clip the child widget to the border shape without needing to '
            'write any path code.',
        Icons.crop,
      ),
      _scInfoCard(
        'PhysicalShape usage',
        'PhysicalShape also accepts a CustomClipper<Path>. In addition to '
            'clipping, it renders elevation shadows that follow the clip shape. '
            'ShapeBorderClipper is the recommended clipper for PhysicalShape.',
        Icons.filter_none,
        accent: _scAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usage pattern', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _scTextDark)),
            SizedBox(height: 8),
            _scCode('ClipPath('),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode('clipper: ShapeBorderClipper('),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: _scCode('shape: RoundedRectangleBorder('),
            ),
            Padding(
              padding: EdgeInsets.only(left: 48),
              child: _scCode('borderRadius: BorderRadius.circular(16),'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: _scCode('),'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode('),'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _scCode('child: Image(...),'),
            ),
            _scCode(')'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: TextDirection Sensitivity
// ---------------------------------------------------------------------------
Widget _scSection7TextDir() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('7 · TextDirection Sensitivity', Icons.format_textdirection_r_to_l),
      _scInfoCard(
        'Directional borders',
        'Some ShapeBorder subclasses define corners using start/end rather '
            'than left/right. For example, BorderRadiusDirectional uses topStart '
            'and topEnd. ShapeBorderClipper passes textDirection to getOuterPath() '
            'so directional corners resolve correctly.',
        Icons.swap_horiz,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _scSurface,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomEnd: Radius.circular(20),
                      ).resolve(TextDirection.ltr),
                      border: Border.all(color: _scPrimary.withValues(alpha: 0.3)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('LTR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _scPrimary)),
                        Text('topStart = topLeft', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _scSurface,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        bottomEnd: Radius.circular(20),
                      ).resolve(TextDirection.rtl),
                      border: Border.all(color: _scAccentDark.withValues(alpha: 0.3)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('RTL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _scAccentDark)),
                        Text('topStart = topRight', style: TextStyle(fontSize: 10, color: _scTextMedium)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Same directional border produces mirrored clips based on textDirection',
              style: TextStyle(fontSize: 11, color: _scTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: shouldReclip & Performance
// ---------------------------------------------------------------------------
Widget _scSection8Performance() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('8 · shouldReclip & Performance', Icons.speed),
      _scInfoCard(
        'shouldReclip()',
        'Returns true only when the old clipper\'s shape or textDirection '
            'differs from the new one. This prevents unnecessary path '
            'recalculation when the widget rebuilds with identical parameters.',
        Icons.compare_arrows,
      ),
      _scInfoCard(
        'Path caching',
        'The rendering engine caches the clip path returned by getClip(). '
            'shouldReclip() false means the cached path is reused. Only when '
            'the shape actually changes does the framework call getClip() again.',
        Icons.cached,
        accent: _scGreen,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance tips', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _scTextDark)),
            SizedBox(height: 8),
            _scPerfTip(Icons.check_circle, _scGreen, 'Use const ShapeBorder when possible'),
            _scPerfTip(Icons.check_circle, _scGreen, 'Avoid rebuilding clipper on every frame'),
            _scPerfTip(Icons.check_circle, _scGreen, 'Prefer ClipRect over ClipPath for rectangles'),
            _scPerfTip(Icons.warning, _scOrange, 'Complex paths increase rasterisation cost'),
            _scPerfTip(Icons.warning, _scOrange, 'Anti-aliased clip paths use more GPU time'),
          ],
        ),
      ),
    ],
  );
}

Widget _scPerfTip(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: _scTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: Advanced Patterns & Custom Shapes
// ---------------------------------------------------------------------------
Widget _scSection9Advanced() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _scSectionTitle('9 · Advanced Patterns', Icons.auto_awesome),
      _scInfoCard(
        'Custom ShapeBorder for clipping',
        'You can create a custom ShapeBorder subclass that produces any Path '
            'you like (wave, zigzag, organic curves). Wrapping it in '
            'ShapeBorderClipper gives you a reusable clipper that works with '
            'ClipPath and PhysicalShape.',
        Icons.architecture,
      ),
      _scInfoCard(
        'Animated shape transitions',
        'By lerping between two ShapeBorder instances (via ShapeBorder.lerp), '
            'you can animate the clip path. Wrap the transition in a '
            'ShapeBorderClipper that updates each frame.',
        Icons.animation,
        accent: _scPurple,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lerp examples', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _scTextDark)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: ShapeDecoration(
                        color: _scPrimary.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: _scPrimary, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('t=0.0', style: TextStyle(fontSize: 9, color: _scGrey)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: ShapeDecoration(
                        color: _scAccentDark.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: _scAccentDark, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('t=0.25', style: TextStyle(fontSize: 9, color: _scGrey)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: ShapeDecoration(
                        color: _scGreen.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: _scGreen, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('t=0.5', style: TextStyle(fontSize: 9, color: _scGrey)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: ShapeDecoration(
                        color: _scPink.withValues(alpha: 0.15),
                        shape: CircleBorder(side: BorderSide(color: _scPink, width: 1.5)),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('t=1.0', style: TextStyle(fontSize: 9, color: _scGrey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Interpolating from rectangle → circle via ShapeBorder.lerp',
              style: TextStyle(fontSize: 10, color: _scTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_scPrimary.withValues(alpha: 0.08), _scAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _scPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.crop, size: 32, color: _scPrimary),
            SizedBox(height: 8),
            Text(
              'ShapeBorderClipper',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _scTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'A CustomClipper<Path> that delegates path generation to any '
              'ShapeBorder, enabling easy widget clipping to rounded rectangles, '
              'circles, stadiums, and custom shapes.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _scTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_scPrimary, _scPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.crop, color: _scOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ShapeBorderClipper',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _scOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Shape-driven custom clipper for ClipPath and PhysicalShape',
                style: TextStyle(fontSize: 12, color: _scOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _scSection1Overview(),
        _scSection2Hierarchy(),
        _scSection3GetClip(),
        _scSection4Gallery(),
        _scSection5Comparison(),
        _scSection6ClipPath(),
        _scSection7TextDir(),
        _scSection8Performance(),
        _scSection9Advanced(),

        SizedBox(height: 24),
      ],
    ),
  );
}
