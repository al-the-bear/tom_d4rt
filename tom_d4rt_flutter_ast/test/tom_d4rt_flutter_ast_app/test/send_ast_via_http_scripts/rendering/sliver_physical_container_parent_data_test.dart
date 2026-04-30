// ignore_for_file: avoid_print
// Deep demo: SliverPhysicalContainerParentData
// Explores the parent-data class that uses physical (AxisDirection-aware)
// offsets AND provides a linked list for multiple children. Used by slivers
// that physically position box children with paint transforms.
import 'package:flutter/material.dart';

// ─── palette: Burnt Orange / Peach ────────────────────────────────
const Color _pcOrange = Color(0xFFBF360C);
const Color _pcPeach = Color(0xFFFBE9E7);
const Color _pcAccent = Color(0xFFFF7043);
const Color _pcDark = Color(0xFF212121);
const Color _pcMuted = Color(0xFF9E9E9E);
const Color _pcGood = Color(0xFF2E7D32);

// ─── text helpers ─────────────────────────────────────────────────
Widget _pcTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _pcOrange,
              letterSpacing: 0.3)),
    );

Widget _pcSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _pcAccent)),
    );

Widget _pcBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _pcCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _pcDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFFFCC80),
              height: 1.5)),
    );

Widget _pcNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _pcPeach,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _pcOrange.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _pcOrange),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _pcOrange, height: 1.4)),
          ),
        ],
      ),
    );

Widget _pcDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _pcOrange.withValues(alpha: 0.12)),
    );

Widget _pcBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _pcAccent, shape: BoxShape.circle),
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

Widget _pcTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _pcLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _pcOrange,
        letterSpacing: 0.2));

Widget _pcSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual building blocks ───────────────────────────────────────

/// A box representing a child in a sliver with an offset label.
Widget _pcChildWithOffset(String name, String offset, Color c,
    {bool active = true}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: active ? c : c.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
          color: active ? c : _pcMuted, width: active ? 1.5 : 1),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : Colors.black54)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: active
                ? Colors.white.withValues(alpha: 0.25)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(offset,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : Colors.black54)),
        ),
      ],
    ),
  );
}

/// A linked-list arrow between children.
Widget _pcLinkArrow() => const Padding(
      padding: EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Icon(Icons.arrow_downward, size: 14, color: _pcAccent),
          SizedBox(width: 4),
          Text('nextSibling',
              style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: _pcAccent)),
        ],
      ),
    );

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _pcBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_pcOrange, Color(0xFFD84315)],
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
          const Icon(Icons.view_in_ar, size: 48, color: _pcPeach),
          const SizedBox(height: 10),
          const Text('SliverPhysicalContainerParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Physical offsets + linked-list container for sliver children',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _pcTag('rendering', _pcAccent),
              _pcTag('parent-data', _pcGood),
              _pcTag('physical offset', _pcDark),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _pcWhatIs() => [
      _pcTitle('§2  What Is SliverPhysicalContainerParentData?'),
      _pcBody(
          'SliverPhysicalContainerParentData is a parent data class that '
          'combines two capabilities:'),
      _pcBullet('Physical positioning',
          'It stores a paintOffset that is applied as a paint transform '
          '(not just a layout offset). This offset respects the physical '
          'AxisDirection of the viewport.'),
      _pcBullet('Container linked list',
          'Via ContainerParentDataMixin, it gives each child previousSibling '
          'and nextSibling pointers for efficient traversal.'),
      _pcCode(
          'class SliverPhysicalContainerParentData\n'
          '    extends SliverPhysicalParentData\n'
          '    with ContainerParentDataMixin<RenderBox> {\n'
          '  // Inherits: Offset paintOffset (from SliverPhysicalParentData)\n'
          '  // Mixes in: RenderBox? previousSibling, nextSibling\n'
          '}'),
      _pcNote(
          'This class is used by slivers that have multiple box children '
          'AND need to position them using paint transforms rather than '
          'scroll-relative offsets.'),
    ];

// ─── §3 Physical vs Logical ──────────────────────────────────────
List<Widget> _pcPhysicalVsLogical() => [
      _pcDivider(),
      _pcTitle('§3  Physical vs Logical Parent Data'),
      _pcBody(
          'Flutter slivers come in two flavors of parent data: physical '
          'and logical. The distinction is about HOW the offset is applied '
          'during painting.'),
      _pcSubtitle('Physical (this class)'),
      _pcBody(
          'The paintOffset is applied via applyPaintTransform as a direct '
          'translation. This means the offset is in the coordinate system '
          'of the viewport, not the sliver. It respects AxisDirection.'),
      _pcSubtitle('Logical'),
      _pcBody(
          'The paintOffset is a logical offset that the sliver itself '
          'interprets based on its growth direction. The sliver computes '
          'the final paint position from this logical offset.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _pcSideCard('Physical', [
                    'applyPaintTransform uses offset',
                    'Direct viewport coordinates',
                    'AxisDirection-aware',
                    'Used by: SliverToBoxAdapter',
                  ], _pcOrange),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _pcSideCard('Logical', [
                    'Sliver interprets offset',
                    'Relative to sliver layout',
                    'GrowthDirection-aware',
                    'Used by: SliverList, SliverGrid',
                  ], const Color(0xFF1A237E)),
                ),
              ],
            ),
          ],
        ),
      ),
      _pcNote(
          'When you hear "physical," think: the offset goes directly into '
          'the paint transform matrix. When you hear "logical," think: '
          'the sliver does extra math to figure out where to paint.'),
    ];

Widget _pcSideCard(String title, List<String> items, Color c) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: c)),
          const SizedBox(height: 6),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 5, right: 6),
                      decoration:
                          BoxDecoration(color: c, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 10.5, color: Colors.black87)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );

// ─── §4 Inheritance hierarchy ────────────────────────────────────
List<Widget> _pcHierarchy() => [
      _pcDivider(),
      _pcTitle('§4  Inheritance Hierarchy'),
      _pcBody(
          'SliverPhysicalContainerParentData sits at the end of a hierarchy '
          'that adds capabilities at each level:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pcHierLevel(0, 'ParentData', 'Empty base — detach()'),
            _pcHierLevel(1, 'BoxParentData', '+ Offset offset'),
            _pcHierLevel(
                2, 'SliverPhysicalParentData', '+ Offset paintOffset'),
            _pcHierLevel(
                3,
                'SliverPhysicalContainerParentData',
                '+ ContainerParentDataMixin (linked list)'),
          ],
        ),
      ),
      _pcBody(
          'Compared to the logical branch (SliverLogicalParentData → '
          'SliverLogicalContainerParentData → '
          'SliverMultiBoxAdaptorParentData), the physical branch has the '
          'same structure but with physical semantics for the paintOffset.'),
      _pcSubtitle('What each level adds'),
      _pcBullet('ParentData', 'Base lifecycle (detach)'),
      _pcBullet('BoxParentData', 'The box offset for box-protocol layout'),
      _pcBullet('SliverPhysicalParentData',
          'A paintOffset used in applyPaintTransform'),
      _pcBullet('SliverPhysicalContainerParentData',
          'previousSibling/nextSibling pointers for multi-child traversal'),
    ];

Widget _pcHierLevel(int depth, String name, String desc) {
  final indent = depth * 22.0;
  return Padding(
    padding: EdgeInsets.only(left: indent, top: 4, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (depth > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6, top: 4),
            child: Container(
              width: 8,
              height: 2,
              color: _pcAccent.withValues(alpha: 0.5),
            ),
          ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 3, right: 8),
          decoration: BoxDecoration(
            color: depth == 3
                ? _pcOrange
                : _pcAccent.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          depth == 3 ? FontWeight.w800 : FontWeight.w600,
                      fontFamily: 'monospace',
                      color: depth == 3 ? _pcOrange : Colors.black87)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §5 The paintOffset transform ────────────────────────────────
List<Widget> _pcPaintOffset() => [
      _pcDivider(),
      _pcTitle('§5  The paintOffset Transform'),
      _pcBody(
          'The paintOffset in SliverPhysicalParentData (inherited by this '
          'class) is used in applyPaintTransform to convert from the child '
          'coordinate space to the sliver coordinate space.'),
      _pcCode(
          '// In RenderSliver (physical variant):\n'
          '@override\n'
          'void applyPaintTransform(RenderBox child, Matrix4 transform) {\n'
          '  final pd = child.parentData!\n'
          '      as SliverPhysicalParentData;\n'
          '  transform.translate(pd.paintOffset.dx, pd.paintOffset.dy);\n'
          '}'),
      _pcBody(
          'This is different from logical parent data where the sliver '
          'computes the transform itself based on axis direction and '
          'growth direction.'),
      _pcSubtitle('Visual: paint transform application'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pcLabel('Child in sliver coordinate space'),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Center(
                    child: Text('origin\n(0,0)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            fontFamily: 'monospace',
                            color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18, color: _pcAccent),
                const SizedBox(width: 8),
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _pcOrange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text('child\nat offset',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('paintOffset: (120, 48)',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                              color: _pcOrange)),
                      const Text('transform.translate(120, 48)',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      _pcNote(
          'Physical offsets are in screen coordinates (viewport-relative). '
          'The sliver does not need to account for AxisDirection — the '
          'offset already points in the right direction.'),
    ];

// ─── §6 applyPaintTransform in detail ────────────────────────────
List<Widget> _pcApplyPaintTransform() => [
      _pcDivider(),
      _pcTitle('§6  applyPaintTransform in Detail'),
      _pcBody(
          'The key difference between physical and logical parent data is '
          'how applyPaintTransform works:'),
      _pcSubtitle('Physical applyPaintTransform'),
      _pcCode(
          '// Simple — direct translation\n'
          'void applyPaintTransform(RenderBox child, Matrix4 transform) {\n'
          '  final pd = child.parentData\n'
          '      as SliverPhysicalParentData;\n'
          '  transform.translate(pd.paintOffset.dx, pd.paintOffset.dy);\n'
          '}'),
      _pcSubtitle('Logical applyPaintTransform'),
      _pcCode(
          '// Complex — must account for axis and growth direction\n'
          'void applyPaintTransform(RenderBox child, Matrix4 transform) {\n'
          '  final pd = child.parentData\n'
          '      as SliverLogicalParentData;\n'
          '  // Convert logical offset to physical based on:\n'
          '  // - constraints.axis (horizontal/vertical)\n'
          '  // - constraints.growthDirection (forward/reverse)\n'
          '  // - constraints.axisDirection (up/down/left/right)\n'
          '  final physicalOffset = computeAbsolutePaintOffset(\n'
          '    child, pd.layoutOffset!, constraints.axisDirection,\n'
          '    constraints.growthDirection);\n'
          '  transform.translate(physicalOffset.dx, physicalOffset.dy);\n'
          '}'),
      _pcBody(
          'The physical version is simpler because the sliver already '
          'computed the physical offset during layout. The logical version '
          'defers that computation to paint time.'),
      _pcSubtitle('When does the sliver set the physical offset?'),
      _pcCode(
          '// During performLayout:\n'
          'final pd = child.parentData!\n'
          '    as SliverPhysicalParentData;\n'
          '// Already in viewport coordinates\n'
          'pd.paintOffset = Offset(\n'
          '  childCrossAxisPosition,\n'
          '  childMainAxisPosition - constraints.scrollOffset,\n'
          ');'),
    ];

// ─── §7 ContainerParentDataMixin — linked list ──────────────────
List<Widget> _pcLinkedList() => [
      _pcDivider(),
      _pcTitle('§7  ContainerParentDataMixin — Linked List'),
      _pcBody(
          'The "Container" part of SliverPhysicalContainerParentData comes '
          'from ContainerParentDataMixin<RenderBox>. This adds two pointers '
          'to each child that form a doubly-linked list:'),
      _pcCode(
          'mixin ContainerParentDataMixin<ChildType extends RenderObject>\n'
          '    on ParentData {\n'
          '  ChildType? previousSibling;\n'
          '  ChildType? nextSibling;\n'
          '}'),
      _pcSubtitle('Linked list visual'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pcLabel('Three children in a physical container sliver'),
            const SizedBox(height: 10),
            _pcChildWithOffset('Child A (firstChild)',
                'paintOffset: (0, 0)', _pcOrange),
            _pcLinkArrow(),
            _pcChildWithOffset('Child B',
                'paintOffset: (0, 48)', _pcAccent),
            _pcLinkArrow(),
            _pcChildWithOffset('Child C (lastChild)',
                'paintOffset: (0, 96)', _pcGood),
          ],
        ),
      ),
      _pcBody(
          'The sliver render object can iterate children via firstChild → '
          'nextSibling → nextSibling, or in reverse via lastChild → '
          'previousSibling → previousSibling.'),
      _pcCode(
          '// Traversal pattern:\n'
          'RenderBox? child = firstChild;\n'
          'while (child != null) {\n'
          '  final pd = child.parentData!\n'
          '      as SliverPhysicalContainerParentData;\n'
          '  print("Child at \${pd.paintOffset}");\n'
          '  child = pd.nextSibling;  // ← linked list traversal\n'
          '}'),
      _pcNote(
          'Without ContainerParentDataMixin, the sliver would need a separate '
          'data structure (like a List) to track children. The linked list '
          'makes insertion and removal O(1).'),
    ];

// ─── §8 Usage pattern: SliverToBoxAdapter ────────────────────────
List<Widget> _pcUsagePattern() => [
      _pcDivider(),
      _pcTitle('§8  Usage: SliverToBoxAdapter'),
      _pcBody(
          'While SliverToBoxAdapter uses SliverPhysicalParentData (not the '
          'container variant, since it has only one child), it illustrates '
          'how physical parent data is used in practice:'),
      _pcCode(
          'class RenderSliverToBoxAdapter extends RenderSliverSingleBoxAdapter {\n'
          '  @override\n'
          '  void performLayout() {\n'
          '    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);\n'
          '    final pd = child!.parentData! as SliverPhysicalParentData;\n'
          '\n'
          '    // Set physical offset — already in viewport coords\n'
          '    pd.paintOffset = computeChildPaintOffset(child!);\n'
          '\n'
          '    // Report geometry\n'
          '    geometry = SliverGeometry(\n'
          '      scrollExtent: child!.size.height,\n'
          '      paintExtent: paintedChildExtent,\n'
          '      maxPaintExtent: child!.size.height,\n'
          '    );\n'
          '  }\n'
          '}'),
      _pcSubtitle('Why SliverToBoxAdapter uses physical offsets'),
      _pcBody(
          'SliverToBoxAdapter wraps a single box widget inside a sliver. '
          'Because the box does not understand sliver coordinates, the sliver '
          'must convert to physical coordinates immediately during layout. '
          'The box child paints at a direct offset — no further conversion.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _pcFlowStep('1', 'SliverToBoxAdapter.performLayout()',
                'Lays out child box, computes physical offset'),
            _pcFlowStep('2', 'parentData.paintOffset = Offset(x, y)',
                'Physical offset stored directly'),
            _pcFlowStep('3', 'paint() → paintChild(child, offset + pd.paintOffset)',
                'Offset used as-is, no conversion needed'),
          ],
        ),
      ),
    ];

Widget _pcFlowStep(String num, String title, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _pcOrange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                        color: Colors.black87)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §9 Custom sliver with physical children ─────────────────────
List<Widget> _pcCustomSliver() => [
      _pcDivider(),
      _pcTitle('§9  Custom Sliver With Physical Children'),
      _pcBody(
          'If you write a custom sliver that manages multiple box children '
          'AND positions them physically, you would use '
          'SliverPhysicalContainerParentData:'),
      _pcCode(
          'class RenderSliverOverlappingCards\n'
          '    extends RenderSliver\n'
          '    with ContainerRenderObjectMixin<RenderBox,\n'
          '        SliverPhysicalContainerParentData> {\n'
          '\n'
          '  @override\n'
          '  void setupParentData(RenderBox child) {\n'
          '    if (child.parentData\n'
          '        is! SliverPhysicalContainerParentData) {\n'
          '      child.parentData =\n'
          '          SliverPhysicalContainerParentData();\n'
          '    }\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void performLayout() {\n'
          '    double offset = 0;\n'
          '    RenderBox? child = firstChild;\n'
          '    while (child != null) {\n'
          '      child.layout(constraints.asBoxConstraints());\n'
          '      final pd = child.parentData!\n'
          '          as SliverPhysicalContainerParentData;\n'
          '      pd.paintOffset = Offset(0, offset);\n'
          '      offset += child.size.height * 0.8; // overlap\n'
          '      child = pd.nextSibling;\n'
          '    }\n'
          '  }\n'
          '}'),
      _pcSubtitle('Visual: overlapping card layout'),
      Container(
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              top: 80,
              height: 55,
              child: Container(
                decoration: BoxDecoration(
                  color: _pcMuted.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _pcMuted),
                ),
                child: const Center(
                  child: Text('Card C — offset (0, 80)',
                      style: TextStyle(fontSize: 10, color: Colors.black45)),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 40,
              height: 55,
              child: Container(
                decoration: BoxDecoration(
                  color: _pcAccent.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _pcAccent),
                ),
                child: Center(
                  child: Text('Card B — offset (0, 40)',
                      style: TextStyle(fontSize: 10, color: _pcAccent)),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 8,
              height: 55,
              child: Container(
                decoration: BoxDecoration(
                  color: _pcOrange,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x30000000),
                        blurRadius: 4,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: const Center(
                  child: Text('Card A — offset (0, 0)',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
      _pcSmall('Each card has a physical paintOffset; they overlap by 20%'),
    ];

// ─── §10 Comparison with Logical variant ─────────────────────────
List<Widget> _pcCompare() => [
      _pcDivider(),
      _pcTitle('§10  vs SliverLogicalContainerParentData'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _pcPeach,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pcCmpRow('Feature', 'Physical', 'Logical', isHeader: true),
            _pcCmpRow('Offset meaning', 'Viewport coords', 'Relative to sliver'),
            _pcCmpRow('applyPaintTransform', 'Direct translate', 'Axis conversion'),
            _pcCmpRow('AxisDirection handling', 'At layout time', 'At paint time'),
            _pcCmpRow('Linked list', 'Yes', 'Yes'),
            _pcCmpRow('Used by', 'SliverFillViewport', 'SliverList, SliverGrid'),
            _pcCmpRow('Subclass', 'None (leaf)', 'SliverMultiBoxAdaptorPD'),
            _pcCmpRow('Complexity', 'Simpler', 'More versatile'),
          ],
        ),
      ),
      _pcBody(
          'Choose physical parent data when your sliver handles the axis '
          'direction conversion during layout (simpler paint). Choose logical '
          'when the sliver needs to defer axis conversion (more flexible).'),
      _pcNote(
          'Most custom slivers in Flutter use the logical variant. Physical '
          'is more common for slivers that wrap a single box child or use '
          'fixed positioning.'),
    ];

Widget _pcCmpRow(String prop, String phys, String logical,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _pcOrange : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 95, child: Text(prop, style: style)),
        Expanded(child: Text(phys, style: style)),
        Expanded(child: Text(logical, style: style)),
      ],
    ),
  );
}

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _pcSummary() => [
      _pcDivider(),
      _pcTitle('§11  Summary'),
      _pcBody(
          'SliverPhysicalContainerParentData is the physical-offset, '
          'multi-child variant of sliver parent data. It combines direct '
          'paint transforms with efficient linked-list child management.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _pcOrange.withValues(alpha: 0.08),
              _pcPeach,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _pcOrange.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _pcOrange)),
            const SizedBox(height: 10),
            _pcSummaryPt('Physical',
                'paintOffset is in viewport coordinates — directly applied'),
            _pcSummaryPt('Container',
                'Linked list pointers for multi-child slivers'),
            _pcSummaryPt('Inheritance',
                'Extends SliverPhysicalParentData with ContainerParentDataMixin'),
            _pcSummaryPt('Simplicity',
                'Simpler than logical — no axis conversion at paint time'),
            _pcSummaryPt('Usage',
                'Custom slivers with physically-positioned box children'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _pcOrange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of SliverPhysicalContainerParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _pcSummaryPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _pcGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _pcOrange)),
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
        _pcBanner(),
        const SizedBox(height: 20),
        ..._pcWhatIs(),
        ..._pcPhysicalVsLogical(),
        ..._pcHierarchy(),
        ..._pcPaintOffset(),
        ..._pcApplyPaintTransform(),
        ..._pcLinkedList(),
        ..._pcUsagePattern(),
        ..._pcCustomSliver(),
        ..._pcCompare(),
        ..._pcSummary(),
      ],
    ),
  );
}
