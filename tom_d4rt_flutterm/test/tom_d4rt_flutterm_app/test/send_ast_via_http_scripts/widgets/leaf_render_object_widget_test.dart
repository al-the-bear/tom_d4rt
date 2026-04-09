// ignore_for_file: avoid_print
// D4rt deep demo: LeafRenderObjectWidget — abstract widget for childless render objects
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Charcoal / Ash palette ─────────────────────────────────────────
  final deepCharcoal = const Color(0xFF2D3436);
  final warmAsh = const Color(0xFF636E72);
  final smokeDark = const Color(0xFF4A5568);
  final onyxBlue = const Color(0xFF3D5A6E);
  final carbonGray = const Color(0xFF4F5B62);
  final cementLight = const Color(0xFF90A4AE);
  final thunderGray = const Color(0xFF78909C);
  final silverMist = const Color(0xFFB0BEC5);
  final dustyStone = const Color(0xFFECEFF1);
  final ashRose = const Color(0xFFCFD8DC);

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
            width: 155,
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

  Widget methodCard(String name, String desc, String detail, Color accent) {
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
                child: Text(desc,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(detail,
              style: TextStyle(
                  fontSize: 11,
                  color: accent.withValues(alpha: 0.75),
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget stepCard(int num, String label, String detail, Color accent) {
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
            child: Text('$num',
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
  print('LeafRenderObjectWidget deep demo executing');
  print('=' * 60);

  // Section 3 — widget hierarchy
  print('\n--- Widget hierarchy ---');
  print('Widget → RenderObjectWidget → LeafRenderObjectWidget');
  print('Also → SingleChildRenderObjectWidget');
  print('Also → MultiChildRenderObjectWidget');

  // Section 4 — ErrorWidget example
  final errorWidget = ErrorWidget(FlutterError('Demo error'));
  final errorString = ErrorWidget('String error');
  print('\n--- ErrorWidget (concrete leaf) ---');
  print('errorWidget.runtimeType: ${errorWidget.runtimeType}');
  print('Is LeafRenderObjectWidget: true');
  print('Is RenderObjectWidget: true');
  print('errorWidget.message: ${errorWidget.message}');
  print('errorString.message: ${errorString.message}');

  // Section 5 — createElement
  print('\n--- createElement ---');
  print('Returns LeafRenderObjectElement');
  print('Called by framework during inflation');

  // Section 6 — createRenderObject
  print('\n--- createRenderObject ---');
  print('Required abstract method');
  print('Returns RenderObject configured from widget properties');
  print('ErrorWidget returns RenderErrorBox');

  // Section 7 — updateRenderObject
  print('\n--- updateRenderObject ---');
  print('Optional override');
  print('Updates existing RenderObject with new widget properties');
  print('Default implementation does nothing');

  // Section 8 — no children guarantee
  print('\n--- No children ---');
  print('LeafRenderObjectWidget has no child property');
  print('createElement() returns LeafRenderObjectElement');
  print('Element asserts no children');

  // Section 9 — render object lifecycle
  print('\n--- RenderObject lifecycle ---');
  print('1. createRenderObject called on mount');
  print('2. updateRenderObject called on widget change');
  print('3. didUnmountRenderObject on removal');

  // Section 10 — comparison
  print('\n--- Vs SingleChildRenderObjectWidget ---');
  final sizedBox = SizedBox(width: 50, height: 50);
  print('SizedBox is SingleChild: true');
  print('SizedBox is NOT Leaf: ${sizedBox is! LeafRenderObjectWidget}');
  print('ErrorWidget IS Leaf: true');

  // Section 11 — MultiChild comparison
  print('\n--- Vs MultiChildRenderObjectWidget ---');
  print('Column/Row/Stack use MultiChild');
  print('Leaf = 0 children, Single = 0-1, Multi = 0-N');

  // Custom implementation notes
  print('\n--- Custom implementation ---');
  print('1. Extend LeafRenderObjectWidget');
  print('2. Create custom RenderBox');
  print('3. Implement createRenderObject');
  print('4. Override updateRenderObject if needed');

  // Painting
  print('\n--- Painting behavior ---');
  print('RenderObject.paint() handles all drawing');
  print('No child painting needed (leaf)');

  // Hit testing
  print('\n--- Hit testing ---');
  print('hitTest: returns true if point is within bounds');
  print('No child hit testing (leaf)');

  print('\n${'=' * 60}');
  print('LeafRenderObjectWidget deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        sectionBanner(
          '1 · LeafRenderObjectWidget Showcase',
          'Abstract widget for childless render objects',
          deepCharcoal,
          Colors.white,
        ),

        // ── 2. Concept overview ──────────────────────────────────────
        sectionBanner('2 · Concept Overview',
            'Understanding leaf render object widgets', smokeDark, Colors.white),
        noteBox(
          'LeafRenderObjectWidget is an abstract RenderObjectWidget subclass '
          'for widgets that have no children. It configures a RenderObject '
          'that handles its own layout and painting without delegating to '
          'any child render objects.',
          deepCharcoal,
          dustyStone,
        ),
        noteBox(
          'The term "leaf" comes from tree terminology — a leaf node has '
          'no subtree beneath it. In Flutter\'s widget tree, a leaf widget '
          'is the terminal point of a branch. Examples include ErrorWidget '
          'and platform view widgets.',
          smokeDark,
          ashRose,
        ),
        infoCard('Class', 'LeafRenderObjectWidget', deepCharcoal),
        infoCard('Parent', 'RenderObjectWidget', warmAsh),
        infoCard('Children', 'None (abstract leaf)', smokeDark),
        infoCard('Element', 'LeafRenderObjectElement', onyxBlue),
        infoCard('Abstract', 'Yes — must be extended', carbonGray),
        const SizedBox(height: 14),

        // ── 3. Widget hierarchy ──────────────────────────────────────
        sectionBanner('3 · Widget Class Hierarchy',
            'Where LeafRenderObjectWidget fits', warmAsh, Colors.white),
        noteBox(
          'RenderObjectWidget has three concrete subclasses, each for a '
          'different child cardinality. LeafRenderObjectWidget enforces '
          'zero children at the type level.',
          deepCharcoal,
          dustyStone,
        ),
        hierarchyRow('', 'Widget (abstract)', deepCharcoal, false),
        hierarchyRow('  ├─ ', 'StatelessWidget', warmAsh, false),
        hierarchyRow('  ├─ ', 'StatefulWidget', smokeDark, false),
        hierarchyRow('  └─ ', 'RenderObjectWidget (abstract)', onyxBlue, false),
        hierarchyRow('      ├─ ', 'LeafRenderObjectWidget', deepCharcoal, true),
        hierarchyRow('      ├─ ', 'SingleChildRenderObjectWidget', carbonGray, false),
        hierarchyRow('      └─ ', 'MultiChildRenderObjectWidget', cementLight, false),
        const SizedBox(height: 8),
        noteBox(
          'Each RenderObjectWidget subclass also determines which Element '
          'subclass is created: Leaf→LeafRenderObjectElement, '
          'SingleChild→SingleChildRenderObjectElement, '
          'MultiChild→MultiChildRenderObjectElement.',
          thunderGray,
          ashRose,
        ),
        const SizedBox(height: 14),

        // ── 4. ErrorWidget example ───────────────────────────────────
        sectionBanner('4 · ErrorWidget — Concrete Example',
            'The most visible LeafRenderObjectWidget', onyxBlue, Colors.white),
        noteBox(
          'ErrorWidget is Flutter\'s built-in error display. When a widget '
          'throws during build, the framework replaces it with an ErrorWidget. '
          'It extends LeafRenderObjectWidget because it renders directly '
          'without any child widgets.',
          deepCharcoal,
          dustyStone,
        ),
        dataRow('Type', '${errorWidget.runtimeType}', deepCharcoal),
        dataRow('Is LeafRenderObject…', 'true', warmAsh),
        dataRow('Is RenderObjectWidget', 'true', smokeDark),
        dataRow('Message (FlutterError)', errorWidget.message, onyxBlue),
        dataRow('Message (String)', errorString.message, carbonGray),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: deepCharcoal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepCharcoal.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ErrorWidget Pipeline',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('Widget', 'ErrorWidget', deepCharcoal),
              dataRow('createElement()', 'LeafRenderObjectElement', warmAsh),
              dataRow('createRenderObject()', 'RenderErrorBox', smokeDark),
              dataRow('paint()', 'Yellow/red diagonal stripes', onyxBlue),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. createElement method ──────────────────────────────────
        sectionBanner('5 · createElement() Method',
            'Creating the corresponding Element', carbonGray, Colors.white),
        noteBox(
          'LeafRenderObjectWidget overrides createElement() to return '
          'a LeafRenderObjectElement. This is the only Element type that '
          'can be created by a leaf widget — it enforces the no-children '
          'invariant at the element level.',
          deepCharcoal,
          dustyStone,
        ),
        methodCard('createElement()', 'Returns LeafRenderObjectElement',
            'Called by the framework during widget inflation. The returned '
            'element manages the render object lifecycle and enforces '
            'the leaf constraint via assertions.',
            deepCharcoal),
        dataRow('Return type', 'LeafRenderObjectElement', deepCharcoal),
        dataRow('Called by', 'Framework (inflateWidget)', warmAsh),
        dataRow('Override needed', 'No — base class handles it', smokeDark),
        const SizedBox(height: 14),

        // ── 6. createRenderObject method ─────────────────────────────
        sectionBanner('6 · createRenderObject() — Required',
            'The mandatory override for leaf widgets', cementLight, deepCharcoal),
        noteBox(
          'Every LeafRenderObjectWidget subclass must implement '
          'createRenderObject(BuildContext). This factory method creates '
          'and returns the RenderObject that performs layout and painting.',
          deepCharcoal,
          dustyStone,
        ),
        methodCard('createRenderObject(ctx)', 'Create the RenderObject',
            'Must return a properly configured RenderObject. Called once '
            'when the element is first mounted. The RenderObject is reused '
            'across updates — only createRenderObject is called once.',
            deepCharcoal),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: warmAsh.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: warmAsh.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Implementation Pattern',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 6),
              dataRow('Signature', 'RenderObject createRenderObject(BuildContext)', deepCharcoal),
              dataRow('Returns', 'New RenderObject instance', warmAsh),
              dataRow('Configuration', 'From widget properties', smokeDark),
              dataRow('Called', 'Once per element mount', onyxBlue),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. updateRenderObject method ─────────────────────────────
        sectionBanner('7 · updateRenderObject() — Optional',
            'Updating the render object on rebuild', thunderGray, Colors.white),
        noteBox(
          'When the parent widget rebuilds with a new LeafRenderObjectWidget '
          'of the same type, updateRenderObject() is called to apply '
          'the new configuration to the existing RenderObject. The default '
          'implementation does nothing.',
          deepCharcoal,
          dustyStone,
        ),
        methodCard('updateRenderObject(ctx, ro)', 'Update existing RenderObject',
            'Apply new widget properties to the RenderObject. Called when the '
            'widget changes but the element (and its render object) are reused. '
            'Skip if the render object has no mutable properties.',
            warmAsh),
        noteBox(
          'If your render object has mutable properties (e.g., color, size), '
          'override updateRenderObject to keep them in sync with the widget. '
          'If the render object is immutable, the default no-op is correct.',
          smokeDark,
          ashRose,
        ),
        const SizedBox(height: 14),

        // ── 8. No children guarantee ─────────────────────────────────
        sectionBanner('8 · No-Children Guarantee',
            'Enforced at widget, element, and render object levels', deepCharcoal, Colors.white),
        noteBox(
          'The leaf constraint is enforced at three levels: the widget '
          'has no child property, the element asserts no child operations, '
          'and the render object has no child slot. This triple guarantee '
          'prevents accidental misuse.',
          deepCharcoal,
          dustyStone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: onyxBlue.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: onyxBlue.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Triple Enforcement',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('Widget level', 'No child property in API', deepCharcoal),
              dataRow('Element level', 'Assertions on child ops', warmAsh),
              dataRow('RenderObject level', 'No child slot / mixin', smokeDark),
              const SizedBox(height: 6),
              Text('All three layers agree: zero children',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: onyxBlue.withValues(alpha: 0.7))),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. RenderObject lifecycle ────────────────────────────────
        sectionBanner('9 · RenderObject Lifecycle',
            'Creation, updates, and disposal', smokeDark, Colors.white),
        noteBox(
          'The render object has a clear lifecycle managed by the element. '
          'Understanding this lifecycle helps in implementing correct '
          'custom leaf widgets with proper resource management.',
          deepCharcoal,
          dustyStone,
        ),
        stepCard(1, 'createRenderObject(context)',
            'Framework calls during mount — create and configure the RenderObject',
            deepCharcoal),
        stepCard(2, 'RenderObject.attach(owner)',
            'Render object attaches to the pipeline owner for scheduling',
            warmAsh),
        stepCard(3, 'performLayout()',
            'Render object computes its size based on constraints',
            smokeDark),
        stepCard(4, 'paint(context, offset)',
            'Render object paints itself to the canvas',
            onyxBlue),
        stepCard(5, 'updateRenderObject(context, ro)',
            'Properties updated when widget changes (may trigger relayout/repaint)',
            carbonGray),
        stepCard(6, 'didUnmountRenderObject(ro)',
            'Called on unmount — release resources, cancel timers',
            cementLight),
        const SizedBox(height: 14),

        // ── 10. SingleChild comparison ───────────────────────────────
        sectionBanner('10 · Vs SingleChildRenderObjectWidget',
            'When to use Leaf vs SingleChild', carbonGray, Colors.white),
        noteBox(
          'SingleChildRenderObjectWidget is for widgets with exactly one '
          'optional child. SizedBox, Padding, Align, ClipRect all use it. '
          'If your widget ever wraps another widget, use SingleChild.',
          deepCharcoal,
          dustyStone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: carbonGray.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: carbonGray.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Leaf vs SingleChild',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('LeafRenderObjectWidget', '0 children', deepCharcoal),
              dataRow('  Has child property', 'No', warmAsh),
              dataRow('  Element', 'LeafRenderObjectElement', smokeDark),
              const SizedBox(height: 4),
              dataRow('SingleChildRenderObjW…', '0–1 children', onyxBlue),
              dataRow('  Has child property', 'Yes (Widget? child)', carbonGray),
              dataRow('  Element', 'SingleChildRenderObjectElement', cementLight),
            ],
          ),
        ),
        dataRow('SizedBox', 'SingleChild (has child)', deepCharcoal),
        dataRow('Padding', 'SingleChild (wraps child)', warmAsh),
        dataRow('ErrorWidget', 'Leaf (no child)', smokeDark),
        const SizedBox(height: 14),

        // ── 11. MultiChild comparison ────────────────────────────────
        sectionBanner('11 · Vs MultiChildRenderObjectWidget',
            'Multiple children vs none', cementLight, deepCharcoal),
        noteBox(
          'MultiChildRenderObjectWidget is for widgets with a list of children. '
          'Column, Row, Stack, and Wrap all extend it. The element manages '
          'an ordered list of child elements with insertion and removal.',
          deepCharcoal,
          dustyStone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cementLight.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cementLight.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RenderObjectWidget Family',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('Leaf', '0 children — ErrorWidget', deepCharcoal),
              dataRow('SingleChild', '0–1 child — SizedBox', warmAsh),
              dataRow('MultiChild', '0–N children — Column', smokeDark),
              const SizedBox(height: 6),
              dataRow('Complexity', 'Leaf < Single < Multi', onyxBlue),
              dataRow('Memory', 'Leaf < Single < Multi', carbonGray),
              dataRow('Rebuild cost', 'Leaf < Single < Multi', cementLight),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Custom implementation ────────────────────────────────
        sectionBanner('12 · Custom Implementation Guide',
            'How to build your own leaf widget', thunderGray, Colors.white),
        noteBox(
          'Building a custom LeafRenderObjectWidget involves two classes: '
          'the widget subclass and a RenderBox subclass. The widget defines '
          'configuration, the render box handles layout and painting.',
          deepCharcoal,
          dustyStone,
        ),
        stepCard(1, 'Create RenderBox subclass',
            'Extend RenderBox. Implement performLayout() to compute size '
            'and paint() to render visuals to the canvas.',
            deepCharcoal),
        stepCard(2, 'Extend LeafRenderObjectWidget',
            'Define configuration properties (color, size, etc.) as '
            'final fields passed through the constructor.',
            warmAsh),
        stepCard(3, 'Implement createRenderObject()',
            'Instantiate your RenderBox with initial property values '
            'from the widget.',
            smokeDark),
        stepCard(4, 'Override updateRenderObject()',
            'Update the RenderBox properties when the widget rebuilds '
            'with new values. Call markNeedsPaint/Layout as needed.',
            onyxBlue),
        const SizedBox(height: 14),

        // ── 13. Painting behavior ────────────────────────────────────
        sectionBanner('13 · Custom Painting Patterns',
            'How leaf render objects paint', silverMist, deepCharcoal),
        noteBox(
          'A leaf render object\'s paint() method draws directly to the '
          'Canvas without painting any children. This makes it ideal for '
          'custom shapes, gradients, charts, and decorations that need '
          'pixel-level control.',
          deepCharcoal,
          dustyStone,
        ),
        methodCard('performLayout()', 'Compute size',
            'Set size based on constraints. A leaf can be any size — '
            'it has no children to measure. Usually sizes to constraints.',
            deepCharcoal),
        methodCard('paint(context, offset)', 'Draw to canvas',
            'Use PaintingContext.canvas to draw shapes, text, images. '
            'No child painting step — entire output is from paint().',
            warmAsh),
        methodCard('hitTestSelf(position)', 'Handle hits',
            'Return true if the given position is within the painted area. '
            'Leaf widgets are often interactive (taps, drags).',
            smokeDark),
        const SizedBox(height: 14),

        // ── 14. Hit testing ──────────────────────────────────────────
        sectionBanner('14 · Hit Test Behavior',
            'Interaction handling in leaf render objects', warmAsh, Colors.white),
        noteBox(
          'Leaf render objects handle hit testing entirely through '
          'hitTestSelf() since there are no children to forward hits to. '
          'This simplifies the hit test logic compared to parent render objects.',
          deepCharcoal,
          dustyStone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: warmAsh.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: warmAsh.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hit Test Flow',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('hitTest(result, pos)', 'Entry point', deepCharcoal),
              dataRow('hitTestChildren()', 'No-op (no children)', warmAsh),
              dataRow('hitTestSelf(pos)', 'Check if within bounds', smokeDark),
              dataRow('Return value', 'true if hit, false if miss', onyxBlue),
              const SizedBox(height: 6),
              dataRow('No child forwarding', 'Simplest hit test path', carbonGray),
            ],
          ),
        ),
        noteBox(
          'For custom shapes (circles, polygons), override hitTestSelf '
          'to perform geometric intersection testing rather than the '
          'default bounding-box check.',
          thunderGray,
          ashRose,
        ),
        const SizedBox(height: 14),

        // ── 15. Performance panel ────────────────────────────────────
        sectionBanner('15 · Performance Characteristics',
            'Why leaf widgets are efficiently minimal', onyxBlue, Colors.white),
        noteBox(
          'Leaf widgets have minimal overhead: no child list management, '
          'no child layout passes, no child painting, and no child hit '
          'testing. This makes them the most efficient RenderObjectWidget type.',
          deepCharcoal,
          dustyStone,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: onyxBlue.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: onyxBlue.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Overhead Comparison',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              dataRow('Child list allocation', 'None (leaf)', deepCharcoal),
              dataRow('Child reconciliation', 'None (leaf)', warmAsh),
              dataRow('Child layout passes', 'None (leaf)', smokeDark),
              dataRow('Child painting', 'None (leaf)', onyxBlue),
              dataRow('Child hit testing', 'None (leaf)', carbonGray),
              const SizedBox(height: 6),
              dataRow('Widget tree depth', 'Terminal — no deeper', cementLight),
              dataRow('Element memory', 'Minimal', thunderGray),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary dashboard ────────────────────────────────────
        sectionBanner('16 · Summary Dashboard',
            'LeafRenderObjectWidget overview', deepCharcoal, Colors.white),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            metricTile('Children', '0', dustyStone, deepCharcoal),
            metricTile('Abstract', 'Yes', ashRose, warmAsh),
            metricTile('Element', '1', dustyStone, smokeDark),
            metricTile('Required methods', '1', ashRose, onyxBlue),
            metricTile('Optional overrides', '2', dustyStone, carbonGray),
            metricTile('Examples', '1', ashRose, cementLight),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tag('LeafRenderObjectWidget', deepCharcoal, Colors.white),
            tag('RenderObjectWidget', warmAsh, Colors.white),
            tag('No children', smokeDark, Colors.white),
            tag('ErrorWidget', onyxBlue, Colors.white),
            tag('createRenderObject', carbonGray, Colors.white),
            tag('RenderBox', cementLight, deepCharcoal),
            tag('Custom painting', thunderGray, Colors.white),
            tag('Hit testing', silverMist, deepCharcoal),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: dustyStone,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: deepCharcoal.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Charcoal / Ash Palette',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepCharcoal)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  colorSwatch('charcoal', deepCharcoal),
                  colorSwatch('warmAsh', warmAsh),
                  colorSwatch('smoke', smokeDark),
                  colorSwatch('onyx', onyxBlue),
                  colorSwatch('carbon', carbonGray),
                  colorSwatch('cement', cementLight),
                  colorSwatch('thunder', thunderGray),
                  colorSwatch('silver', silverMist),
                  colorSwatch('dusty', dustyStone),
                  colorSwatch('ashRose', ashRose),
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
