// ignore_for_file: avoid_print
// Deep demo: SliverMultiBoxAdaptorParentData
// Explores the parent-data class used by SliverList, SliverGrid, and
// SliverFixedExtentList — covering the index field, keepAlive mechanism,
// child recycling, garbage collection, and debugging output.
import 'package:flutter/material.dart';

// ─── palette: Deep Purple / Lavender ──────────────────────────────
const Color _mbPurple = Color(0xFF4A148C);
const Color _mbLavender = Color(0xFFF3E5F5);
const Color _mbAccent = Color(0xFF7C4DFF);
const Color _mbMuted = Color(0xFF9E9E9E);
const Color _mbWarn = Color(0xFFFF6D00);
const Color _mbKeep = Color(0xFF00C853);

// ─── text helpers ─────────────────────────────────────────────────
Widget _mbTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _mbPurple,
              letterSpacing: 0.3)),
    );

Widget _mbSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _mbAccent)),
    );

Widget _mbBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _mbCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12, fontFamily: 'monospace', color: Color(0xFFCCFF90), height: 1.5)),
    );

Widget _mbNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _mbLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _mbPurple.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _mbPurple),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(fontSize: 12.5, color: _mbPurple, height: 1.4)),
          ),
        ],
      ),
    );

Widget _mbDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _mbPurple.withValues(alpha: 0.12)),
    );

Widget _mbBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(color: _mbAccent, shape: BoxShape.circle),
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
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _mbLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _mbPurple,
        letterSpacing: 0.2));

Widget _mbSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual building blocks ───────────────────────────────────────

/// A small box representing a child in a sliver.
Widget _mbChildBox(int index, {bool keepAlive = false, bool offScreen = false}) {
  final bg = keepAlive
      ? _mbKeep
      : offScreen
          ? _mbMuted.withValues(alpha: 0.3)
          : _mbPurple;
  final fg = keepAlive || !offScreen ? Colors.white : Colors.black54;
  final border = offScreen && !keepAlive
      ? Border.all(color: _mbMuted, width: 1)
      : Border.all(color: bg, width: 1);
  return Container(
    width: 56,
    height: 42,
    margin: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
      border: border,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('idx $index',
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
        if (keepAlive)
          const Text('KEEP',
              style: TextStyle(fontSize: 7, fontWeight: FontWeight.w800, color: Colors.white)),
        if (offScreen && !keepAlive)
          const Text('GC',
              style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: Colors.black45)),
      ],
    ),
  );
}

/// Horizontal arrow between boxes.
Widget _mbArrow() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Icon(Icons.arrow_forward, size: 14, color: _mbAccent),
    );

/// A labeled colored tag.
Widget _mbTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

/// A single row in a property table.
Widget _mbPropRow(String prop, String val, {Color? valColor}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(prop,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                    color: _mbPurple)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(
                    fontSize: 12,
                    color: valColor ?? Colors.black87,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── section builders ─────────────────────────────────────────────

/// §1 — Title banner
Widget _mbBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_mbPurple, Color(0xFF6A1B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x40000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.view_list_rounded, size: 48, color: _mbLavender),
          const SizedBox(height: 10),
          const Text('SliverMultiBoxAdaptorParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('The parent-data class powering SliverList & SliverGrid',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _mbTag('rendering', _mbAccent),
              _mbTag('parent-data', _mbKeep),
              _mbTag('index + keepAlive', _mbWarn),
            ],
          ),
        ],
      ),
    );

/// §2 — What is SliverMultiBoxAdaptorParentData?
List<Widget> _mbWhatIs() => [
      _mbTitle('§2  What Is SliverMultiBoxAdaptorParentData?'),
      _mbBody(
          'SliverMultiBoxAdaptorParentData is the parent data class attached '
          'to every child of a RenderSliverMultiBoxAdaptor (the render object '
          'behind SliverList, SliverGrid, SliverFixedExtentList, and friends). '
          'It extends SliverLogicalContainerParentData and adds two fields:'),
      _mbCode(
          'class SliverMultiBoxAdaptorParentData\n'
          '    extends SliverLogicalContainerParentData {\n'
          '  int? index;          // delegate position\n'
          '  bool _keptAlive = false; // off-screen but preserved\n'
          '}'),
      _mbBody(
          'Every child in the sliver stores its delegate index in this parent '
          'data so the render object knows which position it represents. '
          'The keepAlive flag allows children to be kept alive in memory even '
          'when scrolled off-screen, preserving widget state.'),
      _mbNote(
          'This is one of the most used parent data classes in Flutter — '
          'every item in a ListView or GridView carries one.'),
    ];

/// §3 — The index field
List<Widget> _mbIndexField() => [
      _mbDivider(),
      _mbTitle('§3  The index Field'),
      _mbBody(
          'The index field stores which position in the child delegate this '
          'child represents. When RenderSliverMultiBoxAdaptor calls '
          'childManager.createChild(index), the newly created child gets '
          'parentData.index = index.'),
      _mbCode(
          '// Inside RenderSliverMultiBoxAdaptor._createOrObtainChild:\n'
          'final child = childManager.createChild(index);\n'
          'child.parentData.index = index;  // ← set here'),
      _mbSubtitle('Index assignment visual'),
      _mbBody('Each box below represents a child with its assigned index:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _mbLabel('Viewport visible region'),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _mbChildBox(0, offScreen: true),
                  _mbChildBox(1, offScreen: true),
                  Container(
                    width: 2,
                    height: 42,
                    color: _mbAccent,
                  ),
                  _mbChildBox(2),
                  _mbChildBox(3),
                  _mbChildBox(4),
                  _mbChildBox(5),
                  _mbChildBox(6),
                  Container(
                    width: 2,
                    height: 42,
                    color: _mbAccent,
                  ),
                  _mbChildBox(7, offScreen: true),
                  _mbChildBox(8, offScreen: true),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _mbTag('visible', _mbPurple),
                _mbTag('off-screen', _mbMuted, Colors.white),
              ],
            ),
          ],
        ),
      ),
      _mbNote(
          'Index is nullable (int?) because newly created children may briefly '
          'have null index before layout assigns it.  After layout, every active '
          'child has a non-null index.'),
      _mbBullet('Range', 'index typically starts at 0 and goes up to childCount - 1'),
      _mbBullet('Uniqueness', 'no two active children share the same index'),
      _mbBullet('Null guard', 'code accessing index should handle the null case'),
    ];

/// §4 — The keepAlive mechanism
List<Widget> _mbKeepAlive() => [
      _mbDivider(),
      _mbTitle('§4  The keepAlive Mechanism'),
      _mbBody(
          'The _keptAlive field (exposed as a getter) controls whether a child '
          'stays in the render tree even when scrolled out of the viewport. '
          'This is how AutomaticKeepAliveClientMixin preserves state.'),
      _mbCode(
          'bool get keptAlive => _keptAlive;\n'
          '\n'
          '// The flag is set via KeepAliveNotification:\n'
          '// 1. The child widget mixes in AutomaticKeepAliveClientMixin\n'
          '// 2. The mixin dispatches KeepAliveNotification(true)\n'
          '// 3. _SliverMultiBoxAdaptorElement handles the notification\n'
          '// 4. It calls renderObject.setupKeepAlive(child)\n'
          '// 5. setupKeepAlive reads parentData._keptAlive'),
      _mbSubtitle('KeepAlive lifecycle'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mbLabel('Timeline of a kept-alive child'),
            const SizedBox(height: 10),
            _mbKeepAliveStep('1', 'Child enters viewport', 'index = 5, keptAlive = false',
                _mbPurple),
            _mbKeepAliveStep(
                '2',
                'AutomaticKeepAliveClientMixin activates',
                'KeepAliveNotification dispatched',
                _mbAccent),
            _mbKeepAliveStep(
                '3', 'Element handles notification', '_keptAlive = true', _mbKeep),
            _mbKeepAliveStep('4', 'Child scrolls off-screen', 'NOT garbage collected',
                _mbKeep),
            _mbKeepAliveStep('5', 'Child re-enters viewport', 'Reused with state intact',
                _mbPurple),
            _mbKeepAliveStep(
                '6',
                'KeepAlive cancelled or dispose',
                '_keptAlive = false → eligible for GC',
                _mbWarn),
          ],
        ),
      ),
      _mbNote(
          'Kept-alive children are stored in a separate map (_keepAliveBucket) '
          'in the element, not in the regular child list. They have a paintOffset '
          'but are not painted during normal sliver paint.'),
    ];

Widget _mbKeepAliveStep(String num, String title, String detail, Color c) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black87)),
                Text(detail,
                    style: TextStyle(fontSize: 11, color: c, fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );

/// §5 — How index is assigned during layout
List<Widget> _mbLayoutAssignment() => [
      _mbDivider(),
      _mbTitle('§5  How Index Is Assigned During Layout'),
      _mbBody(
          'During performLayout, RenderSliverMultiBoxAdaptor creates children '
          'lazily from the delegate. Each child gets its index set immediately '
          'after creation. The layout algorithm depends on the subclass:'),
      _mbSubtitle('SliverList layout loop'),
      _mbCode(
          'RenderSliverList.performLayout() {\n'
          '  // Start from firstChild or create at scrollOffset\n'
          '  var index = indexOf(firstChild!);\n'
          '  while (scrollOffset < targetEnd) {\n'
          '    // insertAndLayoutLeadingChild / insertAndLayoutChild\n'
          '    // → creates child with parentData.index = index\n'
          '    index++;\n'
          '  }\n'
          '}'),
      _mbSubtitle('SliverGrid layout loop'),
      _mbCode(
          'RenderSliverGrid.performLayout() {\n'
          '  final layout = gridDelegate.getLayout(constraints);\n'
          '  var index = firstIndex;\n'
          '  while (geometry.scrollOffset < targetEnd) {\n'
          '    // addAndLayoutChild → parentData.index = index\n'
          '    final geo = layout.getGeometryForChildIndex(index);\n'
          '    index++;\n'
          '  }\n'
          '}'),
      _mbBody(
          'The index must match the delegate position so that the element can '
          'correctly map between child indices and widget keys.'),
      _mbSubtitle('Index flow diagram'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _mbFlowRow('SliverChildDelegate', 'provides builder(context, index)'),
            _mbFlowArrow(),
            _mbFlowRow('Element.createChild(index)', 'inflates widget, attaches RenderBox'),
            _mbFlowArrow(),
            _mbFlowRow('parentData.index = index', 'stored on the RenderBox'),
            _mbFlowArrow(),
            _mbFlowRow('RenderSliver uses index', 'for hit testing, painting, GC'),
          ],
        ),
      ),
    ];

Widget _mbFlowRow(String title, String sub) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _mbPurple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: _mbPurple)),
          Text(sub, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ],
      ),
    );

Widget _mbFlowArrow() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.arrow_downward, size: 16, color: _mbAccent),
    );

/// §6 — Child recycling: old index → new index
List<Widget> _mbRecycling() => [
      _mbDivider(),
      _mbTitle('§6  Child Recycling'),
      _mbBody(
          'When a user scrolls, children leaving the viewport may be recycled '
          'rather than destroyed. The element removes the child from one index '
          'and re-inserts it at another, updating parentData.index.'),
      _mbCode(
          '// Conceptual recycling flow:\n'
          '// 1. Child at index 3 scrolls out of view\n'
          '// 2. collectGarbage decides to remove it\n'
          '// 3. Element deactivates the child element\n'
          '// 4. Later, element needs index 12\n'
          '// 5. Framework reuses the element if key matches\n'
          '// 6. parentData.index is updated to 12'),
      _mbSubtitle('Before and after scroll'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mbLabel('Before scroll (indices 3–7 visible)'),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    5, (i) => _mbChildBox(i + 3)),
              ),
            ),
            const SizedBox(height: 14),
            const Icon(Icons.swap_vert, size: 24, color: _mbAccent),
            const SizedBox(height: 6),
            _mbLabel('After scroll (indices 6–10 visible)'),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _mbChildBox(3, offScreen: true),
                  _mbChildBox(4, offScreen: true),
                  _mbChildBox(5, offScreen: true),
                  _mbArrow(),
                  _mbChildBox(6),
                  _mbChildBox(7),
                  _mbChildBox(8),
                  _mbChildBox(9),
                  _mbChildBox(10),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _mbSmall('Children at indices 3–5 are garbage collected; 8–10 are created fresh'),
          ],
        ),
      ),
      _mbNote(
          'Recycling is an optimization. Without it, every scroll would create '
          'and destroy children. The index in parentData is the key that makes '
          'this mapping work.'),
    ];

/// §7 — KeepAlive notification flow
List<Widget> _mbNotificationFlow() => [
      _mbDivider(),
      _mbTitle('§7  KeepAlive Notification Flow'),
      _mbBody(
          'The keepAlive flag is not set directly by the render object. Instead '
          'it flows through the framework notification system:'),
      _mbSubtitle('Step-by-step notification chain'),
      _mbNumberedStep(1, 'Widget mixes in AutomaticKeepAliveClientMixin',
          'Calls super.build(context) which sends KeepAliveNotification'),
      _mbNumberedStep(2, 'Notification bubbles up the element tree',
          'Standard Notification dispatch mechanism'),
      _mbNumberedStep(3, '_SliverMultiBoxAdaptorElement receives it',
          'The element is a NotificationListener<KeepAliveNotification>'),
      _mbNumberedStep(4, 'Element reads notification.keepAlive',
          'Determines whether to keep or release'),
      _mbNumberedStep(5, 'Element calls renderObject._keepAliveBucket',
          'Moves child between active list and keep-alive bucket'),
      _mbNumberedStep(6, 'parentData._keptAlive is updated',
          'Now reflects the actual keep-alive state'),
      _mbCode(
          '// In _SliverMultiBoxAdaptorElement:\n'
          'void _%.handleKeepAliveNotification(\n'
          '    KeepAliveNotification notification) {\n'
          '  // Sets parentData._keptAlive and moves child\n'
          '  // to/from _keepAliveBucket\n'
          '}'
              .replaceAll('_%.', '')),
      _mbNote(
          'The element — not the render object — owns the keepAlive logic. '
          'The render object only sees the _keptAlive flag on parentData '
          'and skips kept-alive children during painting.'),
    ];

Widget _mbNumberedStep(int n, String title, String detail) => Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _mbPurple,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text('$n',
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.black87)),
                Text(detail,
                    style: const TextStyle(fontSize: 11.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

/// §8 — Visual: scrolling list showing index assignment
List<Widget> _mbScrollingDemo() => [
      _mbDivider(),
      _mbTitle('§8  Scrolling List — Index Assignment'),
      _mbBody(
          'This visualization shows a hypothetical SliverList with 20 items. '
          'The viewport can display 5 items. We show how each child carries '
          'its index and how the visible window moves.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _mbLabel('SliverList — 20 items, viewport shows 5'),
            const SizedBox(height: 12),
            // Three snapshot rows showing different scroll positions
            _mbSnapshotRow('scroll = 0', 0, 4),
            const SizedBox(height: 10),
            _mbSnapshotRow('scroll = 5', 5, 9),
            const SizedBox(height: 10),
            _mbSnapshotRow('scroll = 15', 15, 19),
          ],
        ),
      ),
      _mbBody(
          'At each scroll position, only 5 children are in the active child '
          'list. Each child  parentData.index corresponds exactly to the '
          'delegate index that produced it.'),
      _mbSubtitle('parentData dump at scroll = 5'),
      _mbCode(
          'child[0].parentData.index = 5   paintOffset = Offset(0, 0)\n'
          'child[1].parentData.index = 6   paintOffset = Offset(0, 48)\n'
          'child[2].parentData.index = 7   paintOffset = Offset(0, 96)\n'
          'child[3].parentData.index = 8   paintOffset = Offset(0, 144)\n'
          'child[4].parentData.index = 9   paintOffset = Offset(0, 192)'),
    ];

Widget _mbSnapshotRow(String label, int start, int end) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mbSmall(label),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              end - start + 1,
              (i) => _mbChildBox(start + i),
            ),
          ),
        ),
      ],
    );

/// §9 — Garbage collection using parent data
List<Widget> _mbGarbageCollection() => [
      _mbDivider(),
      _mbTitle('§9  Garbage Collection via collectGarbage'),
      _mbBody(
          'RenderSliverMultiBoxAdaptor.collectGarbage(leadingGarbage, '
          'trailingGarbage) removes children that have scrolled out of view. '
          'It uses parentData.index to identify which children to remove.'),
      _mbCode(
          'void collectGarbage(int leading, int trailing) {\n'
          '  // Remove `leading` children from the start\n'
          '  while (leading > 0) {\n'
          '    // child.parentData.index → used by element\n'
          '    // to deactivate the right child\n'
          '    childManager.removeChild(firstChild!);\n'
          '    leading--;\n'
          '  }\n'
          '  // Remove `trailing` children from the end\n'
          '  while (trailing > 0) {\n'
          '    childManager.removeChild(lastChild!);\n'
          '    trailing--;\n'
          '  }\n'
          '}'),
      _mbSubtitle('GC decision matrix'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _mbGcRow('Off-screen, keptAlive = false', 'Garbage collected', _mbWarn),
            _mbGcRow('Off-screen, keptAlive = true', 'Moved to keep-alive bucket', _mbKeep),
            _mbGcRow('On-screen', 'Retained in active child list', _mbPurple),
            _mbGcRow('Cache extent region', 'Retained (within cacheExtent)', _mbAccent),
          ],
        ),
      ),
      _mbNote(
          'The cacheExtent setting determines how far beyond the viewport '
          'children are kept alive. Default is 250 logical pixels. Children '
          'outside this region AND not keptAlive are garbage collected.'),
    ];

Widget _mbGcRow(String condition, String result, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: condition,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                const TextSpan(
                    text: '  →  ',
                    style: TextStyle(fontSize: 12, color: Colors.black38)),
                TextSpan(
                    text: result,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, color: c)),
              ]),
            ),
          ),
        ],
      ),
    );

/// §10 — toString and debugging
List<Widget> _mbDebugging() => [
      _mbDivider(),
      _mbTitle('§10  toString() and Debugging'),
      _mbBody(
          'SliverMultiBoxAdaptorParentData overrides toString to include '
          'the index and keepAlive state, which makes debugging much easier.'),
      _mbCode(
          'String toString() {\n'
          '  return \'index=\$index; \'\n'
          '         \'\${keptAlive ? "%.%.%.%.keptAlive; " : ""}\'\n'
          '         \'\${super.toString()}\';\n'
          '}'
              .replaceAll('%.%.%.%.', '')),
      _mbSubtitle('Example outputs'),
      _mbPropRow('Active child', 'index=3; paintOffset=Offset(0, 144)'),
      _mbPropRow('Kept-alive child',
          'index=7; keptAlive; paintOffset=Offset(0, 0)',
          valColor: _mbKeep),
      _mbPropRow('Freshly created', 'index=null; paintOffset=Offset(0, 0)',
          valColor: _mbMuted),
      _mbBody(
          'You can inspect parent data in DevTools by selecting a child '
          'inside a SliverList and checking the renderObject.parentData '
          'property in the widget inspector.'),
      _mbNote(
          'When debugging layout issues, check parentData.index first — '
          'a null or wrong index often indicates a problem with child '
          'creation or recycling logic.'),
    ];

/// §11 — Practical usage patterns
List<Widget> _mbPracticalUsage() => [
      _mbDivider(),
      _mbTitle('§11  Practical Usage Patterns'),
      _mbSubtitle('Pattern 1: Accessing index in a custom sliver'),
      _mbCode(
          '// Inside a custom RenderSliver:\n'
          'RenderBox? child = firstChild;\n'
          'while (child != null) {\n'
          '  final pd = child.parentData\n'
          '      as SliverMultiBoxAdaptorParentData;\n'
          '  print(\'Child at index \${pd.index}\');\n'
          '  child = childAfter(child);\n'
          '}'),
      _mbSubtitle('Pattern 2: Checking keepAlive status'),
      _mbCode(
          'final pd = child.parentData\n'
          '    as SliverMultiBoxAdaptorParentData;\n'
          'if (pd.keptAlive) {\n'
          '  // Skip this child — it is off-screen but preserved\n'
          '  // It should not be painted or hit-tested\n'
          '}'),
      _mbSubtitle('Pattern 3: Finding a child by index'),
      _mbCode(
          '// RenderSliverMultiBoxAdaptor provides indexOf:\n'
          'int indexOf(RenderBox child) {\n'
          '  final pd = child.parentData!\n'
          '      as SliverMultiBoxAdaptorParentData;\n'
          '  assert(pd.index != null);\n'
          '  return pd.index!;\n'
          '}'),
      _mbSubtitle('Pattern 4: Custom paint with index-based logic'),
      _mbCode(
          '@override\n'
          'void paint(PaintingContext context, Offset offset) {\n'
          '  RenderBox? child = firstChild;\n'
          '  while (child != null) {\n'
          '    final pd = child.parentData!\n'
          '        as SliverMultiBoxAdaptorParentData;\n'
          '    if (!pd.keptAlive) {\n'
          '      // Only paint active (non-kept-alive) children\n'
          '      context.paintChild(child, offset + pd.paintOffset);\n'
          '    }\n'
          '    child = childAfter(child);\n'
          '  }\n'
          '}'),
      _mbNote(
          'Custom slivers that manage multiple box children almost always '
          'need to interact with SliverMultiBoxAdaptorParentData. The index '
          'is essential for delegate communication and the keepAlive flag '
          'must be respected during paint and hit testing.'),
    ];

/// §12 — Summary
List<Widget> _mbSummary() => [
      _mbDivider(),
      _mbTitle('§12  Summary'),
      _mbBody(
          'SliverMultiBoxAdaptorParentData is the bridge between the sliver '
          'render object and each individual box child. Its two additional '
          'fields — index and keepAlive — enable the lazy, recycling-based '
          'child management that makes Flutter lists efficient.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _mbPurple.withValues(alpha: 0.08),
              _mbLavender,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _mbPurple.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _mbPurple)),
            const SizedBox(height: 10),
            _mbSummaryPoint(
                'index', 'Maps each child to its delegate position (0..N-1)'),
            _mbSummaryPoint(
                'keptAlive', 'Preserves off-screen state for AutomaticKeepAlive'),
            _mbSummaryPoint(
                'Recycling', 'Index enables efficient child reuse on scroll'),
            _mbSummaryPoint(
                'GC', 'collectGarbage removes children by walking the child list'),
            _mbSummaryPoint(
                'Inheritance', 'Extends SliverLogicalContainerParentData → has '
                'paintOffset + linked list pointers'),
            _mbSummaryPoint(
                'Debugging', 'toString includes index and keepAlive for easy inspection'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _mbPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of SliverMultiBoxAdaptorParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _mbSummaryPoint(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _mbKeep),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _mbPurple)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ─── class hierarchy section ──────────────────────────────────────

List<Widget> _mbHierarchy() => [
      _mbDivider(),
      _mbTitle('Inheritance Chain'),
      _mbBody('SliverMultiBoxAdaptorParentData sits at the end of a deep '
          'parent-data hierarchy:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mbHierarchyLevel(0, 'ParentData', 'Base class — minimal'),
            _mbHierarchyLevel(1, 'BoxParentData', '+ Offset offset'),
            _mbHierarchyLevel(2, 'SliverLogicalParentData', '+ Offset paintOffset'),
            _mbHierarchyLevel(
                3,
                'SliverLogicalContainerParentData',
                '+ ContainerParentDataMixin (linked list)'),
            _mbHierarchyLevel(
                4,
                'SliverMultiBoxAdaptorParentData',
                '+ int? index, bool _keptAlive'),
          ],
        ),
      ),
      _mbBody(
          'Each level adds a specific capability. By the time we reach '
          'SliverMultiBoxAdaptorParentData, each child has: an offset '
          'for box layout, a paintOffset for sliver painting, linked-list '
          'pointers for container traversal, an index for delegate mapping, '
          'and a keepAlive flag for state preservation.'),
    ];

Widget _mbHierarchyLevel(int depth, String name, String desc) {
  final indent = depth * 20.0;
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
              color: _mbAccent.withValues(alpha: 0.5),
            ),
          ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 3, right: 8),
          decoration: BoxDecoration(
            color: depth == 4 ? _mbPurple : _mbAccent.withValues(alpha: 0.6),
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
                      fontWeight: depth == 4 ? FontWeight.w800 : FontWeight.w600,
                      fontFamily: 'monospace',
                      color: depth == 4 ? _mbPurple : Colors.black87)),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── comparison with base class ───────────────────────────────────

List<Widget> _mbComparison() => [
      _mbDivider(),
      _mbTitle('Comparison with Base Parent Data'),
      _mbBody(
          'Compared to SliverLogicalContainerParentData, this class adds '
          'the two key fields that enable efficient list management:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mbLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mbCompRow('Feature', 'SliverLogicalContainer...', 'SliverMultiBoxAdaptor...',
                isHeader: true),
            _mbCompRow('paintOffset', 'Yes', 'Yes (inherited)'),
            _mbCompRow('linked list', 'Yes', 'Yes (inherited)'),
            _mbCompRow('int? index', 'No', 'Yes'),
            _mbCompRow('bool keptAlive', 'No', 'Yes'),
            _mbCompRow('Used by', 'Custom slivers', 'SliverList, SliverGrid, etc.'),
          ],
        ),
      ),
    ];

Widget _mbCompRow(String feature, String base, String adaptor,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _mbPurple : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 90, child: Text(feature, style: style)),
        Expanded(child: Text(base, style: style)),
        Expanded(child: Text(adaptor, style: style)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mbBanner(),
        const SizedBox(height: 20),
        ..._mbWhatIs(),
        ..._mbHierarchy(),
        ..._mbIndexField(),
        ..._mbKeepAlive(),
        ..._mbLayoutAssignment(),
        ..._mbRecycling(),
        ..._mbNotificationFlow(),
        ..._mbScrollingDemo(),
        ..._mbGarbageCollection(),
        ..._mbDebugging(),
        ..._mbComparison(),
        ..._mbPracticalUsage(),
        ..._mbSummary(),
      ],
    ),
  );
}
