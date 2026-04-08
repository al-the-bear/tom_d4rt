// ignore_for_file: avoid_print
// IndexedSlot – comprehensive deep demo
// Mauve / Blush palette – the simple immutable pair that tracks a child
// Element's index and previous sibling in multi-child render objects.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ixMauve = Color(0xFF6A1B9A);
  const Color ixBlush = Color(0xFFF3E5F5);
  const Color ixOnMauve = Color(0xFFFFFFFF);
  const Color ixDark = Color(0xFF38006B);
  const Color ixLightBlush = Color(0xFFFAF0FC);
  const Color ixTextDark = Color(0xFF2E1036);
  const Color ixAccent = Color(0xFFAB47BC);
  const Color ixMuted = Color(0xFFCE93D8);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ixHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ixMauve, ixDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ixOnMauve)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ixOnMauve.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ixSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ixLightBlush,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ixMauve.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ixMauve.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ixMauve)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget ixBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: ixAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ixTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ixCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0025),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ixBlush,
              height: 1.5)),
    );
  }

  Widget ixKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ixDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ixTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ixHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ixAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ixAccent.withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ixDark,
              height: 1.4)),
    );
  }

  Widget ixDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ixMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ixSlotCard(int index, String valueDesc, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('$index',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accent)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IndexedSlot<Element?>($index, ...)',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: accent)),
                const SizedBox(height: 2),
                Text(valueDesc,
                    style: const TextStyle(
                        fontSize: 10, color: ixTextDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ixCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ixMauve,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: ixDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: ixTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ixInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ixMauve.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ixMauve)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ixDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ixTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ixBlush,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ixHeader(
            'IndexedSlot',
            'An immutable pair of (index, value) used to track child '
                'position and previous sibling in multi-child render object '
                'elements',
          ),

          // ── 1. class identity ──
          ixSection('1 · Class Identity', [
            ixKeyValue('Class', 'IndexedSlot<T extends Element?>'),
            ixKeyValue('Annotation', '@immutable'),
            ixKeyValue('Library', 'package:flutter/widgets.dart'),
            ixKeyValue('Properties', 'index (int), value (T)'),
            ixKeyValue('Constructor', 'const IndexedSlot(index, value)'),
            ixDivider(),
            ixBullet(
                'IndexedSlot is a tiny, immutable data class. It pairs an '
                'integer index with an optional Element value, tracking '
                'both the position of a child in a multi-child layout and '
                'its previous sibling.'),
            ixBullet(
                'The @immutable annotation ensures both fields are final '
                'and the constructor is const-eligible.'),
          ]),

          // ── 2. source code ──
          ixSection('2 · Complete Source Code', [
            ixHighlight(
                'IndexedSlot is one of the simplest classes in Flutter. '
                'Its entire implementation fits in a few lines.'),
            ixCodeBlock(
                '// The full implementation:\n'
                '@immutable\n'
                'class IndexedSlot<T extends Element?> {\n'
                '  const IndexedSlot(this.index, this.value);\n'
                '\n'
                '  final T value;\n'
                '  final int index;\n'
                '\n'
                '  @override\n'
                '  bool operator ==(Object other) {\n'
                '    if (other.runtimeType != runtimeType) return false;\n'
                '    return other is IndexedSlot\n'
                '        && index == other.index\n'
                '        && value == other.value;\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  int get hashCode => Object.hash(index, value);\n'
                '}'),
          ]),

          // ── 3. the two fields ──
          ixSection('3 · The Two Fields', [
            ixKeyValue('index (int)',
                'Zero-based position in the parent child list'),
            ixKeyValue('value (T)',
                'The previous sibling Element, or null for the first child'),
            ixDivider(),
            ixCodeBlock(
                '// For a Column with 3 children:\n'
                '// Child 0: IndexedSlot(0, null)       ← no previous\n'
                '// Child 1: IndexedSlot(1, element_0)   ← after child 0\n'
                '// Child 2: IndexedSlot(2, element_1)   ← after child 1'),
            ixBullet(
                'The index tells the child its position. The value lets '
                'the element tree know which sibling comes before it, '
                'which is needed for efficient child list updates.'),
          ]),

          // ── 4. visual: child list slots ──
          ixSection('4 · Visual: Multi-Child Slot Layout', [
            ixSlotCard(0, 'value = null (first child, no predecessor)',
                const Color(0xFF6A1B9A)),
            ixSlotCard(1, 'value = element[0] (previous sibling)',
                const Color(0xFF0277BD)),
            ixSlotCard(2, 'value = element[1] (previous sibling)',
                const Color(0xFF1B5E20)),
            ixSlotCard(3, 'value = element[2] (previous sibling)',
                const Color(0xFFE65100)),
            ixDivider(),
            ixBullet(
                'Each child gets a slot. The slot says: "I am child #N, '
                'and the child before me is element X." This is how '
                'Flutter maintains the correct order.'),
          ]),

          // ── 5. where it is used ──
          ixSection('5 · Usage in MultiChildRenderObjectElement', [
            ixBullet(
                'MultiChildRenderObjectElement calls updateChildren() '
                'to diff old and new child widget lists.'),
            ixBullet(
                'Each child Element is inflated with an IndexedSlot as '
                'its slot argument, so the render object can insert it '
                'at the correct position.'),
            ixCodeBlock(
                '// Inside MultiChildRenderObjectElement:\n'
                'Element inflateWidget(Widget newWidget, Object? slot) {\n'
                '  // slot is an IndexedSlot<Element?>\n'
                '  final element = newWidget.createElement();\n'
                '  element.mount(this, slot);\n'
                '  return element;\n'
                '}\n'
                '\n'
                '// The render object uses slot.index to know\n'
                '// WHERE to insert the child in its child list,\n'
                '// and slot.value to know AFTER WHICH sibling.'),
          ]),

          // ── 6. updateChildren algorithm ──
          ixSection('6 · The updateChildren Algorithm', [
            ixBullet(
                'updateChildren is a linear reconciliation algorithm '
                'that diffs old children against new widgets.'),
            ixInfoRow('1', 'Top scan:', 'Match from start until mismatch'),
            ixInfoRow('2', 'Bottom scan:', 'Match from end until mismatch'),
            ixInfoRow('3', 'Middle:', 'Key-based matching of remaining'),
            ixInfoRow('4', 'Remove:', 'Deactivate unmatched old elements'),
            ixInfoRow('5', 'Insert:', 'Inflate new widgets with slots'),
            ixDivider(),
            ixCodeBlock(
                '// Slot assignment during updateChildren:\n'
                '// After reconciliation, each surviving/new element\n'
                '// gets an IndexedSlot:\n'
                '//\n'
                '// for (int i = 0; i < newChildren.length; i++) {\n'
                '//   final previousChild = i > 0 ? newChildren[i-1] : null;\n'
                '//   final slot = IndexedSlot(i, previousChild);\n'
                '//   newChildren[i].slot = slot;\n'
                '// }'),
          ]),

          // ── 7. equality semantics ──
          ixSection('7 · Equality & hashCode', [
            ixBullet(
                'Two IndexedSlots are equal when they have the same '
                'runtimeType, same index, and same value.'),
            ixBullet(
                'hashCode uses Object.hash(index, value) for consistent '
                'hash distribution.'),
            ixCodeBlock(
                '// Equality contract:\n'
                '// IndexedSlot(0, null) == IndexedSlot(0, null)  → true\n'
                '// IndexedSlot(0, null) == IndexedSlot(1, null)  → false\n'
                '// IndexedSlot(0, elemA) == IndexedSlot(0, elemB) → false\n'
                '//   (unless elemA == elemB)\n'
                '\n'
                '// Hash code:\n'
                '// Object.hash(index, value)\n'
                '// ≡ Jenkins hash of (index, value)'),
            ixDivider(),
            ixHighlight(
                'Equality is critical because the framework compares '
                'old and new slots to determine whether a child needs '
                'to be moved. If the slot changes, the render object '
                'repositions the child.'),
          ]),

          // ── 8. const canonicalization ──
          ixSection('8 · Const Canonicalization', [
            ixBullet(
                'Because IndexedSlot has a const constructor and both '
                'fields are final, identical const instances share the '
                'same memory.'),
            ixCodeBlock(
                '// Const canonicalization:\n'
                'const a = IndexedSlot<Element?>(0, null);\n'
                'const b = IndexedSlot<Element?>(0, null);\n'
                '\n'
                'identical(a, b)  // true  — same const instance\n'
                'a == b           // true  — equal by value\n'
                'a.hashCode == b.hashCode  // true\n'
                '\n'
                '// Non-const:\n'
                'final c = IndexedSlot<Element?>(0, null);\n'
                'final d = IndexedSlot<Element?>(0, null);\n'
                'identical(c, d)  // false — different instances\n'
                'c == d           // true  — equal by value'),
          ]),

          // ── 9. generic type parameter ──
          ixSection('9 · Generic Type Parameter T', [
            ixKeyValue('T bound', 'extends Element?'),
            ixKeyValue('Typical usage', 'IndexedSlot<Element?>'),
            ixDivider(),
            ixBullet(
                'The type parameter T constrains the value field to be '
                'an Element? (or a more specific nullable Element subtype).'),
            ixBullet(
                'In practice, T is almost always Element? because the '
                'value represents the previous sibling Element, which '
                'may or may not exist.'),
            ixCodeBlock(
                '// Type parameter usage:\n'
                '// class IndexedSlot<T extends Element?>\n'
                '//\n'
                '// Typical: IndexedSlot<Element?>\n'
                '// The bound ensures value is always Element-compatible.\n'
                '//\n'
                '// The null case represents "no previous sibling"\n'
                '// (i.e., first child in the list).'),
          ]),

          // ── 10. render object integration ──
          ixSection('10 · Render Object insertRenderObjectChild', [
            ixBullet(
                'When an Element mounts with an IndexedSlot, it calls '
                'insertRenderObjectChild on the parent render object.'),
            ixCodeBlock(
                '// In a MultiChildRenderObjectElement:\n'
                '@override\n'
                'void insertRenderObjectChild(\n'
                '  RenderObject child, IndexedSlot<Element?> slot,\n'
                ') {\n'
                '  final parentData = child.parentData;\n'
                '  final renderParent = renderObject\n'
                '      as ContainerRenderObjectMixin;\n'
                '  // Insert after the render object of slot.value\n'
                '  renderParent.insert(\n'
                '    child,\n'
                '    after: slot.value?.renderObject as RenderBox?,\n'
                '  );\n'
                '}'),
            ixDivider(),
            ixBullet(
                'The slot.value (previous sibling Element) gives the '
                'render object a reference point for positioning. '
                'slot.value?.renderObject is the render object to insert '
                'after.'),
          ]),

          // ── 11. moveRenderObjectChild ──
          ixSection('11 · Moving Children', [
            ixBullet(
                'When a child moves (different index but same key), '
                'moveRenderObjectChild is called with the new IndexedSlot.'),
            ixCodeBlock(
                '// Move uses the new slot to reposition:\n'
                '@override\n'
                'void moveRenderObjectChild(\n'
                '  RenderObject child,\n'
                '  IndexedSlot<Element?> oldSlot,\n'
                '  IndexedSlot<Element?> newSlot,\n'
                ') {\n'
                '  final renderParent = renderObject\n'
                '      as ContainerRenderObjectMixin;\n'
                '  renderParent.move(\n'
                '    child,\n'
                '    after: newSlot.value?.renderObject as RenderBox?,\n'
                '  );\n'
                '}'),
            ixDivider(),
            ixBullet(
                'The old slot says where the child was; the new slot '
                'says where it should go. The render object moves '
                'the child in its linked list accordingly.'),
          ]),

          // ── 12. widget tree to element tree ──
          ixSection('12 · Widget → Element → RenderObject Flow', [
            ixCodeBlock(
                '// Column (MultiChildRenderObjectWidget)\n'
                '//   ├─ Text("A")     widget[0]\n'
                '//   ├─ Text("B")     widget[1]\n'
                '//   └─ Text("C")     widget[2]\n'
                '//\n'
                '// Element tree (MultiChildRenderObjectElement):\n'
                '//   ├─ TextElement   slot=IndexedSlot(0, null)\n'
                '//   ├─ TextElement   slot=IndexedSlot(1, elem[0])\n'
                '//   └─ TextElement   slot=IndexedSlot(2, elem[1])\n'
                '//\n'
                '// Render tree (RenderFlex):\n'
                '//   ├─ RenderParagraph  (position 0)\n'
                '//   ├─ RenderParagraph  (position 1)\n'
                '//   └─ RenderParagraph  (position 2)'),
          ]),

          // ── 13. comparison with other slot types ──
          ixSection('13 · Comparison with Other Slot Types', [
            ixCompare('IndexedSlot',
                'Multi-child: pairs index with previous sibling'),
            ixCompare('null slot',
                'Single-child elements use null as the slot'),
            ixCompare('String slot',
                'Named slots in custom elements (rare)'),
            ixDivider(),
            ixBullet(
                'The slot system is generic — any Object? can be a slot. '
                'IndexedSlot is the standard convention for ordered '
                'multi-child containers like Column, Row, Stack, Wrap.'),
            ixBullet(
                'SingleChildRenderObjectElement always passes null as '
                'the slot since there is only one child.'),
          ]),

          // ── 14. reordering with keys ──
          ixSection('14 · Key-Based Reordering', [
            ixBullet(
                'When children have keys, updateChildren can reorder '
                'them rather than destroy and recreate.'),
            ixCodeBlock(
                '// Before: [A(key:1), B(key:2), C(key:3)]\n'
                '//   slots: [IS(0,null), IS(1,A), IS(2,B)]\n'
                '//\n'
                '// After:  [C(key:3), A(key:1), B(key:2)]\n'
                '//   slots: [IS(0,null), IS(1,C), IS(2,A)]\n'
                '//\n'
                '// C moves from index 2 to 0 (new slot)\n'
                '// A moves from index 0 to 1 (new slot)\n'
                '// B moves from index 1 to 2 (new slot)\n'
                '//\n'
                '// Elements are reused — only slots change.'),
            ixDivider(),
            ixHighlight(
                'Reordering is why IndexedSlot tracks the previous '
                'sibling and not just the index — the render object '
                'needs to know after which child to insert, and the '
                'linked list structure uses sibling references.'),
          ]),

          // ── 15. performance notes ──
          ixSection('15 · Performance Characteristics', [
            ixBullet(
                'IndexedSlot is allocation-lightweight — two fields, '
                'no collections, no callbacks.'),
            ixBullet(
                'Const slots are free (canonicalized by the compiler). '
                'Non-const slots are transient (created during update, '
                'not cached).'),
            ixBullet(
                'The equality check is O(1) — just compare two ints '
                'and two object references.'),
            ixDivider(),
            ixBullet(
                'For a Column with N children, N IndexedSlot instances '
                'are created on each updateChildren pass. Since they are '
                'small and short-lived, GC pressure is minimal.'),
          ]),

          // ── 16. quick reference ──
          ixSection('16 · Quick API Reference', [
            ixKeyValue('Class', 'IndexedSlot<T extends Element?>'),
            ixKeyValue('Const constructor', 'IndexedSlot(int, T)'),
            ixKeyValue('index', 'int — position in child list'),
            ixKeyValue('value', 'T — previous sibling Element?'),
            ixKeyValue('operator ==', 'runtimeType + index + value'),
            ixKeyValue('hashCode', 'Object.hash(index, value)'),
            ixDivider(),
            ixCodeBlock(
                '// Summary:\n'
                '// IndexedSlot is a simple (index, value) pair.\n'
                '// index = child position (0, 1, 2, ...)\n'
                '// value = previous sibling Element (or null)\n'
                '//\n'
                '// Used by MultiChildRenderObjectElement to\n'
                '// track child ordering and enable efficient\n'
                '// insertions, removals, and reorderings.'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ixMauve.withValues(alpha: 0.06),
            child: const Text(
              'IndexedSlot · Mauve Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ixMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
