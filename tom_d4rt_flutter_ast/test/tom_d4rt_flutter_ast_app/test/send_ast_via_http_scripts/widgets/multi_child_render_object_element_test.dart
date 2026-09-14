// ignore_for_file: avoid_print
// D4rt deep demo: MultiChildRenderObjectElement — manages child elements for multi-child render objects
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Arctic / Glacier ──────────────────────────────────────
  const deepArctic = Color(0xFF0C4A6E);
  const arcticBlue = Color(0xFF0369A1);
  const glacier = Color(0xFF0284C7);
  const skyBlue = Color(0xFF0EA5E9);
  const lightIce = Color(0xFF7DD3FC);
  const paleIce = Color(0xFFE0F2FE);
  const frostWhite = Color(0xFFF0F9FF);
  const slateBlue = Color(0xFF1E3A5F);
  const warmAmber = Color(0xFFD97706);
  const coralAccent = Color(0xFFEF4444);

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
          style: TextStyle(fontSize: 13, color: deepArctic)),
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
                style: TextStyle(fontSize: 13, color: deepArctic)),
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
  print('MultiChildRenderObjectElement deep demo executing');
  print('=' * 60);

  // Build a simple Column to examine how it produces elements
  final columnWidget = Column(
    children: [
      const Text('Alpha'),
      const Text('Beta'),
      const Text('Gamma'),
    ],
  );

  print('\n--- What is MultiChildRenderObjectElement ---');
  print('Element counterpart of MultiChildRenderObjectWidget');
  print('Manages a list of child Element objects');
  print('Created by widgets like Column, Row, Stack, Wrap');

  print('\n--- Column children count ---');
  print('Column has ${columnWidget.children.length} children');

  print('\n--- Element lifecycle ---');
  print('mount() → inflates all children sequentially');
  print('update() → diffs old/new child lists efficiently');
  print('forgetChild() → marks child as forgotten (O(1))');

  print('\n${'=' * 60}');
  print('MultiChildRenderObjectElement deep demo completed');

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
              colors: [deepArctic, arcticBlue, glacier],
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
                  Icon(Icons.account_tree, size: 28, color: paleIce),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('MultiChildRenderObject\nElement',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Element that manages a list of children for multi-child render objects',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('RenderObjectElement', glacier, Colors.white),
                tag('Child List', skyBlue, Colors.white),
                tag('IndexedSlot', paleIce, deepArctic),
                tag('Diffing', lightIce, deepArctic),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MultiChildRenderObjectElement',
            'The element half of the multi-child widget pattern',
            deepArctic, Colors.white),
        noteBox(
          'MultiChildRenderObjectElement is the Element counterpart of '
          'MultiChildRenderObjectWidget. In Flutter\'s three-tree architecture '
          '(Widget \u2192 Element \u2192 RenderObject), this class sits in the '
          'middle: it receives a list of child Widgets from the Widget tree, '
          'inflates them into child Elements, and manages their corresponding '
          'RenderObjects in the render tree. Every Column, Row, Stack, Wrap, '
          'and Flex widget creates one of these elements automatically.',
          glacier,
          frostWhite,
        ),
        dataRow('Extends', 'RenderObjectElement', glacier),
        dataRow('Created by', 'MultiChildRenderObjectWidget.createElement()', arcticBlue),
        dataRow('Render object', 'ContainerRenderObjectMixin', deepArctic),
        dataRow('Defined in', 'widgets/framework.dart', slateBlue),
        const SizedBox(height: 14),

        // ── 3. Three-tree diagram ────────────────────────────────────
        sectionBanner('2 \u00b7 Three-Tree Architecture',
            'Where this element fits in Widget \u2192 Element \u2192 RenderObject',
            arcticBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleIce),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widget tree
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: glacier.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: glacier),
                  ),
                  child: Column(
                    children: [
                      Text('Widget Tree',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: glacier)),
                      const SizedBox(height: 6),
                      for (final w in ['Column', '  Text A', '  Text B', '  Text C'])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(w,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: deepArctic)),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Icon(Icons.arrow_forward, size: 14, color: arcticBlue),
                    Text('creates',
                        style: TextStyle(fontSize: 7, color: arcticBlue)),
                  ],
                ),
              ),
              // Element tree
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: warmAmber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmAmber),
                  ),
                  child: Column(
                    children: [
                      Text('Element Tree',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: warmAmber)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: warmAmber.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('MCROB\nElement',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                color: warmAmber)),
                      ),
                      for (final e in ['  Txt Elem A', '  Txt Elem B', '  Txt Elem C'])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(e,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: slateBlue)),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Icon(Icons.arrow_forward, size: 14, color: coralAccent),
                    Text('manages',
                        style: TextStyle(fontSize: 7, color: coralAccent)),
                  ],
                ),
              ),
              // Render tree
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: coralAccent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: coralAccent),
                  ),
                  child: Column(
                    children: [
                      Text('Render Tree',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: coralAccent)),
                      const SizedBox(height: 6),
                      for (final r in ['RenderFlex', '  RenderPara A', '  RenderPara B', '  RenderPara C'])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(r,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: deepArctic)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Widgets that create this element ──────────────────────
        sectionBanner('3 \u00b7 Widgets That Create This Element',
            'Common MultiChildRenderObjectWidgets',
            glacier, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final widget in [
                ('Column', 'Vertical list of children', 'RenderFlex',
                    Icons.view_agenda, glacier),
                ('Row', 'Horizontal list of children', 'RenderFlex',
                    Icons.view_column, arcticBlue),
                ('Stack', 'Overlapping children', 'RenderStack',
                    Icons.layers, skyBlue),
                ('Wrap', 'Flow layout with wrapping', 'RenderWrap',
                    Icons.wrap_text, slateBlue),
                ('Flex', 'Flexible layout (base of Row/Column)', 'RenderFlex',
                    Icons.view_stream, deepArctic),
                ('IndexedStack', 'Stack showing one child', 'RenderIndexedStack',
                    Icons.filter_1, warmAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: widget.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(widget.$4, size: 20, color: widget.$5),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 85,
                        child: Text(widget.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: widget.$5)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepArctic)),
                            Text('\u2192 ${widget.$3}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: slateBlue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        // Live widgets producing this element
        noteBox(
          'Every one of these widgets calls createElement() which returns a '
          'MultiChildRenderObjectElement. The element then inflates each '
          'child Widget in the children list into a child Element.',
          skyBlue,
          frostWhite,
        ),
        const SizedBox(height: 14),

        // ── 5. Live demo: Column producing elements ──────────────────
        sectionBanner('4 \u00b7 Live Demo: Column With Children',
            'A Column widget and the element tree it produces',
            skyBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleIce),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Column(children: [Text("Alpha"), Text("Beta"), Text("Gamma")])',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: glacier)),
              const SizedBox(height: 10),
              // The actual column
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: glacier.withValues(alpha: 0.05),
                  border: Border.all(color: glacier),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    for (final label in ['Alpha', 'Beta', 'Gamma'])
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: arcticBlue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: arcticBlue.withValues(alpha: 0.3)),
                        ),
                        child: Text(label,
                            style: TextStyle(
                                fontSize: 13, color: deepArctic)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('This Column creates a MultiChildRenderObjectElement with 3 child elements.',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: slateBlue)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. IndexedSlot system ────────────────────────────────────
        sectionBanner('5 \u00b7 IndexedSlot System',
            'How children track their position',
            arcticBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noteBox(
                'Each child element is assigned an IndexedSlot<Element?> containing '
                'its index in the list and a reference to the previous sibling element. '
                'This enables efficient render object insertion — each child knows which '
                'sibling it should be inserted after.',
                arcticBlue,
                paleIce,
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < 3; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (i == 0 ? glacier : i == 1 ? arcticBlue : skyBlue)
                        .withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(
                        color: i == 0 ? glacier : i == 1 ? arcticBlue : skyBlue,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i == 0 ? glacier : i == 1 ? arcticBlue : skyBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('$i',
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
                            Text('IndexedSlot(index: $i, value: ${i == 0 ? "null" : "child[${i - 1}]"})',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: deepArctic)),
                            Text(i == 0
                                ? 'First child — no previous sibling'
                                : 'Inserted after child[${i - 1}] in render object',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: slateBlue)),
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

        // ── 7. Lifecycle: mount ──────────────────────────────────────
        sectionBanner('6 \u00b7 Lifecycle: mount()',
            'How children are inflated when the element is first created',
            deepArctic, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Element created', 'MultiChildRenderObjectWidget.createElement() called',
                    glacier),
                (2, 'mount(parent, slot)', 'Element attaches to the element tree',
                    arcticBlue),
                (3, 'super.mount()', 'Creates the RenderObject via createRenderObject()',
                    skyBlue),
                (4, 'For each child widget', 'Iterates over widget.children list',
                    slateBlue),
                (5, 'inflateWidget(child, slot)', 'Creates child Element with IndexedSlot',
                    deepArctic),
                (6, 'Children list built', 'All child elements stored in _children list',
                    warmAmber),
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
                                    color: deepArctic)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: slateBlue)),
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

        // ── 8. Lifecycle: update ─────────────────────────────────────
        sectionBanner('7 \u00b7 Lifecycle: update()',
            'Efficient child list diffing when widget rebuilds',
            glacier, Colors.white),
        noteBox(
          'When a parent widget rebuilds and provides a new list of children, '
          'the element\'s update() method is called. It uses updateChildren() '
          'to efficiently diff the old and new child lists, reusing existing '
          'elements where possible (matched by widget type + key). '
          'This avoids destroying and recreating child elements unnecessarily.',
          glacier,
          frostWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepArctic),
                children: [
                  for (final h in ['Scenario', 'Old Children', 'New Children'])
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
                ('Same list', '[A, B, C]', '[A, B, C] \u2192 reuse all'),
                ('Appended', '[A, B]', '[A, B, C] \u2192 reuse 2, inflate 1'),
                ('Removed', '[A, B, C]', '[A, C] \u2192 reuse 2, deactivate 1'),
                ('Reordered', '[A(k1), B(k2)]', '[B(k2), A(k1)] \u2192 move by key'),
                ('Replaced', '[A, B]', '[X, Y] \u2192 deactivate 2, inflate 2'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: glacier)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: slateBlue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: arcticBlue)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. The _forgottenChildren optimization ───────────────────
        sectionBanner('8 \u00b7 Forgotten Children Optimization',
            'O(1) child removal via HashSet',
            slateBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
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
                        color: coralAccent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: coralAccent),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.dangerous, size: 22, color: coralAccent),
                          const SizedBox(height: 4),
                          Text('Without HashSet',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: coralAccent)),
                          Text('O(n\u00b2) to remove\nchildren from list',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: deepArctic)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: glacier.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: glacier),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, size: 22, color: glacier),
                          const SizedBox(height: 4),
                          Text('With HashSet',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: glacier)),
                          Text('O(1) per forget +\nfiltered on visit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: deepArctic)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'forgetChild(Element child) adds the child to a _forgottenChildren '
                'HashSet instead of removing it from the list. visitChildren() and '
                'the children getter then skip forgotten elements. This converts '
                'removal from O(n) list scan to O(1) set add.',
                slateBlue,
                paleIce,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Render object child operations ───────────────────────
        sectionBanner('9 \u00b7 Render Object Child Operations',
            'How child render objects are inserted, moved, and removed',
            arcticBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final op in [
                ('insertRenderObjectChild', 'Inserts child RO into container after the sibling in slot',
                    'Called when a new child element is inflated',
                    Icons.add_circle_outline, glacier),
                ('moveRenderObjectChild', 'Moves child RO from oldSlot to newSlot position',
                    'Called when children are reordered by key',
                    Icons.swap_horiz, arcticBlue),
                ('removeRenderObjectChild', 'Removes child RO from the container',
                    'Called when a child element is deactivated',
                    Icons.remove_circle_outline, coralAccent),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: op.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: op.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(op.$4, size: 22, color: op.$5),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(op.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: op.$5)),
                            Text(op.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepArctic)),
                            Text(op.$3,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: slateBlue.withValues(alpha: 0.7))),
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

        // ── 11. Live demo: Stack producing overlapping children ──────
        sectionBanner('10 \u00b7 Live Demo: Stack With Layers',
            'A Stack widget producing overlapping positioned children',
            skyBlue, Colors.white),
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleIce),
          ),
          child: Stack(
            children: [
              // Background layer
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        deepArctic.withValues(alpha: 0.1),
                        glacier.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Layer 1
              Positioned(
                left: 20,
                top: 20,
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: glacier.withValues(alpha: 0.3),
                    border: Border.all(color: glacier, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text('Layer 0',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: glacier)),
                ),
              ),
              // Layer 2
              Positioned(
                left: 80,
                top: 40,
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: arcticBlue.withValues(alpha: 0.3),
                    border: Border.all(color: arcticBlue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text('Layer 1',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: arcticBlue)),
                ),
              ),
              // Layer 3
              Positioned(
                left: 140,
                top: 60,
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: skyBlue.withValues(alpha: 0.3),
                    border: Border.all(color: skyBlue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text('Layer 2',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: skyBlue)),
                ),
              ),
              // Label
              Positioned(
                right: 10,
                top: 10,
                child: tag('Stack children', deepArctic, Colors.white),
              ),
            ],
          ),
        ),
        noteBox(
          'This Stack widget creates a MultiChildRenderObjectElement that '
          'manages 4 child elements (background + 3 layers). Each layer is '
          'a Positioned child with its own IndexedSlot.',
          skyBlue,
          frostWhite,
        ),
        const SizedBox(height: 14),

        // ── 12. Key-based child matching ─────────────────────────────
        sectionBanner('11 \u00b7 Key-Based Child Matching',
            'How keys enable efficient child reordering',
            deepArctic, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final scenario in [
                ('Without keys', 'Children matched by position only. Reordering destroys and recreates elements.',
                    coralAccent, Icons.shuffle),
                ('With ValueKey', 'Children matched by key. Reordering moves existing elements without recreation.',
                    glacier, Icons.vpn_key),
                ('With ObjectKey', 'Like ValueKey but uses object identity. Useful for model-based lists.',
                    arcticBlue, Icons.fingerprint),
                ('With GlobalKey', 'Element can move across different parents. Most expensive but most flexible.',
                    warmAmber, Icons.public),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$3, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(scenario.$4, size: 20, color: scenario.$3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: scenario.$3)),
                            Text(scenario.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepArctic)),
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

        // ── 13. Companion classes ────────────────────────────────────
        sectionBanner('12 \u00b7 Companion Element Types',
            'The three element types for RenderObjectWidgets',
            glacier, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final companion in [
                ('LeafRenderObjectElement', 'No children', 'SizedBox, ColoredBox',
                    skyBlue),
                ('SingleChildRenderObjectElement', 'One child', 'Opacity, Transform',
                    arcticBlue),
                ('MultiChildRenderObjectElement', 'Multiple children', 'Column, Row, Stack',
                    glacier),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: companion.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: companion.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(companion.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: companion.$4)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(companion.$2,
                            style: TextStyle(
                                fontSize: 11, color: deepArctic)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(companion.$3,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: slateBlue)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Live demo: Wrap with flowing children ────────────────
        sectionBanner('13 \u00b7 Live Demo: Wrap Layout',
            'A Wrap widget managing flowing child elements',
            arcticBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleIce),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var i = 0; i < 12; i++)
                Container(
                  width: 60 + (i % 3) * 20.0,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(glacier, skyBlue, i / 11.0) ?? glacier,
                        Color.lerp(arcticBlue, lightIce, i / 11.0) ?? arcticBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text('Item $i',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
        noteBox(
          'This Wrap creates a MultiChildRenderObjectElement managing 12 '
          'child elements. The RenderWrap render object handles the '
          'flowing layout, while the element handles child lifecycle.',
          arcticBlue,
          frostWhite,
        ),
        const SizedBox(height: 14),

        // ── 15. Class hierarchy ──────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Where MultiChildRenderObjectElement sits',
            deepArctic, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 DiagnosticableTree', 1, Colors.grey),
                ('    \u2514\u2500 Element', 2, slateBlue),
                ('        \u2514\u2500 ComponentElement', 3, Colors.grey),
                ('        \u2514\u2500 RenderObjectElement', 3, arcticBlue),
                ('            \u2514\u2500 LeafRenderObjectElement', 4, skyBlue),
                ('            \u2514\u2500 SingleChildRenderObjectElement', 4, skyBlue),
                ('            \u2514\u2500 MultiChildRenderObjectElement', 4, glacier),
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
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepArctic, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepArctic, arcticBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Element counterpart of MultiChildRenderObjectWidget',
                'Manages a list of child Element objects in the element tree',
                'Created by Column, Row, Stack, Wrap, Flex, IndexedStack',
                'Uses IndexedSlot<Element?> for ordered child positioning',
                'mount() inflates all children sequentially with indexed slots',
                'update() uses updateChildren() for efficient list diffing',
                'Key-based matching enables child reuse across rebuilds',
                'forgetChild() uses HashSet for O(1) removal optimization',
                'insertRenderObjectChild/moveRenderObjectChild/removeRenderObjectChild',
                'Render object must implement ContainerRenderObjectMixin',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightIce,
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
