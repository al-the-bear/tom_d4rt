// ignore_for_file: avoid_print
// D4rt deep demo: ListWheelElement — the element behind ListWheelViewport
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Cobalt / Cerulean ─────────────────────────────────────
  const deepCobalt = Color(0xFF1A237E);
  const royalBlue = Color(0xFF283593);
  const vivid = Color(0xFF303F9F);
  const steel = Color(0xFF3949AB);
  const cerulean = Color(0xFF5C6BC0);
  const skyLight = Color(0xFF7986CB);
  const periwinkle = Color(0xFF9FA8DA);
  const iceLavender = Color(0xFFC5CAE9);
  const frostBlue = Color(0xFFE8EAF6);
  const highlightAmber = Color(0xFFFFC107);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(
      String title, String subtitle, Color bg, Color fg) {
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
                  color: fg,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepCobalt)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepCobalt)),
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

  Widget apiCard(
      String name, String returns, String description, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: frostBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: deepCobalt,
                        fontFamily: 'monospace')),
              ),
              tag(returns, accent.withValues(alpha: 0.15), accent),
            ],
          ),
          const SizedBox(height: 4),
          Text(description,
              style: TextStyle(fontSize: 12, color: vivid)),
        ],
      ),
    );
  }

  Widget flowStep(int number, String title, String detail, Color bg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: deepCobalt,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text('$number',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: deepCobalt)),
                const SizedBox(height: 2),
                Text(detail,
                    style: TextStyle(fontSize: 12, color: vivid)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('ListWheelElement deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is ListWheelElement ---');
  print('The Element that powers ListWheelViewport');
  print('Implements ListWheelChildManager');
  print('Manages lazy child creation and disposal');

  // Section 2 — finding a live instance
  print('\n--- Examining a live instance ---');

  // Section 3 — ListWheelChildManager
  print('\n--- ListWheelChildManager interface ---');
  print('childCount getter - how many children exist');
  print('createChild(index) - create/inflate a child at position');
  print('removeChild(renderObject) - remove a specific child');

  // Section 4 — element tree role
  print('\n--- Element tree role ---');
  print('ListWheelScrollView');
  print('  \u2514\u2500 Scrollable');
  print('       \u2514\u2500 Viewport');
  print('            \u2514\u2500 ListWheelViewport (RenderObjectWidget)');
  print('                 \u2514\u2500 ListWheelElement (manages children)');
  print('                      \u2514\u2500 child elements [0..n]');

  // Section 5 — lazy child management
  print('\n--- Lazy child management ---');
  print('Children are created only when scrolled into view');
  print('Off-screen children are recycled or removed');
  print('Delegate.build() is called by the element as needed');

  // Section 6 — rebuild cycle
  print('\n--- Rebuild cycle ---');
  print('1. Scroll event triggers layout');
  print('2. RenderListWheelViewport asks for children');
  print('3. ListWheelElement creates/recycles children via delegate');
  print('4. Only visible children + buffer exist at any time');

  // Section 7 — comparison
  print('\n--- Element vs RenderObject ---');
  print('Element: manages child lifecycle, communicates with delegate');
  print('RenderObject: handles paint, hit-test, layout');

  // Section 8 — summary
  print('\n${'=' * 60}');
  print('ListWheelElement deep demo completed');

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
              colors: [deepCobalt, royalBlue, vivid],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelElement',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('The element that manages children for ListWheelViewport',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Element', steel, Colors.white),
                tag('ChildManager', cerulean, Colors.white),
                tag('Lazy Building', skyLight, deepCobalt),
                tag('Internal', periwinkle, deepCobalt),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is ListWheelElement',
            'The bridge between widget tree and render tree for wheel views',
            deepCobalt, Colors.white),
        noteBox(
          'ListWheelElement is a RenderObjectElement that serves as the '
          'element for ListWheelViewport. It implements the '
          'ListWheelChildManager interface, which the render object uses '
          'to lazily create and remove child elements as the user scrolls. '
          'You never instantiate it directly — Flutter creates it when '
          'ListWheelViewport is mounted into the element tree.',
          deepCobalt,
          frostBlue,
        ),
        dataRow('Extends', 'RenderObjectElement', royalBlue),
        dataRow('Implements', 'ListWheelChildManager', vivid),
        dataRow('Created by', 'ListWheelViewport.createElement()', steel),
        dataRow('Visibility', 'Public but rarely used directly', cerulean),
        const SizedBox(height: 14),

        // ── 3. ListWheelChildManager interface ───────────────────────
        sectionBanner('2 \u00b7 ListWheelChildManager Interface',
            'The contract between element and render object',
            royalBlue, Colors.white),
        noteBox(
          'ListWheelChildManager is the abstract interface that '
          'RenderListWheelViewport uses to communicate child needs back '
          'to the element. It has a small API surface — just enough for '
          'the render object to request children on demand.',
          royalBlue,
          frostBlue,
        ),
        apiCard(
          'childCount',
          'int?',
          'Returns the number of children, or null if infinite '
          '(e.g. looping delegate). The render object uses this to '
          'know when to stop requesting children.',
          deepCobalt,
        ),
        apiCard(
          'createChild(int index, {RenderBox? after})',
          'void',
          'Creates and inserts a child element at the given index. '
          'The element uses delegate.build() to get the widget. Called '
          'by the render object during layout when a new child scrolls '
          'into the visible window.',
          royalBlue,
        ),
        apiCard(
          'removeChild(RenderBox child)',
          'void',
          'Removes and deactivates a child render object. Called when '
          'the child scrolls out of the visible window and is no longer '
          'needed. The element handles unmounting the child widget tree.',
          vivid,
        ),
        const SizedBox(height: 14),

        // ── 4. Element tree position ─────────────────────────────────
        sectionBanner('3 \u00b7 Position in the Widget Tree',
            'Where ListWheelElement sits in the architecture',
            vivid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                ('ListWheelScrollView', 0, false),
                ('  \u2514\u2500 Scrollable', 1, false),
                ('       \u2514\u2500 Viewport', 2, false),
                ('            \u2514\u2500 ListWheelViewport', 3, false),
                ('                 \u2514\u2500 ListWheelElement', 4, true),
                ('                      \u251c\u2500 child[0]', 5, false),
                ('                      \u251c\u2500 child[1]', 5, false),
                ('                      \u251c\u2500 child[2]', 5, false),
                ('                      \u2514\u2500 \u2026 (lazy)', 5, false),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight:
                              line.$3 ? FontWeight.bold : FontWeight.normal,
                          color: line.$3 ? deepCobalt : steel)),
                ),
            ],
          ),
        ),
        noteBox(
          'ListWheelElement is created by ListWheelViewport.createElement(). '
          'It sits between the viewport widget and the individual child '
          'elements, orchestrating which children exist at any moment.',
          vivid,
          frostBlue,
        ),
        const SizedBox(height: 14),

        // ── 5. Lazy child lifecycle ──────────────────────────────────
        sectionBanner('4 \u00b7 Lazy Child Lifecycle',
            'Children are created on scroll and removed when off-screen',
            steel, Colors.white),
        flowStep(1, 'Scroll begins',
            'User drags or flings the wheel. Physics update the scroll offset.',
            frostBlue),
        flowStep(2, 'Layout triggered',
            'RenderListWheelViewport.performLayout() recalculates visible range.',
            iceLavender),
        flowStep(3, 'Request new children',
            'Render object calls createChild(index) for newly visible indices.',
            frostBlue),
        flowStep(4, 'Element builds from delegate',
            'ListWheelElement calls delegate.build(context, index) to get the widget.',
            iceLavender),
        flowStep(5, 'Inflate child element',
            'The widget is inflated into an element and its render object is inserted.',
            frostBlue),
        flowStep(6, 'Remove old children',
            'Render object calls removeChild() for indices that scrolled out of view.',
            iceLavender),
        flowStep(7, 'Element deactivates child',
            'The child element is deactivated and its render object detached.',
            frostBlue),
        flowStep(8, 'Steady state',
            'Only ~5-7 children exist at any moment, regardless of list size.',
            iceLavender),
        const SizedBox(height: 14),

        // ── 6. childCount behavior ───────────────────────────────────
        sectionBanner('5 \u00b7 childCount — Bounded vs Unbounded',
            'How the element reports child count to the render object',
            deepCobalt, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
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
                decoration: BoxDecoration(color: deepCobalt),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Delegate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('childCount',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Meaning',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              for (final row in [
                ('ListDelegate', '= list.length', 'Fixed/bounded'),
                ('BuilderDelegate', '= childCount', 'May be null'),
                ('LoopingDelegate', 'null', 'Infinite/unbounded'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: deepCobalt)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: vivid)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(fontSize: 11, color: steel)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        noteBox(
          'When childCount is null, the render object assumes infinite '
          'children and never stops requesting. When non-null, it uses '
          'the count to define scroll extent and boundaries.',
          deepCobalt,
          frostBlue,
        ),
        const SizedBox(height: 14),

        // ── 7. Live wheel with inspector ─────────────────────────────
        sectionBanner('6 \u00b7 Live Wheel — See the Element at Work',
            'A working wheel that demonstrates lazy child management',
            royalBlue, Colors.white),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cerulean.withValues(alpha: 0.3)),
          ),
          child: Stack(
            children: [
              ListWheelScrollView(
                itemExtent: 48,
                diameterRatio: 1.4,
                perspective: 0.003,
                physics: const FixedExtentScrollPhysics(),
                children: [
                  for (var i = 0; i < 20; i++)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(deepCobalt, cerulean, i / 20)!
                                .withValues(alpha: 0.12),
                            Color.lerp(deepCobalt, cerulean, i / 20)!
                                .withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: cerulean.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.lerp(deepCobalt, cerulean, i / 20),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          Text('Item ${i + 1}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: deepCobalt)),
                          const SizedBox(width: 8),
                          Text('(child element)',
                              style: TextStyle(
                                  fontSize: 11, color: skyLight)),
                        ],
                      ),
                    ),
                ],
              ),
              Center(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: deepCobalt, width: 2),
                      bottom: BorderSide(color: deepCobalt, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        noteBox(
          'Although 20 items exist in the delegate, the ListWheelElement '
          'only inflates ~5-7 child elements at any time. Scroll to see '
          'new children created and old ones removed.',
          royalBlue,
          iceLavender,
        ),
        const SizedBox(height: 14),

        // ── 8. Element vs RenderObject ───────────────────────────────
        sectionBanner('7 \u00b7 Element vs RenderObject Responsibilities',
            'Clear separation of concerns in the rendering pipeline',
            vivid, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
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
                decoration: BoxDecoration(color: deepCobalt),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Aspect',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('ListWheelElement',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('RenderListWheelViewport',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              for (final row in [
                ('Child creation', 'Creates child elements', 'Requests via createChild()'),
                ('Child removal', 'Deactivates elements', 'Requests via removeChild()'),
                ('Layout', 'Delegates to render', 'Cylindrical layout math'),
                ('Painting', 'Not involved', 'Transforms + paints items'),
                ('Hit testing', 'Not involved', 'Cylindrical hit detection'),
                ('Delegate access', 'Calls delegate.build()', 'Calls childManager'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: deepCobalt)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(fontSize: 11, color: vivid)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(fontSize: 11, color: steel)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Render pipeline ───────────────────────────────────────
        sectionBanner('8 \u00b7 The Render Pipeline',
            'How scroll events flow through the system',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                ('User scrolls', Icons.touch_app, 'Gesture detector captures drag'),
                ('ScrollController', Icons.swap_vert, 'Updates scroll offset'),
                ('ViewportOffset', Icons.straighten, 'Notifies viewport of new position'),
                ('RenderListWheelViewport', Icons.view_carousel, 'Recalculates visible range'),
                ('ListWheelElement', Icons.account_tree, 'Creates/removes child elements'),
                ('Delegate.build()', Icons.build, 'Supplies widget for each index'),
                ('RenderBox children', Icons.crop_square, 'Paint with cylindrical transform'),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iceLavender,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(step.$2, size: 18, color: deepCobalt),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 140,
                        child: Text(step.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepCobalt)),
                      ),
                      Expanded(
                        child: Text(step.$3,
                            style: TextStyle(fontSize: 11, color: vivid)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Memory model ─────────────────────────────────────────
        sectionBanner('9 \u00b7 Memory Management',
            'How ListWheelElement keeps memory usage constant',
            deepCobalt, Colors.white),
        noteBox(
          'Unlike a regular ListView\'s SliverList, ListWheelViewport '
          'pre-computes the cylindrical positions and only asks the '
          'ListWheelElement for children that are within the visible '
          'window. The element maintains a sparse map of inflated children '
          'keyed by index. As the scroll offset changes, new entries are '
          'added and old entries are removed, keeping total count nearly '
          'constant.',
          deepCobalt,
          frostBlue,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iceLavender,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final fact in [
                ('Active children', '~5-7 at any time'),
                ('Total in list', 'Could be 1000+'),
                ('Memory per child', 'Widget + Element + RenderBox'),
                ('Recycling', 'Old children are deactivated'),
                ('Framework cache', 'May keep recently used elements'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(fact.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepCobalt)),
                      ),
                      Expanded(
                        child: Text(fact.$2,
                            style: TextStyle(fontSize: 12, color: vivid)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Three-layer architecture ─────────────────────────────
        sectionBanner('10 \u00b7 Three-Layer Architecture',
            'Widget \u2192 Element \u2192 RenderObject',
            royalBlue, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final layer in [
                ('ListWheelViewport', 'Widget', 'Configuration',
                    deepCobalt, Icons.widgets),
                ('ListWheelElement', 'Element', 'Child management',
                    royalBlue, Icons.account_tree),
                ('RenderListWheelViewport', 'RenderObject', 'Layout & paint',
                    vivid, Icons.brush),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: layer.$4.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: layer.$4.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(layer.$5, size: 22, color: layer.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(layer.$1,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: deepCobalt)),
                                const SizedBox(width: 8),
                                tag(layer.$2, layer.$4.withValues(alpha: 0.15),
                                    layer.$4),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(layer.$3,
                                style: TextStyle(
                                    fontSize: 12, color: vivid)),
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

        // ── 12. Looping behavior in element ──────────────────────────
        sectionBanner('11 \u00b7 Looping Delegate Interaction',
            'How element handles infinite children',
            vivid, Colors.white),
        noteBox(
          'When the delegate is a LoopingListDelegate, childCount returns '
          'null. The render object then knows it can scroll indefinitely. '
          'The element still only inflates visible children — the modulo '
          'wrapping happens in delegate.build(), not in the element itself. '
          'The element simply passes indices through.',
          vivid,
          frostBlue,
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 1.8,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: [
                for (final emoji in ['\u2660', '\u2665', '\u2666', '\u2663'])
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      color: iceLavender,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(emoji,
                        style: TextStyle(
                            fontSize: 24, color: deepCobalt)),
                  ),
              ],
            ),
          ),
        ),
        noteBox(
          'Four suits repeat endlessly — the element manages only '
          'the visible subset while the delegate handles wrapping.',
          royalBlue,
          iceLavender,
        ),
        const SizedBox(height: 14),

        // ── 13. When does element rebuild ────────────────────────────
        sectionBanner('12 \u00b7 When Does the Element Rebuild?',
            'Triggers for child re-creation',
            steel, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final trigger in [
                ('\u2022', 'Scroll position changes', 'New children enter visible range'),
                ('\u2022', 'Delegate replaced', 'shouldRebuild returns true'),
                ('\u2022', 'Parent rebuilds', 'ListWheelViewport updateRenderObject'),
                ('\u2022', 'Global key moved', 'Child with GlobalKey reparented'),
                ('\u2717', 'Same delegate', 'shouldRebuild returns false \u2192 skip'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${trigger.$1}  ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: trigger.$1 == '\u2717'
                                  ? highlightAmber
                                  : deepCobalt)),
                      SizedBox(
                        width: 140,
                        child: Text(trigger.$2,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepCobalt)),
                      ),
                      Expanded(
                        child: Text(trigger.$3,
                            style: TextStyle(fontSize: 12, color: vivid)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Inheritance hierarchy ────────────────────────────────
        sectionBanner('13 \u00b7 Inheritance Hierarchy',
            'Class relationships', cerulean, deepCobalt),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frostBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                'Object',
                '  \u2514\u2500 DiagnosticableTree',
                '       \u2514\u2500 Element',
                '            \u2514\u2500 RenderObjectElement',
                '                 \u2514\u2500 ListWheelElement  \u2605',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: line.contains('\u2605')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: line.contains('\u2605')
                              ? deepCobalt
                              : steel)),
                ),
            ],
          ),
        ),
        noteBox(
          'Also implements: ListWheelChildManager (mixin-style interface)',
          cerulean,
          frostBlue,
        ),
        const SizedBox(height: 14),

        // ── 15. Practical considerations ─────────────────────────────
        sectionBanner('14 \u00b7 Practical Considerations',
            'What developers should know', deepCobalt, Colors.white),
        noteBox(
          'You almost never interact with ListWheelElement directly. '
          'Understanding it helps debug scroll performance, child '
          'lifecycle issues, and memory behavior in list wheels. '
          'If you see unexpected rebuilds or memory growth, the '
          'element-render object communication is the place to investigate.',
          deepCobalt,
          frostBlue,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iceLavender,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final tip in [
                ('Debug children', 'debugDescribeChildren() on element'),
                ('Performance', 'Check child count stays bounded'),
                ('Keys', 'GlobalKey can force element reuse'),
                ('DevTools', 'Element inspector shows active children'),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(tip.$1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: deepCobalt)),
                      ),
                      Expanded(
                        child: Text(tip.$2,
                            style: TextStyle(fontSize: 12, color: vivid)),
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
            'Key takeaways', deepCobalt, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCobalt, royalBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'RenderObjectElement for ListWheelViewport',
                'Implements ListWheelChildManager interface',
                'Manages lazy creation and removal of child elements',
                'createChild, removeChild, childCount — the full API',
                'Maintains only ~5-7 active children regardless of list size',
                'Works identically with all three delegate types',
                'Bridges widget tree (delegate) and render tree (viewport)',
                'Rarely used directly but crucial for understanding wheel internals',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: highlightAmber,
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
