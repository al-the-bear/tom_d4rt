// ignore_for_file: avoid_print
// D4rt deep demo: LeafRenderObjectElement — element for childless render objects
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Mint / Jade palette ────────────────────────────────────────────
  final deepJade = const Color(0xFF2E7D5B);
  final softMint = const Color(0xFFA5D6C3);
  final seafoamGreen = const Color(0xFF80CBC4);
  final coolMint = const Color(0xFF6DB89F);
  final jadeGreen = const Color(0xFF4CAF7D);
  final spearmint = const Color(0xFF66BB9A);
  final eucalyptus = const Color(0xFF57A882);
  final wintergreen = const Color(0xFF7BC8A4);
  final mintCream = const Color(0xFFE8F5EC);
  final paleJade = const Color(0xFFC8E6D5);

  // ── helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: fg.withValues(alpha: 0.75),
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: border, height: 1.5)),
    );
  }

  Widget infoCard(String label, String value, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Flexible(
            child: Text(value,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace'),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
    );
  }

  Widget dataRow(String key, String val, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(key,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accent)),
          ),
          Expanded(
            child: Text(val,
                style: TextStyle(
                    fontSize: 11,
                    color: accent.withValues(alpha: 0.8),
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(fontSize: 8, color: Colors.black54)),
      ],
    );
  }

  Widget hierarchyRow(String indent, String className, Color accent, bool highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlight ? accent.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: highlight ? Border.all(color: accent.withValues(alpha: 0.3)) : null,
      ),
      child: Text('$indent$className',
          style: TextStyle(
              fontSize: 11,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight ? accent : accent.withValues(alpha: 0.7),
              fontFamily: 'monospace')),
    );
  }

  Widget methodCard(String name, String description, String behavior, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'monospace')),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(description,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(behavior,
              style: TextStyle(
                  fontSize: 11,
                  color: accent.withValues(alpha: 0.75),
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget lifecycleStep(int step, String label, String detail, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text('$step',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: accent)),
                const SizedBox(height: 2),
                Text(detail,
                    style: TextStyle(
                        fontSize: 11,
                        color: accent.withValues(alpha: 0.75),
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget metricTile(String label, String value, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: fg)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 9, color: fg.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  // ── data ───────────────────────────────────────────────────────────
  print('LeafRenderObjectElement deep demo executing');
  print('=' * 60);

  // Section 3 — element hierarchy
  print('\n--- Element hierarchy ---');
  print('Element → ComponentElement / RenderObjectElement');
  print('RenderObjectElement → LeafRenderObjectElement');
  print('  Also → SingleChildRenderObjectElement');
  print('  Also → MultiChildRenderObjectElement');

  // Section 4 — leaf behavior
  print('\n--- Leaf behavior ---');
  print('No children: forgetChild asserts false');
  print('insertRenderObjectChild: asserts false');
  print('moveRenderObjectChild: asserts false');
  print('removeRenderObjectChild: asserts false');

  // Section 5 — ErrorWidget example
  final errorWidget = ErrorWidget('Test error message');
  print('\n--- ErrorWidget (LeafRenderObjectWidget) ---');
  print('errorWidget.runtimeType: ${errorWidget.runtimeType}');
  print('errorWidget is LeafRenderObjectWidget: true');
  print('errorWidget.message: ${errorWidget.message}');

  // Section 6 — SizedBox analysis
  final shrinkBox = SizedBox.shrink();
  final expandBox = SizedBox.expand();
  final sizedBox = SizedBox(width: 100, height: 50);
  print('\n--- SizedBox analysis ---');
  print('SizedBox.shrink: ${shrinkBox.runtimeType}');
  print('SizedBox.expand: ${expandBox.runtimeType}');
  print('SizedBox(100x50) width: ${sizedBox.width}');
  print('Note: SizedBox extends SingleChildRenderObjectWidget, not Leaf');

  // Section 7 — render object methods
  print('\n--- RenderObject methods ---');
  print('createRenderObject: required override');
  print('updateRenderObject: optional override');
  print('didUnmountRenderObject: cleanup hook');

  // Section 8 — lifecycle
  print('\n--- Element lifecycle ---');
  print('1. createElement() → creates LeafRenderObjectElement');
  print('2. mount() → creates RenderObject, inserts in tree');
  print('3. update() → updateRenderObject called');
  print('4. unmount() → removes from tree');

  // Section 9 — mount behavior
  print('\n--- Mount behavior ---');
  print('On mount: attachRenderObject creates render object');
  print('On unmount: detachRenderObject removes render object');
  print('No child-related operations occur');

  // Section 10 — update behavior
  print('\n--- Update behavior ---');
  print('When widget changes, updateRenderObject is called');
  print('RenderObject properties are compared and updated');
  print('No child updates needed (leaf has no children)');

  // Section 11 — assertion patterns
  print('\n--- Assertion patterns ---');
  print('forgetChild: always asserts — leaf has no children');
  print('visitChildren: no-op — nothing to visit');

  // Section 12 — custom design
  print('\n--- Custom LeafRenderObjectWidget design ---');
  print('1. Extend LeafRenderObjectWidget');
  print('2. Implement createRenderObject(BuildContext)');
  print('3. Override updateRenderObject(BuildContext, RenderObject)');
  print('4. RenderObject handles paint() and layout');

  // Performance notes
  print('\n--- Performance characteristics ---');
  print('Leaf elements are the lightest in the tree');
  print('No child management overhead');
  print('Minimal memory footprint per element');

  print('\n${'=' * 60}');
  print('LeafRenderObjectElement deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        sectionBanner(
          '1 · LeafRenderObjectElement Showcase',
          'Element for childless render objects in the widget tree',
          deepJade,
          Colors.white,
        ),

        // ── 2. Concept overview ──────────────────────────────────────
        sectionBanner('2 · Concept Overview',
            'Understanding leaf elements', eucalyptus, Colors.white),
        noteBox(
          'LeafRenderObjectElement is the Element subclass used by '
          'LeafRenderObjectWidget. It represents a leaf node in the '
          'element tree — a node that has no children. It overrides '
          'child-related methods to assert that no children are added.',
          deepJade,
          mintCream,
        ),
        noteBox(
          'Flutter\'s rendering pipeline has three trees: Widget tree, '
          'Element tree, and RenderObject tree. LeafRenderObjectElement '
          'sits in the Element tree as the bridge between a leaf widget '
          'and its corresponding leaf render object.',
          eucalyptus,
          paleJade,
        ),
        infoCard('Class', 'LeafRenderObjectElement', deepJade),
        infoCard('Parent', 'RenderObjectElement', coolMint),
        infoCard('Children', 'None (leaf)', jadeGreen),
        infoCard('Created by', 'LeafRenderObjectWidget.createElement()', spearmint),
        infoCard('Package', 'flutter/widgets.dart', eucalyptus),
        const SizedBox(height: 14),

        // ── 3. Element hierarchy ─────────────────────────────────────
        sectionBanner('3 · Element Class Hierarchy',
            'Where LeafRenderObjectElement fits', softMint, deepJade),
        noteBox(
          'The Element hierarchy mirrors the Widget hierarchy. Each '
          'RenderObjectWidget subclass has a corresponding Element subclass '
          'that manages the RenderObject lifecycle.',
          deepJade,
          mintCream,
        ),
        hierarchyRow('', 'Element (abstract)', deepJade, false),
        hierarchyRow('  ├─ ', 'ComponentElement', coolMint, false),
        hierarchyRow('  │   ├─ ', 'StatelessElement', jadeGreen, false),
        hierarchyRow('  │   └─ ', 'StatefulElement', spearmint, false),
        hierarchyRow('  └─ ', 'RenderObjectElement', eucalyptus, false),
        hierarchyRow('      ├─ ', 'LeafRenderObjectElement', deepJade, true),
        hierarchyRow('      ├─ ', 'SingleChildRenderObjectElement', coolMint, false),
        hierarchyRow('      └─ ', 'MultiChildRenderObjectElement', jadeGreen, false),
        const SizedBox(height: 8),
        noteBox(
          'LeafRenderObjectElement is the simplest RenderObjectElement — '
          'it has no child management logic. SingleChildRenderObjectElement '
          'manages one child, and MultiChildRenderObjectElement manages a list.',
          wintergreen,
          paleJade,
        ),
        const SizedBox(height: 14),

        // ── 4. Leaf behavior card ────────────────────────────────────
        sectionBanner('4 · No-Children Guarantee',
            'Child operations assert false', jadeGreen, Colors.white),
        noteBox(
          'LeafRenderObjectElement enforces the no-children invariant by '
          'overriding all child-related methods to assert false. Attempting '
          'to add, move, or remove children will trigger assertion failures.',
          deepJade,
          mintCream,
        ),
        methodCard('forgetChild', 'Remove child reference',
            'Always asserts false — leaf cannot have children to forget',
            deepJade),
        methodCard('insertRenderObjectChild', 'Insert child render object',
            'Always asserts false — no child slot exists in a leaf',
            coolMint),
        methodCard('moveRenderObjectChild', 'Move child render object',
            'Always asserts false — cannot move non-existent children',
            jadeGreen),
        methodCard('removeRenderObjectChild', 'Remove child render object',
            'Always asserts false — nothing to remove from a leaf',
            spearmint),
        const SizedBox(height: 14),

        // ── 5. ErrorWidget example ───────────────────────────────────
        sectionBanner('5 · ErrorWidget as Leaf',
            'Concrete LeafRenderObjectWidget example', spearmint, Colors.white),
        noteBox(
          'ErrorWidget is Flutter\'s built-in error display widget. It '
          'extends LeafRenderObjectWidget and creates a RenderErrorBox '
          'that paints an error message. It demonstrates the leaf pattern: '
          'no children, just a render object that paints directly.',
          deepJade,
          mintCream,
        ),
        dataRow('Type', '${errorWidget.runtimeType}', deepJade),
        dataRow('Is LeafRenderObjectWidget', 'true', coolMint),
        dataRow('Message', errorWidget.message, jadeGreen),
        dataRow('Creates', 'RenderErrorBox', spearmint),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepJade.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepJade.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ErrorWidget Internals',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 6),
              dataRow('Widget', 'ErrorWidget', deepJade),
              dataRow('Element', 'LeafRenderObjectElement', coolMint),
              dataRow('RenderObject', 'RenderErrorBox', jadeGreen),
              dataRow('Painting', 'Yellow/red error stripe', spearmint),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. SizedBox analysis ─────────────────────────────────────
        sectionBanner('6 · SizedBox Comparison',
            'SingleChild vs Leaf distinction', eucalyptus, Colors.white),
        noteBox(
          'SizedBox extends SingleChildRenderObjectWidget, NOT '
          'LeafRenderObjectWidget, because it can have a child. Even '
          'SizedBox.shrink() — which typically has no child — still uses '
          'SingleChildRenderObjectElement because the child slot exists.',
          deepJade,
          mintCream,
        ),
        dataRow('SizedBox.shrink()', '${shrinkBox.runtimeType}', deepJade),
        dataRow('SizedBox.expand()', '${expandBox.runtimeType}', coolMint),
        dataRow('SizedBox(100x50).width', '${sizedBox.width}', jadeGreen),
        dataRow('SizedBox element', 'SingleChildRenderObjectElement', spearmint),
        dataRow('ErrorWidget element', 'LeafRenderObjectElement', eucalyptus),
        noteBox(
          'Key distinction: Leaf widgets CANNOT have children by design. '
          'Single-child widgets CAN have one child (or none). The element '
          'type reflects this — LeafRenderObjectElement has no child slot.',
          wintergreen,
          paleJade,
        ),
        const SizedBox(height: 14),

        // ── 7. Render object methods ─────────────────────────────────
        sectionBanner('7 · Key RenderObject Methods',
            'Methods that configure the render object', wintergreen, deepJade),
        noteBox(
          'The LeafRenderObjectWidget subclass must implement '
          'createRenderObject() and may override updateRenderObject(). '
          'The Element manages calling these at the right lifecycle moments.',
          deepJade,
          mintCream,
        ),
        methodCard('createRenderObject', 'Required — creates the RenderObject',
            'Called once during mount. Returns the initial render object '
            'configured from widget properties. Must not be null.',
            deepJade),
        methodCard('updateRenderObject', 'Optional — updates existing RenderObject',
            'Called when the widget changes but the element stays. Updates '
            'render object properties to match new widget configuration.',
            coolMint),
        methodCard('didUnmountRenderObject', 'Optional — cleanup hook',
            'Called when the render object is unmounted from the tree. '
            'Use for releasing resources held by the render object.',
            jadeGreen),
        const SizedBox(height: 14),

        // ── 8. Element lifecycle ─────────────────────────────────────
        sectionBanner('8 · Element Lifecycle',
            'Creation, mount, update, unmount', softMint, deepJade),
        noteBox(
          'LeafRenderObjectElement follows the standard Element lifecycle '
          'but without any child-related phases. This makes it the '
          'simplest and fastest Element lifecycle.',
          deepJade,
          mintCream,
        ),
        lifecycleStep(1, 'createElement()',
            'Widget.createElement() creates the LeafRenderObjectElement',
            deepJade),
        lifecycleStep(2, 'mount(parent, slot)',
            'Element mounts into tree, createRenderObject() is called',
            coolMint),
        lifecycleStep(3, 'update(newWidget)',
            'When widget changes, updateRenderObject() is called',
            jadeGreen),
        lifecycleStep(4, 'deactivate()',
            'Element is temporarily removed from tree',
            spearmint),
        lifecycleStep(5, 'unmount()',
            'Element is permanently removed, didUnmountRenderObject() called',
            eucalyptus),
        const SizedBox(height: 14),

        // ── 9. Mount behavior ────────────────────────────────────────
        sectionBanner('9 · Mount & Unmount Behavior',
            'Render object creation and disposal', coolMint, Colors.white),
        noteBox(
          'When a LeafRenderObjectElement is mounted, it creates its '
          'RenderObject via createRenderObject() and inserts it into '
          'the render tree. On unmount, it removes the render object. '
          'No child attachment/detachment occurs.',
          deepJade,
          mintCream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: coolMint.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: coolMint.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mount Sequence',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 6),
              dataRow('1. mount()', 'Called by parent Element', deepJade),
              dataRow('2. createRenderObject()', 'Creates the RenderObject', coolMint),
              dataRow('3. attachRenderObject()', 'Inserts into render tree', jadeGreen),
              dataRow('4. (no children)', 'Leaf skips child processing', spearmint),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: spearmint.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: spearmint.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unmount Sequence',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 6),
              dataRow('1. deactivate()', 'Temporarily removed', deepJade),
              dataRow('2. unmount()', 'Permanently removed', coolMint),
              dataRow('3. detachRenderObject()', 'Removes render object', jadeGreen),
              dataRow('4. didUnmountRenderObject()', 'Cleanup hook', spearmint),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Update behavior ──────────────────────────────────────
        sectionBanner('10 · Update Behavior',
            'Handling widget configuration changes', deepJade, Colors.white),
        noteBox(
          'When the parent rebuilds with a new widget of the same type, '
          'the Element is updated rather than recreated. The render object '
          'is reused and updateRenderObject() applies new properties.',
          deepJade,
          mintCream,
        ),
        lifecycleStep(1, 'Parent rebuilds',
            'Framework compares old widget with new widget of same type',
            deepJade),
        lifecycleStep(2, 'update(newWidget)',
            'Element stores reference to new widget, calls updateRenderObject',
            coolMint),
        lifecycleStep(3, 'updateRenderObject()',
            'New property values are applied to the existing RenderObject',
            jadeGreen),
        lifecycleStep(4, 'markNeedsPaint()',
            'RenderObject marks itself as needing repaint if visuals changed',
            spearmint),
        const SizedBox(height: 14),

        // ── 11. Assertion patterns ───────────────────────────────────
        sectionBanner('11 · Assertion Enforcement',
            'How the leaf invariant is protected', jadeGreen, Colors.white),
        noteBox(
          'LeafRenderObjectElement overrides four child-related methods, '
          'each with an assert(false) to ensure the leaf invariant.'
          ' This catches bugs where code tries to treat a leaf as a parent.',
          deepJade,
          mintCream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeGreen.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: jadeGreen.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Protected Methods',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 8),
              dataRow('forgetChild(child)', 'assert(false)', deepJade),
              dataRow('insertRenderObjectChild', 'assert(false)', coolMint),
              dataRow('moveRenderObjectChild', 'assert(false)', jadeGreen),
              dataRow('removeRenderObjectChild', 'assert(false)', spearmint),
              const SizedBox(height: 6),
              dataRow('visitChildren(visitor)', 'No-op (empty body)', eucalyptus),
              dataRow('debugDescribeChildren()', 'Returns empty list', wintergreen),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Custom leaf design ───────────────────────────────────
        sectionBanner('12 · Custom Leaf Widget Design',
            'Implementing a custom LeafRenderObjectWidget', spearmint, Colors.white),
        noteBox(
          'To create a custom leaf widget: extend LeafRenderObjectWidget, '
          'implement createRenderObject(), and create a RenderBox subclass '
          'that performs layout and painting. The Element is created '
          'automatically by the base class.',
          deepJade,
          mintCream,
        ),
        lifecycleStep(1, 'Extend LeafRenderObjectWidget',
            'Create your widget subclass with configuration properties',
            deepJade),
        lifecycleStep(2, 'Create RenderBox subclass',
            'Implement performLayout() and paint() for custom rendering',
            coolMint),
        lifecycleStep(3, 'Implement createRenderObject()',
            'Return a new instance of your RenderBox, configured from widget props',
            jadeGreen),
        lifecycleStep(4, 'Override updateRenderObject()',
            'Update the RenderBox when widget properties change',
            spearmint),
        noteBox(
          'The LeafRenderObjectElement is created by the framework — '
          'you never instantiate it directly. Your responsibility is '
          'the widget and render object, not the element.',
          eucalyptus,
          paleJade,
        ),
        const SizedBox(height: 14),

        // ── 13. Performance notes ────────────────────────────────────
        sectionBanner('13 · Performance Characteristics',
            'Why leaf elements are efficient', eucalyptus, Colors.white),
        noteBox(
          'Leaf elements are the lightest elements in the tree. They have '
          'no child management overhead, no child iteration, and no child '
          'reconciliation during rebuilds. This makes them ideal for '
          'high-frequency widgets like custom painters and shapes.',
          deepJade,
          mintCream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: eucalyptus.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: eucalyptus.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Performance Comparison',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 8),
              dataRow('Leaf element', 'Zero child overhead', deepJade),
              dataRow('Single-child element', 'One child slot managed', coolMint),
              dataRow('Multi-child element', 'N child slots managed', jadeGreen),
              const SizedBox(height: 6),
              dataRow('Leaf rebuild cost', 'Minimal — no children to reconcile', spearmint),
              dataRow('Leaf memory', 'Smallest element footprint', eucalyptus),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Debug information ────────────────────────────────────
        sectionBanner('14 · Debug Information',
            'Diagnostics and tree inspection', wintergreen, deepJade),
        noteBox(
          'LeafRenderObjectElement participates in Flutter\'s diagnostics '
          'system. debugDescribeChildren() returns an empty list, and '
          'toDiagnosticsNode() provides element information for the '
          'widget inspector and debug tools.',
          deepJade,
          mintCream,
        ),
        methodCard('debugDescribeChildren()', 'Returns empty DiagnosticsNode list',
            'No children means no child diagnostics to report',
            deepJade),
        methodCard('toDiagnosticsNode()', 'Element diagnostics',
            'Reports widget type, depth, and render object info',
            coolMint),
        methodCard('describeMissingChild()', 'Not applicable',
            'Leaf elements never have missing children to describe',
            jadeGreen),
        dataRow('In widget inspector', 'Shows as leaf node', deepJade),
        dataRow('Child count', '0 (always)', coolMint),
        const SizedBox(height: 14),

        // ── 15. Element type comparison ──────────────────────────────
        sectionBanner('15 · Element Type Comparison',
            'Leaf vs SingleChild vs MultiChild', softMint, deepJade),
        noteBox(
          'The three RenderObjectElement subclasses serve different child '
          'configurations. Choosing correctly is essential — mismatched '
          'element/widget types cause assertion failures.',
          deepJade,
          mintCream,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepJade.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepJade.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Element Types',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 8),
              dataRow('LeafRenderObjectElement', '0 children', deepJade),
              dataRow('  Widget', 'LeafRenderObjectWidget', coolMint),
              dataRow('  Example', 'ErrorWidget', jadeGreen),
              const SizedBox(height: 6),
              dataRow('SingleChildRenderObject…', '0–1 children', spearmint),
              dataRow('  Widget', 'SingleChildRenderObjectWidget', eucalyptus),
              dataRow('  Example', 'SizedBox, Padding', wintergreen),
              const SizedBox(height: 6),
              dataRow('MultiChildRenderObject…', '0–N children', deepJade),
              dataRow('  Widget', 'MultiChildRenderObjectWidget', coolMint),
              dataRow('  Example', 'Flex, Stack', jadeGreen),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary Dashboard',
            'LeafRenderObjectElement metrics', deepJade, Colors.white),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            metricTile('Children', '0', mintCream, deepJade),
            metricTile('Assertions', '4', paleJade, coolMint),
            metricTile('Lifecycle', '5', mintCream, jadeGreen),
            metricTile('Methods', '4', paleJade, spearmint),
            metricTile('RO methods', '3', mintCream, eucalyptus),
            metricTile('Examples', '1', paleJade, wintergreen),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tag('LeafRenderObjectElement', deepJade, Colors.white),
            tag('RenderObjectElement', coolMint, Colors.white),
            tag('No children', jadeGreen, Colors.white),
            tag('ErrorWidget', spearmint, Colors.white),
            tag('Element lifecycle', eucalyptus, Colors.white),
            tag('Assertions', wintergreen, deepJade),
            tag('RenderObject', softMint, deepJade),
            tag('Performance', paleJade, deepJade),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mintCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepJade.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mint / Jade Palette',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepJade)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  colorSwatch('deepJade', deepJade),
                  colorSwatch('softMint', softMint),
                  colorSwatch('seafoam', seafoamGreen),
                  colorSwatch('coolMint', coolMint),
                  colorSwatch('jade', jadeGreen),
                  colorSwatch('spearmint', spearmint),
                  colorSwatch('eucalyptus', eucalyptus),
                  colorSwatch('wintergrn', wintergreen),
                  colorSwatch('mintCream', mintCream),
                  colorSwatch('paleJade', paleJade),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
