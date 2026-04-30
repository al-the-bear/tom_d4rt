// ignore_for_file: avoid_print
// D4rt deep demo: KeepAliveNotification — a notification dispatched by a
// child widget to tell its parent sliver "please keep me alive even when
// I'm off-screen." It carries a KeepAliveHandle reference and bubbles up
// the widget tree until caught by a SliverMultiBoxAdaptorElement.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Forest / Moss palette ───
  const Color forest = Color(0xFF166534);
  const Color moss = Color(0xFF4ADE80);
  const Color deepPine = Color(0xFF052E16);
  const Color paleSpring = Color(0xFFF0FDF4);
  const Color fern = Color(0xFF16A34A);
  const Color mint = Color(0xFFDCFCE7);
  const Color evergreen = Color(0xFF14532D);
  const Color lime = Color(0xFF86EFAC);
  const Color sage = Color(0xFFBBF7D0);
  const Color juniper = Color(0xFF064E3B);

  print('===== KEEP ALIVE NOTIFICATION DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepPine, juniper],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepPine.withValues(alpha: 0.35),
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
              color: forest,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: fern, width: 1.5),
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
        color: paleSpring,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepPine.withValues(alpha: 0.9),
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
        border: Border.all(color: sage),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.07),
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
              color: mint,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepPine)),
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
                    color: deepPine)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: evergreen)),
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
                  color: deepPine.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepPine),
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
              Text(label, style: TextStyle(fontSize: 11, color: deepPine)),
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
              color: sage.withValues(alpha: 0.4),
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

  Widget bubbleStep(String step, String name, bool active, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? color : sage,
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: active ? color : sage,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(step,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : deepPine)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                    color: active ? color : deepPine)),
          ),
          if (active)
            Icon(Icons.arrow_upward, size: 14, color: color),
        ],
      ),
    );
  }

  Widget notificationCard(String type, String description, IconData icon,
      Color color, bool highlighted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: highlighted ? color.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: highlighted ? color : sage,
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: highlighted ? color : sage),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: highlighted ? color : deepPine)),
                Text(description,
                    style: TextStyle(
                        fontSize: 10,
                        color: highlighted
                            ? color.withValues(alpha: 0.7)
                            : evergreen.withValues(alpha: 0.6))),
              ],
            ),
          ),
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
          'KeepAliveNotification is a Notification subclass that carries '
          'a KeepAliveHandle from a child widget up to its parent sliver. '
          'When the parent receives it, the child is kept alive in memory '
          'even after scrolling off-screen.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Notification subclass'),
              dataRow('Package', 'flutter/widgets (sliver)'),
              dataRow('Purpose', 'Deliver keep-alive request upward'),
              dataRow('Payload', 'KeepAliveHandle reference'),
              dataRow('Consumer', 'SliverMultiBoxAdaptorElement'),
            ],
          )),
      infoCard(
          'Role in Keep-Alive System',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('KeepAliveHandle', 'The intent to stay alive'),
              dataRow('KeepAliveNotification', 'The delivery mechanism'),
              dataRow('AutomaticKeepAlive', 'The widget that catches it'),
              dataRow('SliverElement', 'The element that stores it'),
            ],
          )),
    ],
  );

  // ─── Section 2: Notification Dispatch ───
  print('[Section 2] Notification Dispatch');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Notification Dispatch'),
      noteBox(
          'The notification is dispatched using the standard Flutter '
          'notification pattern — calling dispatch(context) sends it '
          'bubbling up the Element tree.'),
      infoCard(
          'Dispatch Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bubbleStep('1', 'Child creates KeepAliveHandle', true, forest),
              bubbleStep('2', 'Wraps in KeepAliveNotification', true, fern),
              bubbleStep('3', 'Calls notification.dispatch(context)', true, moss),
              bubbleStep('4', 'Notification bubbles up tree', false, forest),
              bubbleStep('5', 'AutomaticKeepAlive catches it', false, forest),
              bubbleStep('6', 'Stores handle reference', false, forest),
            ],
          )),
    ],
  );

  // ─── Section 3: Bubble Path ───
  print('[Section 3] Bubble Path');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Bubble Path'),
      noteBox(
          'Like all Flutter notifications, KeepAliveNotification bubbles '
          'up from the dispatching context through every ancestor until '
          'consumed or reaching the root.'),
      infoCard(
          'Tree Traversal',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bubbleStep('▲', 'SliverList (catches here)', true, forest),
              bubbleStep('▲', 'AutomaticKeepAlive', true, fern),
              bubbleStep('▲', 'KeyedSubtree', false, evergreen),
              bubbleStep('▲', 'MyStatefulWidget', false, evergreen),
              bubbleStep('●', 'dispatch() called here', true, moss),
            ],
          )),
      infoCard(
          'Catch Mechanics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('NotificationListener', 'Generic catch mechanism'),
              dataRow('AutomaticKeepAlive', 'Specialized listener'),
              dataRow('onNotification', 'Returns true to stop bubble'),
              dataRow('Unhandled', 'Reaches root, ignored'),
            ],
          )),
    ],
  );

  // ─── Section 4: AutomaticKeepAlive Widget ───
  print('[Section 4] AutomaticKeepAlive Widget');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'AutomaticKeepAlive Widget'),
      noteBox(
          'AutomaticKeepAlive is the widget that listens for '
          'KeepAliveNotification. It\'s automatically inserted by '
          'ListView when addAutomaticKeepAlives is true (the default).'),
      infoCard(
          'Widget Role',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Inserted by', 'SliverChildListDelegate'),
              dataRow('Listens for', 'KeepAliveNotification'),
              dataRow('Stores', 'KeepAliveHandle from notification'),
              dataRow('Communicates', 'With parent SliverElement'),
              dataRow('Transparent', 'No visual output'),
            ],
          )),
      infoCard(
          'Widget Tree Position',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bubbleStep('↓', 'SliverList', false, forest),
              bubbleStep('↓', 'SliverMultiBoxAdaptorElement', false, forest),
              bubbleStep('→', 'AutomaticKeepAlive (listener)', true, fern),
              bubbleStep('↓', 'KeyedSubtree', false, evergreen),
              bubbleStep('↓', 'User widget (dispatches)', true, moss),
            ],
          )),
    ],
  );

  // ─── Section 5: Notification vs Handle Lifecycle ───
  print('[Section 5] Notification vs Handle Lifecycle');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Notification vs Handle Lifecycle'),
      noteBox(
          'The notification is a transient message dispatched once, while '
          'the handle it carries is a long-lived object that persists '
          'until released.'),
      infoCard(
          'Lifecycle Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Notification created', 'On each wantKeepAlive change'),
              dataRow('Notification consumed', 'Immediately after dispatch'),
              dataRow('Handle created', 'Once, on keep-alive request'),
              dataRow('Handle held', 'Until release() or dispose()'),
              dataRow('Notification GC\'d', 'After bubble completes'),
            ],
          )),
      infoCard(
          'Timing Diagram',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('T0', 'wantKeepAlive = true'),
              dataRow('T1', 'Handle created'),
              dataRow('T2', 'Notification dispatched'),
              dataRow('T3', 'Notification caught, handle stored'),
              dataRow('T4', 'Notification collected by GC'),
              dataRow('T5...Tn', 'Handle alive, child kept alive'),
              dataRow('Tn+1', 'handle.release() → child disposable'),
            ],
          )),
    ],
  );

  // ─── Section 6: Notification Payload ───
  print('[Section 6] Notification Payload');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Notification Payload'),
      noteBox(
          'The notification carries a single field: the KeepAliveHandle. '
          'This is the token that the parent holds onto.'),
      infoCard(
          'Payload Structure',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Field', 'handle — KeepAliveHandle'),
              dataRow('Non-null', 'Always has a valid handle'),
              dataRow('Mutable', 'Handle state can change later'),
              dataRow('Identity', 'Same handle for same child'),
            ],
          )),
      infoCard(
          'Constructor',
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepPine.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: sage),
            ),
            child: Text(
                'KeepAliveNotification(this.handle)\n'
                '\n'
                '// handle: KeepAliveHandle\n'
                '// Extends: Notification\n'
                '// dispatch(context) → bubbles up tree',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: deepPine,
                    height: 1.4)),
          )),
    ],
  );

  // ─── Section 7: Comparison with Other Notifications ───
  print('[Section 7] Comparison with Other Notifications');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Comparison with Other Notifications'),
      noteBox(
          'Flutter has many notification types. KeepAliveNotification is one '
          'of the simpler ones with a focused single purpose.'),
      infoCard(
          'Notification Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              notificationCard('KeepAliveNotification', 'Keep child alive off-screen',
                  Icons.lock, fern, true),
              notificationCard('ScrollNotification', 'Scroll position changed',
                  Icons.swap_vert, forest, false),
              notificationCard('SizeChangedLayoutNotification', 'Layout size changed',
                  Icons.aspect_ratio, forest, false),
              notificationCard('OverscrollNotification', 'Scrolled past boundary',
                  Icons.expand, forest, false),
              notificationCard('LayoutChangedNotification', 'Layout recalculated',
                  Icons.grid_view, forest, false),
            ],
          )),
    ],
  );

  // ─── Section 8: Multiple Dispatches ───
  print('[Section 8] Multiple Dispatches');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Multiple Dispatches'),
      noteBox(
          'A child may dispatch multiple KeepAliveNotifications during its '
          'lifetime — for example when toggling wantKeepAlive on and off.'),
      infoCard(
          'Dispatch Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Initial mount', 'First dispatch if wantKeepAlive'),
              dataRow('Toggle on', 'New handle, new notification'),
              dataRow('Toggle off', 'Release handle, no notification'),
              dataRow('Toggle on again', 'Fresh handle dispatched'),
              dataRow('Rebuild', 'Re-dispatch if state changed'),
            ],
          )),
      infoCard(
          'Handle Replacement',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Old handle', 'Released before new dispatch'),
              dataRow('New handle', 'Created fresh'),
              dataRow('Parent update', 'Swaps stored handle reference'),
              dataRow('No leak', 'Old handle properly cleaned up'),
            ],
          )),
    ],
  );

  // ─── Section 9: Error Cases ───
  print('[Section 9] Error Cases');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Error Cases'),
      noteBox(
          'KeepAliveNotification can fail silently if no ancestor is '
          'listening, or cause issues if dispatched at the wrong time.'),
      infoCard(
          'Potential Issues',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No listener', 'Notification ignored, no error'),
              dataRow('Wrong tree', 'Not inside a lazy list'),
              dataRow('After dispose', 'Dispatch after State.dispose'),
              dataRow('During build', 'Dispatch during build phase'),
              dataRow('Null handle', 'Invalid notification state'),
            ],
          )),
      infoCard(
          'Safe Dispatch Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Check mounted', 'Only dispatch if mounted'),
              dataRow('Post-frame', 'Use addPostFrameCallback'),
              dataRow('In build', 'Via AutomaticKeepAliveClientMixin'),
              dataRow('Avoid manual', 'Let mixin handle dispatch'),
            ],
          )),
    ],
  );

  // ─── Section 10: Framework Internals ───
  print('[Section 10] Framework Internals');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Framework Internals'),
      noteBox(
          'Inside the framework, KeepAliveNotification bridges the gap '
          'between the widget layer (where state lives) and the sliver '
          'layout layer (where lifecycle is managed).'),
      infoCard(
          'Internal Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Widget layer', 'Mixin manages wantKeepAlive'),
              dataRow('Notification', 'Bridges widget → sliver'),
              dataRow('Element layer', 'AutomaticKeepAlive Element'),
              dataRow('RenderSliver', 'Manages keep-alive bucket'),
              dataRow('Viewport', 'Paints only visible children'),
            ],
          )),
    ],
  );

  // ─── Section 11: Relationship to addAutomaticKeepAlives ───
  print('[Section 11] addAutomaticKeepAlives');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'addAutomaticKeepAlives'),
      noteBox(
          'The addAutomaticKeepAlives parameter in ListView controls whether '
          'AutomaticKeepAlive widgets are automatically inserted as wrappers '
          'around each child — this is the listener that catches the '
          'notification.'),
      infoCard(
          'Parameter Impact',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('true (default)', 'AutomaticKeepAlive wraps each child'),
              dataRow('false', 'No wrapper — notifications ignored'),
              dataRow('Custom', 'Use NotificationListener manually'),
            ],
          )),
      infoCard(
          'When false',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Notification dispatched', 'Yes, still sent'),
              dataRow('Caught by listener', 'No — no listener present'),
              dataRow('Result', 'Child disposed on scroll'),
              dataRow('Keep-alive effect', 'None'),
            ],
          )),
    ],
  );

  // ─── Section 12: Testing Notifications ───
  print('[Section 12] Testing Notifications');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Testing Notifications'),
      noteBox(
          'Testing KeepAliveNotification involves verifying that the '
          'notification is dispatched, caught, and the handle stored.'),
      infoCard(
          'Test Approaches',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('NotificationListener', 'Wrap in listener to intercept'),
              dataRow('Scroll test', 'Scroll out and check state'),
              dataRow('Handle tracking', 'Verify handle.release called'),
              dataRow('Widget finder', 'find AutomaticKeepAlive in tree'),
            ],
          )),
      infoCard(
          'Verification Pattern',
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepPine.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: sage),
            ),
            child: Text(
                'bool received = false;\n'
                'NotificationListener<KeepAliveNotification>(\n'
                '  onNotification: (n) { received = true; return false; },\n'
                '  child: listView,\n'
                ');\n'
                '// Pump, scroll, verify received == true',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: deepPine,
                    height: 1.4)),
          )),
    ],
  );

  // ─── Section 13: Notification Wiring in the Mixin ───
  print('[Section 13] Mixin Wiring');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Mixin Wiring'),
      noteBox(
          'AutomaticKeepAliveClientMixin handles all the notification '
          'dispatching internally — calling super.build() triggers the '
          'dispatch if wantKeepAlive changed.'),
      infoCard(
          'Mixin Implementation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('super.build()', 'Checks wantKeepAlive state'),
              dataRow('Changed to true', 'Creates handle + dispatches'),
              dataRow('Changed to false', 'Releases handle'),
              dataRow('No change', 'No-op, no notification'),
              dataRow('First build', 'Dispatches if wantKeepAlive'),
            ],
          )),
    ],
  );

  // ─── Section 14: Performance Considerations ───
  print('[Section 14] Performance');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Performance Considerations'),
      noteBox(
          'KeepAliveNotification is lightweight — the dispatch and bubble '
          'cost is minimal compared to the saved rebuild cost.'),
      infoCard(
          'Performance Characteristics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Dispatch cost', 0.05, forest),
              progressBar('Bubble traversal', 0.10, fern),
              progressBar('Handle creation', 0.03, moss),
              progressBar('Rebuild savings', 0.85, forest),
            ],
          )),
      infoCard(
          'Overhead Analysis',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Notification object', 'Tiny allocation, GC\'d fast'),
              dataRow('Bubble depth', 'Usually 3-5 ancestors'),
              dataRow('Handle memory', 'One reference per kept child'),
              dataRow('Net benefit', 'Positive for stateful children'),
            ],
          )),
    ],
  );

  // ─── Section 15: Edge Cases & Gotchas ───
  print('[Section 15] Edge Cases');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Edge Cases & Gotchas'),
      noteBox(
          'Several edge cases can cause unexpected behavior with keep-alive '
          'notifications in real applications.'),
      infoCard(
          'Edge Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Nested lists', 'Inner list in kept-alive item'),
              dataRow('Tab bar views', 'PageView with keep-alive tabs'),
              dataRow('Hot reload', 'Re-dispatches on rebuild'),
              dataRow('Key change', 'New key = new child = no keep'),
              dataRow('Reparenting', 'Move widget to different parent'),
            ],
          )),
      infoCard(
          'Solutions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Nested lists', 'Keep-alive the outer item only'),
              dataRow('Tab views', 'Use AutomaticKeepAliveClientMixin'),
              dataRow('Hot reload', 'Normal — framework handles it'),
              dataRow('Key change', 'Use stable keys for keep-alive'),
              dataRow('Reparenting', 'Dispatch in new context'),
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
      noteBox('Complete overview of the KeepAliveNotification deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Forest', forest),
              colorSwatch('Moss', moss),
              colorSwatch('Deep Pine', deepPine),
              colorSwatch('Pale Spring', paleSpring),
              colorSwatch('Fern', fern),
              colorSwatch('Mint', mint),
              colorSwatch('Evergreen', evergreen),
              colorSwatch('Lime', lime),
              colorSwatch('Sage', sage),
              colorSwatch('Juniper', juniper),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, forest),
              progressBar('Dispatch', 1.0, fern),
              progressBar('Bubble Path', 1.0, evergreen),
              progressBar('AutomaticKeepAlive', 1.0, juniper),
              progressBar('Lifecycle Comparison', 1.0, forest),
              progressBar('Payload', 1.0, fern),
              progressBar('Other Notifications', 1.0, evergreen),
              progressBar('Multiple Dispatches', 1.0, juniper),
              progressBar('Error Cases', 1.0, forest),
              progressBar('Framework Internals', 1.0, fern),
              progressBar('addAutomaticKeepAlives', 1.0, evergreen),
              progressBar('Testing', 1.0, juniper),
              progressBar('Mixin Wiring', 1.0, forest),
              progressBar('Performance', 1.0, fern),
              progressBar('Edge Cases', 1.0, evergreen),
              progressBar('Dashboard', 1.0, juniper),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Forest / Moss'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('KeepAliveNotification', forest, Colors.white),
          tag('Notification Bubble', fern, Colors.white),
          tag('Handle Delivery', evergreen, Colors.white),
          tag('AutomaticKeepAlive', juniper, Colors.white),
          tag('Sliver Integration', moss, deepPine),
          tag('State Preservation', lime, deepPine),
        ],
      ),
    ],
  );

  print('===== END KEEP ALIVE NOTIFICATION DEEP DEMO =====');

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
