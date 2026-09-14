// ignore_for_file: avoid_print
// D4rt deep demo: MultiChildRenderObjectWidget — abstract base for widgets with multiple children
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Brass / Antique ───────────────────────────────────────
  const deepBrass = Color(0xFF6B4226);
  const warmBrass = Color(0xFF8B6914);
  const antiqueGold = Color(0xFFC49A02);
  const polishedBrass = Color(0xFFD4A017);
  const lightBrass = Color(0xFFE8C547);
  const paleBrass = Color(0xFFF5E6B8);
  const creamAntique = Color(0xFFFDF8E8);
  const darkWalnut = Color(0xFF3E2723);
  const mossGreen = Color(0xFF558B2F);
  const berryRed = Color(0xFFC62828);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkWalnut)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkWalnut)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('MultiChildRenderObjectWidget deep demo executing');
  print('=' * 60);

  print('\n--- What is MultiChildRenderObjectWidget ---');
  print('Abstract base class for widgets that configure RenderObjects');
  print('with multiple child render objects');

  final exampleRow = Row(
    children: [
      const Text('A'),
      const Text('B'),
      const Text('C'),
    ],
  );
  print('\n--- Row children count ---');
  print('Row has ${exampleRow.children.length} children');

  print('\n--- Widget subclasses ---');
  print('Column, Row, Stack, Wrap, Flex are common subclasses');
  print('Each creates a RenderObject with ContainerRenderObjectMixin');
  print('Each returns MultiChildRenderObjectElement from createElement()');

  print('\n--- Abstract methods ---');
  print('createRenderObject(context) — creates the underlying RenderObject');
  print('updateRenderObject(context, renderObject) — updates config');

  print('\n${'=' * 60}');
  print('MultiChildRenderObjectWidget deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepBrass, warmBrass, antiqueGold],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.widgets, size: 28, color: paleBrass),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('MultiChildRenderObject\nWidget',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Abstract base for widgets that configure RenderObjects holding multiple children',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Abstract Class', polishedBrass, Colors.white),
                tag('RenderObjectWidget', lightBrass, darkWalnut),
                tag('children: List<Widget>', paleBrass, darkWalnut),
                tag('ContainerMixin', antiqueGold, Colors.white),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MultiChildRenderObjectWidget',
            'The abstract base for multi-child layout widgets',
            deepBrass, Colors.white),
        noteBox(
          'MultiChildRenderObjectWidget is an abstract class that provides '
          'a foundation for widgets that have multiple child widgets. It holds '
          'a final List<Widget> of children and produces a '
          'MultiChildRenderObjectElement. Subclasses must implement '
          'createRenderObject() and updateRenderObject() to create and '
          'configure a RenderObject that uses ContainerRenderObjectMixin '
          'to manage child render objects.',
          antiqueGold,
          creamAntique,
        ),
        dataRow('Extends', 'RenderObjectWidget', antiqueGold),
        dataRow('Element type', 'MultiChildRenderObjectElement', warmBrass),
        dataRow('Key property', 'children (final List<Widget>)', deepBrass),
        dataRow('Defined in', 'widgets/framework.dart', darkWalnut),
        const SizedBox(height: 14),

        // ── 3. Where it sits in the hierarchy ────────────────────────
        sectionBanner('2 \u00b7 Widget Hierarchy',
            'Inheritance path to MultiChildRenderObjectWidget',
            warmBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Widget', 0, Colors.grey),
                ('\u2514\u2500 RenderObjectWidget', 1, darkWalnut),
                ('    \u2514\u2500 LeafRenderObjectWidget', 2, mossGreen),
                ('    \u2514\u2500 SingleChildRenderObjectWidget', 2, mossGreen),
                ('    \u2514\u2500 MultiChildRenderObjectWidget', 2, antiqueGold),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 4.0, top: 3, bottom: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: level.$1.contains('MultiChild')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
            ],
          ),
        ),
        noteBox(
          'RenderObjectWidget is the base class for widgets that directly '
          'control a RenderObject. The three subclasses differ by how many '
          'children they support: zero (Leaf), one (Single), or many (Multi).',
          warmBrass,
          creamAntique,
        ),
        const SizedBox(height: 14),

        // ── 4. The three RenderObjectWidget variants ─────────────────
        sectionBanner('3 \u00b7 RenderObjectWidget Variants',
            'Comparing the three child-count specializations',
            antiqueGold, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepBrass),
                children: [
                  for (final h in ['Widget Type', 'Children', 'Examples'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('LeafRenderObjectWidget', 'None',
                    'SizedBox, ColoredBox, RichText', mossGreen),
                ('SingleChildRenderObjectWidget', 'One (child)',
                    'Opacity, DecoratedBox, Padding', warmBrass),
                ('MultiChildRenderObjectWidget', 'Many (children)',
                    'Column, Row, Stack, Wrap', antiqueGold),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              color: row.$4)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkWalnut)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: darkWalnut)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Concrete children property ────────────────────────────
        sectionBanner('4 \u00b7 The children Property',
            'How children are stored and passed',
            deepBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warmBrass.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: warmBrass.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'final List<Widget> children;\n\n'
                    'MultiChildRenderObjectWidget({\n'
                    '  super.key,\n'
                    '  this.children = const <Widget>[],\n'
                    '})',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepBrass)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'The children list is final — it must never be mutated in place. '
                'To change children, return a new widget instance with a new list. '
                'GlobalKey children must not have the same key within the list. '
                'Default value is an empty const list.',
                deepBrass,
                paleBrass,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. createElement() ───────────────────────────────────────
        sectionBanner('5 \u00b7 createElement() Method',
            'How the widget becomes an element',
            warmBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: antiqueGold.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: antiqueGold.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '@override\n'
                    'MultiChildRenderObjectElement createElement() {\n'
                    '  return MultiChildRenderObjectElement(this);\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepBrass)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'This is a concrete method — not abstract. Every '
                'MultiChildRenderObjectWidget returns the same element type. '
                'The element receives the widget and then manages inflating each '
                'child in the children list.',
                warmBrass,
                creamAntique,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Abstract methods subclasses must implement ────────────
        sectionBanner('6 \u00b7 Abstract Methods',
            'What subclasses must implement',
            antiqueGold, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final method in [
                ('createRenderObject(BuildContext context)',
                    'Creates the underlying RenderObject. Must return an object with '
                    'ContainerRenderObjectMixin so the element can manage children.',
                    polishedBrass, Icons.add_box),
                ('updateRenderObject(BuildContext context, RenderObject ro)',
                    'Called when the widget rebuilds with new configuration. Applies '
                    'property changes to the existing render object without recreation.',
                    warmBrass, Icons.update),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: method.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: method.$3, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(method.$4, size: 22, color: method.$3),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(method.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: deepBrass)),
                            const SizedBox(height: 2),
                            Text(method.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkWalnut)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'didUnmountRenderObject() is optional — override it to clean up '
                'resources when the render object is permanently removed.',
                antiqueGold,
                paleBrass,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. ContainerRenderObjectMixin requirement ────────────────
        sectionBanner('7 \u00b7 ContainerRenderObjectMixin',
            'Why the render object needs this mixin',
            deepBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: warmBrass.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: warmBrass),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.list, size: 22, color: warmBrass),
                          const SizedBox(height: 4),
                          Text('ContainerRenderObjectMixin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: warmBrass)),
                          const SizedBox(height: 4),
                          Text('Provides linked list\nof child RenderObjects',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkWalnut)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.add, size: 16, color: darkWalnut),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: antiqueGold.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: antiqueGold),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.data_object, size: 22, color: antiqueGold),
                          const SizedBox(height: 4),
                          Text('ContainerParentDataMixin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: antiqueGold)),
                          const SizedBox(height: 4),
                          Text('Extends ParentData\nwith sibling pointers',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkWalnut)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'ContainerRenderObjectMixin gives the render object insert(), '
                'move(), and remove() operations for child render objects. '
                'ContainerParentDataMixin stores previousSibling/nextSibling '
                'pointers on each child\'s parent data, forming a doubly-linked list.',
                deepBrass,
                paleBrass,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Live demo: Row layout ─────────────────────────────────
        sectionBanner('8 \u00b7 Live Demo: Row With Flex',
            'A Row using MultiChildRenderObjectWidget for horizontal layout',
            polishedBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleBrass),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Row is a MultiChildRenderObjectWidget:',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: warmBrass)),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (var i = 0; i < 4; i++)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: i > 0 ? 6 : 0),
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.lerp(deepBrass, antiqueGold, i / 3.0) ??
                                  deepBrass,
                              Color.lerp(warmBrass, lightBrass, i / 3.0) ??
                                  warmBrass,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text('Child $i',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Row \u2192 createRenderObject() \u2192 RenderFlex(direction: Axis.horizontal)',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: darkWalnut)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Live demo: Column layout ─────────────────────────────
        sectionBanner('9 \u00b7 Live Demo: Column Layout',
            'Column — the vertical counterpart',
            warmBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleBrass),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < 4; i++)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: i > 0 ? 6 : 0),
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(antiqueGold, deepBrass, i / 3.0) ??
                            antiqueGold,
                        Color.lerp(polishedBrass, warmBrass, i / 3.0) ??
                            polishedBrass,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Vertical child $i',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
        noteBox(
          'Column extends Flex which extends MultiChildRenderObjectWidget. '
          'Column.createRenderObject() returns RenderFlex with direction: '
          'Axis.vertical.',
          warmBrass,
          creamAntique,
        ),
        const SizedBox(height: 14),

        // ── 11. Widget-to-RenderObject mapping ───────────────────────
        sectionBanner('10 \u00b7 Widget \u2192 RenderObject Mapping',
            'Which render object each subclass creates',
            antiqueGold, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final mapping in [
                ('Column', 'RenderFlex', 'Axis.vertical', Icons.view_agenda,
                    deepBrass),
                ('Row', 'RenderFlex', 'Axis.horizontal', Icons.view_column,
                    warmBrass),
                ('Stack', 'RenderStack', 'overlapping', Icons.layers,
                    antiqueGold),
                ('Wrap', 'RenderWrap', 'flowing', Icons.wrap_text,
                    polishedBrass),
                ('Flex', 'RenderFlex', 'configurable axis', Icons.view_stream,
                    mossGreen),
                ('ListBody', 'RenderListBody', 'sequential', Icons.list,
                    berryRed),
                ('CustomMultiChildLayout', 'RenderCustomMultiChildLayout',
                    'delegate-based', Icons.dashboard, darkWalnut),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: mapping.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(mapping.$4, size: 18, color: mapping.$5),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 70,
                        child: Text(mapping.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: mapping.$5)),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 12, color: darkWalnut),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mapping.$2,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: darkWalnut)),
                            Text(mapping.$3,
                                style: TextStyle(
                                    fontSize: 9, color: darkWalnut)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Live demo: Stack with positioned children ────────────
        sectionBanner('11 \u00b7 Live Demo: Stack With Positioned',
            'Stack positioning children via Positioned widgets',
            deepBrass, Colors.white),
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleBrass),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: deepBrass.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: deepBrass),
                  ),
                  alignment: Alignment.center,
                  child: Text('Back',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: deepBrass)),
                ),
              ),
              Positioned(
                left: 60,
                top: 35,
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: antiqueGold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: antiqueGold),
                  ),
                  alignment: Alignment.center,
                  child: Text('Middle',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: antiqueGold)),
                ),
              ),
              Positioned(
                left: 110,
                top: 60,
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: lightBrass.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: polishedBrass),
                  ),
                  alignment: Alignment.center,
                  child: Text('Front',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warmBrass)),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: tag('Stack', deepBrass, paleBrass),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Children immutability ────────────────────────────────
        sectionBanner('12 \u00b7 Children List Immutability',
            'Why children should never be mutated in-place',
            berryRed, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: berryRed.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: berryRed),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.dangerous, size: 22, color: berryRed),
                          const SizedBox(height: 4),
                          Text('WRONG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: berryRed,
                                  fontSize: 12)),
                          const SizedBox(height: 4),
                          Text('children.add(w)\nchildren.removeAt(0)\nchildren[0] = x',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: berryRed)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: mossGreen.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: mossGreen),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, size: 22, color: mossGreen),
                          const SizedBox(height: 4),
                          Text('CORRECT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mossGreen,
                                  fontSize: 12)),
                          const SizedBox(height: 4),
                          Text('Return new widget\nwith new list\nin build()',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: mossGreen)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'Mutating the children list in place can cause the element tree '
                'to become inconsistent. The framework compares old and new widget '
                'instances — if the same list object is used, it may not detect '
                'changes. Always create a new list for each rebuild.',
                berryRed,
                creamAntique,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Live demo: Wrap ──────────────────────────────────────
        sectionBanner('13 \u00b7 Live Demo: Wrap Layout',
            'Wrap — flowing multi-child layout',
            polishedBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleBrass),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var i = 0; i < 10; i++)
                Container(
                  width: 60 + (i * 5).toDouble(),
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(deepBrass, antiqueGold, i / 9.0) ??
                            deepBrass,
                        Color.lerp(warmBrass, lightBrass, i / 9.0) ??
                            warmBrass,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('Chip $i',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Custom subclass pattern ──────────────────────────────
        sectionBanner('14 \u00b7 Custom Subclass Pattern',
            'How to create your own MultiChildRenderObjectWidget',
            warmBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamAntique,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Define RenderObject', 'Create a RenderBox that mixes in ContainerRenderObjectMixin and ContainerParentDataMixin-based parent data',
                    deepBrass),
                (2, 'Create Widget', 'Extend MultiChildRenderObjectWidget and implement createRenderObject/updateRenderObject',
                    warmBrass),
                (3, 'Handle ParentData', 'Create ParentDataWidget if children need positioning data (like Positioned for Stack)',
                    antiqueGold),
                (4, 'Implement Layout', 'Override performLayout() in your RenderObject to lay out children using the child linked list',
                    polishedBrass),
                (5, 'Implement Paint', 'Override paint() to draw children in order, possibly with custom compositing',
                    lightBrass),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkWalnut)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkWalnut)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepBrass, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepBrass, warmBrass],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Abstract base for widgets with multiple child widgets',
                'Holds a final List<Widget> children property',
                'createElement() returns MultiChildRenderObjectElement',
                'Subclasses must implement createRenderObject() and updateRenderObject()',
                'RenderObject must use ContainerRenderObjectMixin',
                'Children list must never be mutated in place',
                'Column, Row, Stack, Wrap, Flex are all subclasses',
                'Three variants: Leaf (0), Single (1), Multi (many) children',
                'ContainerParentDataMixin stores sibling pointers',
                'Custom subclasses need RenderObject + Widget + optional ParentData',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightBrass,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
