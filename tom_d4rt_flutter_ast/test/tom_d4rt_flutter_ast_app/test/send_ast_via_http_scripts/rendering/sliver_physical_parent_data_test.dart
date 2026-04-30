// ignore_for_file: avoid_print
// Deep demo: SliverPhysicalParentData
// Explores the base parent-data class for slivers with physical offsets.
// Covers paintOffset, its relationship to BoxParentData.offset, and
// how it is used by single-child slivers like SliverToBoxAdapter.
import 'package:flutter/material.dart';

// ─── palette: Indigo / Light Indigo ───────────────────────────────
const Color _spIndigo = Color(0xFF283593);
const Color _spLightIndigo = Color(0xFFE8EAF6);
const Color _spAccent = Color(0xFF5C6BC0);
const Color _spDark = Color(0xFF1A1A2E);
const Color _spGood = Color(0xFF43A047);
const Color _spWarn = Color(0xFFEF6C00);

// ─── text helpers ─────────────────────────────────────────────────
Widget _spTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _spIndigo,
              letterSpacing: 0.3)),
    );

Widget _spSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _spAccent)),
    );

Widget _spBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _spCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _spDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFF82B1FF),
              height: 1.5)),
    );

Widget _spNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _spLightIndigo,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _spIndigo.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _spIndigo),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _spIndigo, height: 1.4)),
          ),
        ],
      ),
    );

Widget _spDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _spIndigo.withValues(alpha: 0.12)),
    );

Widget _spBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _spAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _spTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _spLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _spIndigo,
        letterSpacing: 0.2));

Widget _spSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _spBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_spIndigo, Color(0xFF3949AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.gps_fixed, size: 48, color: _spLightIndigo),
          const SizedBox(height: 10),
          const Text('SliverPhysicalParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Physical paintOffset for single-child slivers',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _spTag('rendering', _spAccent),
              _spTag('parent-data', _spGood),
              _spTag('physical offset', _spWarn),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _spWhatIs() => [
      _spTitle('§2  What Is SliverPhysicalParentData?'),
      _spBody(
          'SliverPhysicalParentData is a simple parent data class that '
          'extends BoxParentData with a single additional field: '
          'paintOffset. This offset is in physical (viewport) coordinates '
          'and is used directly by applyPaintTransform to position the '
          'child in the sliver.'),
      _spCode(
          'class SliverPhysicalParentData extends BoxParentData {\n'
          '  /// The offset to use when painting the child.\n'
          '  /// This is in the coordinate system of the viewport,\n'
          '  /// not the sliver.\n'
          '  Offset paintOffset = Offset.zero;\n'
          '\n'
          '  @override\n'
          '  String toString() => \'paintOffset=\$paintOffset\';\n'
          '}'),
      _spBody(
          'This is the simplest sliver parent data. It stores one offset '
          'that tells the sliver exactly where to paint the child in '
          'screen coordinates.'),
      _spNote(
          'SliverPhysicalParentData is the base of the "physical" branch '
          'of sliver parent data classes. SliverPhysicalContainerParentData '
          'extends it to add linked-list pointers.'),
    ];

// ─── §3 Class definition and fields ─────────────────────────────
List<Widget> _spClassDef() => [
      _spDivider(),
      _spTitle('§3  Class Fields'),
      _spBody('The class has exactly one field of its own. Combined with '
          'the inherited BoxParentData.offset, each child has two offsets:'),
      _spSubtitle('Inherited from BoxParentData'),
      _spBullet('offset', 'Offset — used by the box protocol for layout '
          'positioning (e.g., in a Stack). Rarely used in slivers.'),
      _spSubtitle('Own field'),
      _spBullet('paintOffset', 'Offset — the physical paint position in '
          'viewport coordinates. Used by applyPaintTransform.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _spFieldRow('Field', 'Source', 'Purpose', isHeader: true),
            _spFieldRow('offset', 'BoxParentData', 'Box layout positioning'),
            _spFieldRow(
                'paintOffset', 'SliverPhysicalParentData', 'Sliver paint transform'),
          ],
        ),
      ),
      _spNote(
          'In most sliver usage, BoxParentData.offset is Offset.zero. '
          'The sliver uses paintOffset exclusively for positioning.'),
    ];

Widget _spFieldRow(String field, String source, String purpose,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _spIndigo : Colors.black87,
    fontFamily: isHeader ? null : 'monospace',
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 80, child: Text(field, style: style)),
        Expanded(
            child: Text(source,
                style: style.copyWith(fontFamily: null))),
        Expanded(child: Text(purpose, style: style.copyWith(fontFamily: null))),
      ],
    ),
  );
}

// ─── §4 offset vs paintOffset ────────────────────────────────────
List<Widget> _spOffsetVsPaintOffset() => [
      _spDivider(),
      _spTitle('§4  offset vs paintOffset'),
      _spBody(
          'Having two offsets can be confusing. Here is when each is used:'),
      _spSubtitle('BoxParentData.offset (inherited)'),
      _spBody(
          'This offset is used by the standard box layout protocol. In a '
          'Stack or CustomMultiChildLayout, the parent sets child.offset '
          'to position it. In slivers, this offset is rarely set because '
          'slivers use their own positioning mechanism.'),
      _spSubtitle('SliverPhysicalParentData.paintOffset'),
      _spBody(
          'This offset is set by the sliver during performLayout and used '
          'by applyPaintTransform to translate the child to its correct '
          'position in the viewport coordinate space.'),
      _spSubtitle('Visual comparison'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _spLabel('Box layout (offset)'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20,
                          top: 20,
                          child: Container(
                            width: 50,
                            height: 35,
                            decoration: BoxDecoration(
                              color: _spAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text('child',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white)),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 2,
                          top: 2,
                          child: Text('(0,0)',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'monospace',
                                  color: Colors.black38)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  _spSmall('offset = (20, 20)'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  _spLabel('Sliver paint (paintOffset)'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _spIndigo.withValues(alpha: 0.3)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 15,
                          right: 0,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _spIndigo,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text('child',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.white)),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 2,
                          top: 2,
                          child: Text('sliver',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'monospace',
                                  color: Colors.black38)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  _spSmall('paintOffset = (0, 15)'),
                ],
              ),
            ),
          ],
        ),
      ),
      _spCode(
          '// The sliver uses paintOffset, NOT offset:\n'
          '@override\n'
          'void applyPaintTransform(RenderBox child, Matrix4 transform) {\n'
          '  final SliverPhysicalParentData pd =\n'
          '      child.parentData! as SliverPhysicalParentData;\n'
          '  // Uses paintOffset, ignores offset\n'
          '  transform.translate(pd.paintOffset.dx, pd.paintOffset.dy);\n'
          '}'),
    ];

// ─── §5 How paintOffset differs from logical ────────────────────
List<Widget> _spVsLogical() => [
      _spDivider(),
      _spTitle('§5  Physical vs Logical Offset'),
      _spBody(
          'In the physical parent data, paintOffset is already in viewport '
          'coordinates. In the logical variant (SliverLogicalParentData), '
          'layoutOffset is relative to the sliver and must be converted.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spLabel('Physical: direct path to screen'),
            const SizedBox(height: 8),
            _spPathStep('performLayout()', 'Computes viewport coords', _spIndigo),
            _spPathArrow(),
            _spPathStep('pd.paintOffset = Offset(x, y)',
                'Physical offset stored', _spIndigo),
            _spPathArrow(),
            _spPathStep('applyPaintTransform()',
                'Direct translate — done!', _spGood),
            const SizedBox(height: 16),
            _spLabel('Logical: needs conversion'),
            const SizedBox(height: 8),
            _spPathStep('performLayout()', 'Computes relative offset', _spAccent),
            _spPathArrow(),
            _spPathStep('pd.layoutOffset = mainAxisPos',
                'Logical offset stored', _spAccent),
            _spPathArrow(),
            _spPathStep('applyPaintTransform()',
                'Must convert: axis + growth direction', _spWarn),
            _spPathArrow(),
            _spPathStep('computeAbsolutePaintOffset()',
                'Finally get physical coords', _spGood),
          ],
        ),
      ),
      _spBody(
          'Physical is simpler but less flexible. Logical supports bidirectional '
          'scrolling and reverse growth more naturally.'),
    ];

Widget _spPathStep(String title, String desc, Color c) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                        color: Colors.black87)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

Widget _spPathArrow() => const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Icon(Icons.arrow_downward, size: 14, color: _spAccent),
    );

// ─── §6 Where paintOffset is set ─────────────────────────────────
List<Widget> _spWhereSet() => [
      _spDivider(),
      _spTitle('§6  Where paintOffset Is Set'),
      _spBody(
          'The paintOffset is always set during performLayout, after the '
          'child is laid out. The sliver computes the physical position '
          'based on scroll offset and axis direction.'),
      _spCode(
          '// Example from RenderSliverToBoxAdapter:\n'
          '@override\n'
          'void performLayout() {\n'
          '  if (child == null) { geometry = SliverGeometry.zero; return; }\n'
          '\n'
          '  child!.layout(\n'
          '    constraints.asBoxConstraints(),\n'
          '    parentUsesSize: true,\n'
          '  );\n'
          '\n'
          '  final double childExtent;\n'
          '  switch (constraints.axis) {\n'
          '    case Axis.horizontal:\n'
          '      childExtent = child!.size.width;\n'
          '    case Axis.vertical:\n'
          '      childExtent = child!.size.height;\n'
          '  }\n'
          '\n'
          '  final pd = child!.parentData!\n'
          '      as SliverPhysicalParentData;\n'
          '\n'
          '  // Physical offset computation:\n'
          '  pd.paintOffset = _computePaintOffset(\n'
          '    constraints, childExtent,\n'
          '  );\n'
          '}'),
      _spSubtitle('Offset depends on AxisDirection'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spAxisRow('AxisDirection.down', 'Offset(0, mainAxisPos)', _spIndigo),
            _spAxisRow('AxisDirection.up', 'Offset(0, height - mainAxisPos)', _spAccent),
            _spAxisRow(
                'AxisDirection.right', 'Offset(mainAxisPos, 0)', _spGood),
            _spAxisRow(
                'AxisDirection.left', 'Offset(width - mainAxisPos, 0)', _spWarn),
          ],
        ),
      ),
      _spNote(
          'This is the key advantage of physical parent data: the sliver '
          'handles AxisDirection once during layout and never again during '
          'painting.'),
    ];

Widget _spAxisRow(String axis, String offset, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(axis,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                    color: Colors.black87)),
          ),
          Text(offset,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: c,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );

// ─── §7 Visual: single child with physical offset ────────────────
List<Widget> _spVisualSingle() => [
      _spDivider(),
      _spTitle('§7  Visual: Single Child Positioning'),
      _spBody(
          'For a SliverToBoxAdapter with a 200px tall child in a vertically '
          'scrolling viewport:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _spLabel('Viewport (AxisDirection.down)'),
            const SizedBox(height: 10),
            _spVisualRow('scrollOffset = 0', 0, 200),
            const SizedBox(height: 12),
            _spVisualRow('scrollOffset = 80', -80, 200),
            const SizedBox(height: 12),
            _spVisualRow('scrollOffset = 200', -200, 200),
          ],
        ),
      ),
      _spBody(
          'As the user scrolls down, the paintOffset.dy decreases '
          '(moves the child upward). When fully scrolled past, the child '
          'is above the viewport and not painted.'),
      _spCode(
          '// paintOffset calculation for vertical down:\n'
          'final remaining = childExtent - constraints.scrollOffset;\n'
          'pd.paintOffset = Offset(\n'
          '  0.0,\n'
          '  -constraints.scrollOffset + constraints.overlap,\n'
          ');'),
    ];

Widget _spVisualRow(String label, double offset, double height) {
  final top = (offset / 3.0).clamp(-30.0, 100.0) + 5;
  final visible = offset >= -height && offset < 120;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _spSmall(label),
      const SizedBox(height: 4),
      SizedBox(
        height: 60,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Viewport frame
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: _spIndigo.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            // Child box at offset
            Positioned(
              left: 4,
              right: 4,
              top: top,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: visible
                      ? _spIndigo
                      : _spAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                      'paintOffset: (0, ${offset.toInt()})',
                      style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                          color: visible ? Colors.white : Colors.black38)),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─── §8 AxisDirection and orientation ─────────────────────────────
List<Widget> _spAxisDirection() => [
      _spDivider(),
      _spTitle('§8  AxisDirection and Offset Orientation'),
      _spBody(
          'The paintOffset adapts to the viewport AxisDirection. '
          'Here is how the same child at main-axis position 100 would look:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _spDirectionCard('AxisDirection.down', 'Offset(0, 100)',
                Icons.arrow_downward, _spIndigo),
            _spDirectionCard('AxisDirection.up', 'Offset(0, viewportH - 100)',
                Icons.arrow_upward, _spAccent),
            _spDirectionCard('AxisDirection.right', 'Offset(100, 0)',
                Icons.arrow_forward, _spGood),
            _spDirectionCard('AxisDirection.left', 'Offset(viewportW - 100, 0)',
                Icons.arrow_back, _spWarn),
          ],
        ),
      ),
      _spBody(
          'The sliver converts the main-axis and cross-axis positions to '
          'an (x, y) offset based on axis direction. This conversion happens '
          'once during layout, not during each paint call.'),
      _spNote(
          'This is what makes physical parent data "physical" — the offset '
          'is already in the final coordinate system. No further axis '
          'reasoning is needed.'),
    ];

Widget _spDirectionCard(
    String direction, String offset, IconData icon, Color c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: c),
          const SizedBox(width: 8),
          Expanded(
            child: Text(direction,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                    color: Colors.black87)),
          ),
          Text(offset,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: c)),
        ],
      ),
    ),
  );
}

// ─── §9 Who uses this class ─────────────────────────────────────
List<Widget> _spUsers() => [
      _spDivider(),
      _spTitle('§9  Who Uses SliverPhysicalParentData?'),
      _spBody(
          'Several built-in slivers use the physical parent data variant:'),
      _spSubtitle('Direct users'),
      _spBullet('RenderSliverToBoxAdapter',
          'Single-child sliver wrapping a box widget'),
      _spBullet('RenderSliverFillViewport',
          'Makes each child fill the viewport (extends physical container)'),
      _spBullet('RenderSliverFillRemaining',
          'Fills remaining space in the viewport'),
      _spSubtitle('Indirect users (via container variant)'),
      _spBullet('RenderSliverFixedExtentList',
          'All children have same extent (extends container)'),
      _spBody(
          'The non-container variant (this class) is primarily used by '
          'single-child slivers. Multi-child slivers use the container '
          'variant (SliverPhysicalContainerParentData) for linked-list '
          'traversal.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _spLightIndigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spLabel('Physical parent data family'),
            const SizedBox(height: 8),
            _spFamilyRow('SliverPhysicalParentData',
                'Base — single child', _spIndigo, true),
            _spFamilyRow('SliverPhysicalContainerParentData',
                'Extended — multi-child', _spAccent, false),
          ],
        ),
      ),
    ];

Widget _spFamilyRow(String name, String desc, Color c, bool isBase) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c,
              shape: isBase ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isBase ? BorderRadius.circular(2) : null,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §10 Summary ────────────────────────────────────────────────
List<Widget> _spSummary() => [
      _spDivider(),
      _spTitle('§10  Summary'),
      _spBody(
          'SliverPhysicalParentData is the foundation of physical sliver '
          'positioning — a single paintOffset that goes directly into the '
          'paint transform without further conversion.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _spIndigo.withValues(alpha: 0.08),
              _spLightIndigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _spIndigo.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _spIndigo)),
            const SizedBox(height: 10),
            _spSummPt('paintOffset',
                'Physical offset in viewport coordinates'),
            _spSummPt('Simple',
                'One extra field over BoxParentData'),
            _spSummPt('Direct transform',
                'applyPaintTransform uses offset as-is'),
            _spSummPt('Set at layout',
                'AxisDirection handled once during performLayout'),
            _spSummPt('Base class',
                'Extended by SliverPhysicalContainerParentData'),
            _spSummPt('Single child',
                'Primary use: SliverToBoxAdapter and similar'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _spIndigo,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of SliverPhysicalParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _spSummPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _spGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _spIndigo)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _spBanner(),
        const SizedBox(height: 20),
        ..._spWhatIs(),
        ..._spClassDef(),
        ..._spOffsetVsPaintOffset(),
        ..._spVsLogical(),
        ..._spWhereSet(),
        ..._spVisualSingle(),
        ..._spAxisDirection(),
        ..._spUsers(),
        ..._spSummary(),
      ],
    ),
  );
}
