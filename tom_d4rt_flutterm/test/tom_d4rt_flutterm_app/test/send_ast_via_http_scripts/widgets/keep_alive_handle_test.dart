// ignore_for_file: avoid_print
// D4rt deep demo: KeepAliveHandle — a handle that keeps a widget alive in a
// lazy list (e.g. ListView, PageView) even after it scrolls off-screen.
// The framework uses KeepAliveHandle with AutomaticKeepAliveClientMixin to
// prevent state disposal when widgets leave the viewport.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Coral / Peach palette ───
  const Color coral = Color(0xFFF97316);
  const Color peach = Color(0xFFFB923C);
  const Color deepEmber = Color(0xFF7C2D12);
  const Color paleApricot = Color(0xFFFFF7ED);
  const Color tangerine = Color(0xFFEA580C);
  const Color cream = Color(0xFFFFFBEB);
  const Color sienna = Color(0xFF9A3412);
  const Color sunset = Color(0xFFFDBA74);
  const Color melon = Color(0xFFFED7AA);
  const Color ember = Color(0xFF431407);

  print('===== KEEP ALIVE HANDLE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepEmber, ember],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepEmber.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: coral,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: peach, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: melon),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepEmber.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: melon),
        boxShadow: [
          BoxShadow(
            color: coral.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleApricot,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepEmber)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepEmber)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: ember)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepEmber.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepEmber),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: deepEmber)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: melon.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTile(String label, bool keepAlive, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: keepAlive ? activeColor.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: keepAlive ? activeColor : melon,
          width: keepAlive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            keepAlive ? Icons.lock : Icons.lock_open,
            size: 16,
            color: keepAlive ? activeColor : melon,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: keepAlive ? FontWeight.w600 : FontWeight.normal,
                    color: keepAlive ? activeColor : deepEmber)),
          ),
          Text(keepAlive ? 'ALIVE' : 'disposable',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: keepAlive ? activeColor : melon)),
        ],
      ),
    );
  }

  Widget viewportSlot(String label, bool inView, bool kept, Color activeColor) {
    Color bg = inView
        ? activeColor.withValues(alpha: 0.12)
        : kept
            ? sunset.withValues(alpha: 0.15)
            : Colors.grey.withValues(alpha: 0.06);
    Color borderColor = inView
        ? activeColor
        : kept
            ? sunset
            : Colors.grey.withValues(alpha: 0.25);
    String status =
        inView ? 'VISIBLE' : (kept ? 'KEPT ALIVE' : 'DISPOSED');
    return Container(
      width: 80,
      height: 55,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: inView ? 2 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: deepEmber)),
          const SizedBox(height: 2),
          Text(status,
              style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  color: borderColor)),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'KeepAliveHandle is a lightweight object that tells the framework '
          'to keep a child widget alive in a lazy list (ListView, PageView) '
          'even after it scrolls off-screen. Without it, off-screen items '
          'have their State disposed and are rebuilt from scratch when '
          'scrolled back into view.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'ChangeNotifier handle'),
              dataRow('Package', 'flutter/widgets (sliver)'),
              dataRow('Purpose', 'Prevent state disposal off-screen'),
              dataRow('Companion', 'AutomaticKeepAliveClientMixin'),
              dataRow('Lifecycle', 'Created → held → released'),
            ],
          )),
      infoCard(
          'When to Keep Alive',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Media player', 'Don\'t restart video on scroll'),
              dataRow('Form fields', 'Preserve user input'),
              dataRow('Animation state', 'Keep animation running'),
              dataRow('Network fetch', 'Avoid re-fetching data'),
              dataRow('Heavy computation', 'Cache computed results'),
            ],
          )),
    ],
  );

  // ─── Section 2: Handle Lifecycle ───
  print('[Section 2] Handle Lifecycle');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Handle Lifecycle'),
      noteBox(
          'The handle is created when the mixin decides the child should '
          'stay alive, and released when keep-alive is no longer needed.'),
      infoCard(
          'Lifecycle Stages',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Create', 'KeepAliveHandle() constructed'),
              dataRow('2. Register', 'KeepAliveNotification dispatched'),
              dataRow('3. Hold', 'Sliver keeps child alive'),
              dataRow('4. Release', 'handle.release() called'),
              dataRow('5. Dispose', 'Child eligible for disposal'),
            ],
          )),
      infoCard(
          'State Diagram',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  listTile('Created', true, coral),
                ],
              ),
              const SizedBox(height: 4),
              Center(child: Icon(Icons.arrow_downward, size: 16, color: tangerine)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  listTile('Registered', true, tangerine),
                ],
              ),
              const SizedBox(height: 4),
              Center(child: Icon(Icons.arrow_downward, size: 16, color: sienna)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  listTile('Released', false, sienna),
                ],
              ),
            ],
          )),
    ],
  );

  // ─── Section 3: AutomaticKeepAliveClientMixin ───
  print('[Section 3] AutomaticKeepAlive Mixin');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'AutomaticKeepAliveClientMixin'),
      noteBox(
          'The most common way to use KeepAliveHandle is through '
          'AutomaticKeepAliveClientMixin, which manages the handle '
          'automatically based on a wantKeepAlive getter.'),
      infoCard(
          'Mixin API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('wantKeepAlive', 'bool getter — override to true'),
              dataRow('updateKeepAlive()', 'Call when wantKeepAlive changes'),
              dataRow('super.build()', 'Must call in build method'),
              dataRow('Handle management', 'Fully automatic'),
            ],
          )),
      infoCard(
          'Usage Pattern',
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepEmber.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: melon),
            ),
            child: Text(
                'class _MyItemState extends State<MyItem>\n'
                '    with AutomaticKeepAliveClientMixin {\n'
                '  @override\n'
                '  bool get wantKeepAlive => true;\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    super.build(context); // Required\n'
                '    return MyContent();\n'
                '  }\n'
                '}',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: deepEmber,
                    height: 1.4)),
          )),
    ],
  );

  // ─── Section 4: Viewport & Lazy Lists ───
  print('[Section 4] Viewport & Lazy Lists');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Viewport & Lazy Lists'),
      noteBox(
          'In a lazy list, the viewport only builds items that are visible '
          'plus a small cache extent. KeepAliveHandle overrides this for '
          'specific items.'),
      infoCard(
          'Viewport Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  viewportSlot('Item 0', false, false, coral),
                  viewportSlot('Item 1', false, true, coral),
                  viewportSlot('Item 2', true, false, coral),
                  viewportSlot('Item 3', true, false, coral),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  viewportSlot('Item 4', true, false, coral),
                  viewportSlot('Item 5', false, true, coral),
                  viewportSlot('Item 6', false, false, coral),
                  viewportSlot('Item 7', false, false, coral),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('Item 0, 6, 7', 'Off-screen, disposed'),
              dataRow('Items 2, 3, 4', 'In viewport, visible'),
              dataRow('Items 1, 5', 'Off-screen but KEPT ALIVE'),
            ],
          )),
    ],
  );

  // ─── Section 5: Notification Flow ───
  print('[Section 5] Notification Flow');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Notification Flow'),
      noteBox(
          'KeepAliveHandle works via KeepAliveNotification dispatched up '
          'the widget tree to the parent SliverMultiBoxAdaptor.'),
      infoCard(
          'Notification Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Child widget', 'Creates KeepAliveHandle'),
              dataRow('2. Dispatch', 'KeepAliveNotification(handle).dispatch'),
              dataRow('3. Bubble up', 'Notification travels up tree'),
              dataRow('4. Sliver catches', 'SliverList/SliverGrid receives'),
              dataRow('5. Store handle', 'Sliver retains reference'),
              dataRow('6. Keep in layout', 'Don\'t remove from child list'),
            ],
          )),
    ],
  );

  // ─── Section 6: Memory Implications ───
  print('[Section 6] Memory Implications');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Memory Implications'),
      noteBox(
          'Keeping widgets alive consumes memory. Too many keep-alive items '
          'in a long list can cause memory pressure.'),
      infoCard(
          'Memory Trade-offs',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('No keep-alive (baseline)', 0.15, coral),
              progressBar('10 items kept', 0.30, tangerine),
              progressBar('50 items kept', 0.55, sienna),
              progressBar('All items kept', 0.95, ember),
            ],
          )),
      infoCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Selective', 'Only keep-alive items with state'),
              dataRow('Release early', 'Drop handle when state saved'),
              dataRow('Monitor', 'Watch memory in DevTools'),
              dataRow('Limit count', 'Cap max kept-alive items'),
              dataRow('addAutomaticKeepAlives', 'ListView parameter'),
            ],
          )),
    ],
  );

  // ─── Section 7: Handle vs Notification ───
  print('[Section 7] Handle vs Notification');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Handle vs Notification'),
      noteBox(
          'KeepAliveHandle is the object that represents the keep-alive '
          'intent, while KeepAliveNotification is the mechanism that '
          'delivers it to the parent sliver.'),
      infoCard(
          'Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('KeepAliveHandle', 'Object — holds the intent'),
              dataRow('KeepAliveNotification', 'Notification — delivers it'),
              dataRow('Handle lifetime', 'Until release() called'),
              dataRow('Notification lifetime', 'Consumed on dispatch'),
              dataRow('Coupling', 'Notification wraps handle ref'),
            ],
          )),
    ],
  );

  // ─── Section 8: Release Mechanics ───
  print('[Section 8] Release Mechanics');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Release Mechanics'),
      noteBox(
          'Calling release() on the handle notifies listeners (the parent '
          'sliver) that the child no longer needs to be kept alive.'),
      infoCard(
          'Release Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. release()', 'Child calls handle.release()'),
              dataRow('2. Notify listeners', 'ChangeNotifier fires'),
              dataRow('3. Sliver responds', 'Marks child as disposable'),
              dataRow('4. Next layout', 'Off-screen child removed'),
              dataRow('5. State disposed', 'State.dispose() called'),
            ],
          )),
      infoCard(
          'Release Triggers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('wantKeepAlive = false', 'Mixin updates handle'),
              dataRow('Widget unmount', 'State.dispose releases'),
              dataRow('Explicit release', 'Manual handle.release()'),
              dataRow('Parent disposal', 'ListView removed from tree'),
            ],
          )),
    ],
  );

  // ─── Section 9: SliverMultiBoxAdaptor ───
  print('[Section 9] SliverMultiBoxAdaptor');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'SliverMultiBoxAdaptor Integration'),
      noteBox(
          'The SliverMultiBoxAdaptorElement manages kept-alive children '
          'in a separate bucket from regular children.'),
      infoCard(
          'Child Buckets',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Active children', 'Currently in viewport layout'),
              dataRow('Keep-alive bucket', 'Off-screen but retained'),
              dataRow('Garbage', 'Pending disposal'),
              dataRow('Total children', 'active + keep-alive'),
            ],
          )),
      infoCard(
          'Layout Interaction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('performLayout', 'Lays out active children'),
              dataRow('Keep-alive skip', 'Not included in layout size'),
              dataRow('Scroll back', 'Move from keep-alive to active'),
              dataRow('Paint skip', 'Keep-alive items not painted'),
            ],
          )),
    ],
  );

  // ─── Section 10: addAutomaticKeepAlives ───
  print('[Section 10] addAutomaticKeepAlives');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'addAutomaticKeepAlives Parameter'),
      noteBox(
          'ListView and GridView have an addAutomaticKeepAlives parameter '
          'that wraps each child in an AutomaticKeepAlive widget. This is '
          'separate from the mixin approach.'),
      infoCard(
          'AutomaticKeepAlive Widget',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Default', 'true in ListView/GridView'),
              dataRow('Behavior', 'Wraps child in AutomaticKeepAlive'),
              dataRow('Listens for', 'KeepAliveNotification from child'),
              dataRow('Acts as', 'Bridge between child and sliver'),
            ],
          )),
      infoCard(
          'When to Disable',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No stateful items', 'Pure display list'),
              dataRow('Performance', 'Reduce wrapper overhead'),
              dataRow('Custom logic', 'Own keep-alive management'),
              dataRow('Memory pressure', 'Force disposal of all items'),
            ],
          )),
    ],
  );

  // ─── Section 11: ChangeNotifier Behavior ───
  print('[Section 11] ChangeNotifier Behavior');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'ChangeNotifier Behavior'),
      noteBox(
          'KeepAliveHandle extends ChangeNotifier, so the parent sliver '
          'can listen for release events and respond accordingly.'),
      infoCard(
          'Notification Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Extends', 'ChangeNotifier'),
              dataRow('Listener', 'Parent SliverElement'),
              dataRow('Trigger', 'release() calls notifyListeners'),
              dataRow('Response', 'Sliver marks child disposable'),
              dataRow('Cleanup', 'removeListener + dispose'),
            ],
          )),
    ],
  );

  // ─── Section 12: Interaction with Scroll ───
  print('[Section 12] Interaction with Scroll');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Interaction with Scrolling'),
      noteBox(
          'Kept-alive items interact with the scroll machinery — they '
          'consume memory but not layout space in the scroll extent.'),
      infoCard(
          'Scroll Impact',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Scroll extent', 'Not affected by keep-alive'),
              dataRow('Cache extent', 'Keep-alive separate from cache'),
              dataRow('Jump to index', 'Keep-alive items found faster'),
              dataRow('Velocity', 'No impact on scroll physics'),
            ],
          )),
      infoCard(
          'Scroll Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  viewportSlot('Above 1', false, true, tangerine),
                  viewportSlot('Above 2', false, false, tangerine),
                ],
              ),
              Container(
                width: double.infinity,
                height: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: coral,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  viewportSlot('Visible 1', true, false, coral),
                  viewportSlot('Visible 2', true, false, coral),
                ],
              ),
              Container(
                width: double.infinity,
                height: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: coral,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  viewportSlot('Below 1', false, false, tangerine),
                  viewportSlot('Below 2', false, true, tangerine),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('Red lines', 'Viewport edges'),
              dataRow('KEPT ALIVE', 'Handle active, state retained'),
            ],
          )),
    ],
  );

  // ─── Section 13: Common Pitfalls ───
  print('[Section 13] Common Pitfalls');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Common Pitfalls'),
      noteBox(
          'Keep-alive is powerful but easy to misuse, leading to memory '
          'leaks or unexpected behavior.'),
      infoCard(
          'Pitfalls',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Keep all alive', 'Defeats lazy list purpose'),
              dataRow('Forget super.build', 'Mixin won\'t register handle'),
              dataRow('Stale state', 'Keeping alive with outdated data'),
              dataRow('Timer leak', 'Timer in kept-alive state'),
              dataRow('Widget key issue', 'Key change disposes anyway'),
            ],
          )),
      infoCard(
          'Solutions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Selective keep-alive', 'Only stateful items'),
              dataRow('Always super.build', 'First line of build()'),
              dataRow('Refresh on visible', 'Check data freshness'),
              dataRow('Cancel timers', 'On deactivate, not dispose'),
              dataRow('Stable keys', 'Use item ID as key'),
            ],
          )),
    ],
  );

  // ─── Section 14: Testing Keep-Alive ───
  print('[Section 14] Testing Keep-Alive');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Testing Keep-Alive'),
      noteBox(
          'Testing keep-alive requires scrolling items in and out of view '
          'and verifying state is preserved or disposed correctly.'),
      infoCard(
          'Test Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Scroll out', 'controller.jumpTo(offset)'),
              dataRow('Check state', 'find.byType should still find'),
              dataRow('Scroll back', 'Verify state is preserved'),
              dataRow('Release handle', 'Set wantKeepAlive = false'),
              dataRow('Verify disposal', 'State.dispose was called'),
            ],
          )),
    ],
  );

  // ─── Section 15: Performance Implications ───
  print('[Section 15] Performance Implications');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Performance Implications'),
      noteBox(
          'Keep-alive trades memory for rebuild avoidance — valuable for '
          'heavy items but wasteful for simple ones.'),
      infoCard(
          'Performance Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Rebuild cost saved', 0.85, coral),
              progressBar('Memory overhead', 0.30, tangerine),
              progressBar('Scroll smoothness', 0.90, sienna),
              progressBar('State preservation', 1.0, deepEmber),
            ],
          )),
      infoCard(
          'When to Use',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Heavy build', 'Complex widget tree — yes'),
              dataRow('Simple text', 'StatelessWidget — no'),
              dataRow('Network image', 'Image cache handles this'),
              dataRow('Form input', 'Preserve user typing — yes'),
              dataRow('Animation', 'Keep running — yes'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the KeepAliveHandle deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Coral', coral),
              colorSwatch('Peach', peach),
              colorSwatch('Deep Ember', deepEmber),
              colorSwatch('Pale Apricot', paleApricot),
              colorSwatch('Tangerine', tangerine),
              colorSwatch('Cream', cream),
              colorSwatch('Sienna', sienna),
              colorSwatch('Sunset', sunset),
              colorSwatch('Melon', melon),
              colorSwatch('Ember', ember),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, coral),
              progressBar('Handle Lifecycle', 1.0, tangerine),
              progressBar('KeepAlive Mixin', 1.0, sienna),
              progressBar('Viewport & Lazy Lists', 1.0, ember),
              progressBar('Notification Flow', 1.0, coral),
              progressBar('Memory Implications', 1.0, tangerine),
              progressBar('Handle vs Notification', 1.0, sienna),
              progressBar('Release Mechanics', 1.0, ember),
              progressBar('SliverMultiBoxAdaptor', 1.0, coral),
              progressBar('addAutomaticKeepAlives', 1.0, tangerine),
              progressBar('ChangeNotifier', 1.0, sienna),
              progressBar('Scroll Interaction', 1.0, ember),
              progressBar('Pitfalls', 1.0, coral),
              progressBar('Testing', 1.0, tangerine),
              progressBar('Performance', 1.0, sienna),
              progressBar('Dashboard', 1.0, ember),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Coral / Peach'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('KeepAliveHandle', coral, Colors.white),
          tag('Lazy Lists', tangerine, Colors.white),
          tag('State Preservation', sienna, Colors.white),
          tag('ChangeNotifier', deepEmber, Colors.white),
          tag('Viewport', peach, ember),
          tag('Memory Management', sunset, ember),
        ],
      ),
    ],
  );

  print('===== END KEEP ALIVE HANDLE DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
