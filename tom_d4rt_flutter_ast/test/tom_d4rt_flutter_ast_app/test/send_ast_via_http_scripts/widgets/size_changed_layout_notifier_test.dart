// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SizeChangedLayoutNotifier
// Demonstrates SizeChangedLayoutNotifier — a widget that dispatches
// SizeChangedLayoutNotification through the widget tree whenever its
// child's size changes during layout. Useful for responsive UIs and
// size-tracking scenarios.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SizeChangedLayoutNotifier Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.photo_size_select_small,
      'title': 'Size Change Detection',
      'body': 'SizeChangedLayoutNotifier wraps a child widget and automatically '
          'dispatches a SizeChangedLayoutNotification whenever the child\'s '
          'size changes during layout. This notification bubbles up through '
          'the widget tree for any ancestor to catch.',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Notification Pattern',
      'body': 'Uses Flutter\'s Notification system — notifications bubble up '
          'from child to parent. Any ancestor NotificationListener<'
          'SizeChangedLayoutNotification> can intercept and respond.',
    },
    {
      'icon': Icons.memory,
      'title': 'RenderObject-Based',
      'body': 'Internally creates a RenderSizeChangedWithCallback '
          'render object. The callback fires after the layout phase when '
          'the measured size differs from the previous frame.',
    },
    {
      'icon': Icons.bolt,
      'title': 'No Extra Layout Pass',
      'body': 'Unlike measuring with GlobalKey.currentContext.size (which '
          'requires an additional frame), SizeChangedLayoutNotifier fires '
          'during the same layout pass — giving you immediate notification.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.amber.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                        color: Colors.amber.shade700),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParams = <Map<String, String>>[
    {
      'name': 'key',
      'type': 'Key?',
      'desc': 'Standard widget key for identity.',
    },
    {
      'name': 'child',
      'type': 'Widget?',
      'desc': 'The child widget to track size changes for. The notifier wraps '
          'this widget and monitors its render box dimensions.',
    },
  ];

  final paramWidgets = <Widget>[];
  for (var i = 0; i < constructorParams.length; i++) {
    final p = constructorParams[i];
    print('  Param: ${p['name']} — ${p['type']}');
    paramWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.amber.withValues(alpha: 0.03)
              : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.amber.withValues(alpha: 0.15)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name']!, style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w700, color: Colors.amber.shade800,
                      fontFamily: 'monospace')),
                  Text(p['type']!, style: TextStyle(fontSize: 10.0,
                      color: Colors.amber.shade400, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(p['desc']!, style: TextStyle(fontSize: 12.0,
                  color: Colors.grey.shade700, height: 1.35)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Notification Flow
  // ============================================================
  print('=== Section 3: Notification Flow ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'SizeChangedLayoutNotifier',
      'detail': 'Wraps the child widget',
      'icon': Icons.wrap_text,
      'color': Colors.amber.shade600,
    },
    {
      'step': 2,
      'label': 'RenderSizeChangedWithCallback',
      'detail': 'Monitors performLayout()',
      'icon': Icons.memory,
      'color': Colors.orange.shade600,
    },
    {
      'step': 3,
      'label': 'Size changed?',
      'detail': 'Compares with previous size',
      'icon': Icons.compare_arrows,
      'color': Colors.deepOrange.shade600,
    },
    {
      'step': 4,
      'label': 'SizeChangedLayoutNotification',
      'detail': 'dispatch(context) — bubbles up',
      'icon': Icons.notifications_active,
      'color': Colors.red.shade500,
    },
    {
      'step': 5,
      'label': 'NotificationListener',
      'detail': 'Ancestor catches notification',
      'icon': Icons.hearing,
      'color': Colors.purple.shade500,
    },
  ];

  final flowWidgets = <Widget>[];
  for (var i = 0; i < flowSteps.length; i++) {
    final s = flowSteps[i];
    print('  Flow step ${s['step']}: ${s['label']}');

    if (i > 0) {
      flowWidgets.add(
        Center(
          child: Container(
            width: 2.0,
            height: 20.0,
            color: Colors.amber.withValues(alpha: 0.4),
          ),
        ),
      );
      flowWidgets.add(
        Center(
          child: Icon(Icons.arrow_downward, size: 16.0,
              color: Colors.amber.withValues(alpha: 0.5)),
        ),
      );
    }

    flowWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('${s['step']}', style: const TextStyle(fontSize: 13.0,
                  fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['label'] as String, style: TextStyle(fontSize: 12.5,
                      fontWeight: FontWeight.w700, color: s['color'] as Color,
                      fontFamily: 'monospace')),
                  Text(s['detail'] as String, style: TextStyle(fontSize: 11.0,
                      color: Colors.grey.shade600)),
                ],
              ),
            ),
            Icon(s['icon'] as IconData, color: (s['color'] as Color).withValues(alpha: 0.5),
                size: 22.0),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Use Cases
  // ============================================================
  print('=== Section 4: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'icon': Icons.aspect_ratio,
      'title': 'Responsive Layouts',
      'body': 'Track when a container resizes (e.g., window resize, orientation '
          'change) and adapt child layout accordingly. Unlike MediaQuery, '
          'this tracks the actual widget size, not the screen size.',
      'example': 'A sidebar that collapses when its parent gets narrow.',
    },
    {
      'icon': Icons.text_fields,
      'title': 'Dynamic Content Sizing',
      'body': 'When text content changes length or images load, '
          'SizeChangedLayoutNotifier tells parent widgets to adjust '
          'surrounding layout — e.g., reposition overlays or scrolling.',
      'example': 'Chat bubbles that expand when message text wraps to new lines.',
    },
    {
      'icon': Icons.animation,
      'title': 'Animation Triggers',
      'body': 'Trigger animations when a widget changes size. For instance, '
          'animate a background gradient or border when an accordion expands.',
      'example': 'ExpansionTile that fades in a shadow when it opens.',
    },
    {
      'icon': Icons.layers,
      'title': 'Overlay Repositioning',
      'body': 'When a target widget changes size, overlays (tooltips, popups, '
          'dropdowns) need to reposition. SizeChangedLayoutNotifier signals '
          'the overlay to recalculate its anchor position.',
      'example': 'Autocomplete dropdown that shifts when the input field resizes.',
    },
    {
      'icon': Icons.stacked_bar_chart,
      'title': 'Custom Scroll Effects',
      'body': 'ScrollViews that need to know when content height changes. '
          'SizeChangedLayoutNotifier can trigger scroll extent recalculation.',
      'example': 'Infinite scroll that adjusts when items collapse/expand.',
    },
  ];

  final useCaseCards = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final u = useCases[i];
    print('  Use case: ${u['title']}');
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(u['icon'] as IconData, color: Colors.amber.shade700, size: 22.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(u['title'] as String, style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w700, color: Colors.amber.shade700)),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(u['body'] as String, style: TextStyle(fontSize: 12.0,
                color: Colors.grey.shade700, height: 1.35)),
            const SizedBox(height: 6.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, size: 14.0, color: Colors.amber.shade600),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text('Example: ${u['example']}',
                        style: TextStyle(fontSize: 11.0, color: Colors.amber.shade700,
                            fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Demo see _SCLNLiveDemo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  // ============================================================
  // SECTION 6: NotificationListener Integration
  // ============================================================
  print('=== Section 6: NotificationListener Integration ===');

  // ============================================================
  // SECTION 7: Comparison
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisonData = <Map<String, String>>[
    {
      'feature': 'Timing',
      'notifier': 'During layout',
      'layoutBuilder': 'During layout',
      'globalKey': 'Post-frame callback',
    },
    {
      'feature': 'Detection',
      'notifier': 'Size changes only',
      'layoutBuilder': 'Constraints',
      'globalKey': 'Manual check',
    },
    {
      'feature': 'Propagation',
      'notifier': 'Bubbles up (Notification)',
      'layoutBuilder': 'Local scope',
      'globalKey': 'Imperative access',
    },
    {
      'feature': 'Setup cost',
      'notifier': 'Wrap + listener',
      'layoutBuilder': 'Builder callback',
      'globalKey': 'Key + post-frame',
    },
    {
      'feature': 'Best for',
      'notifier': 'Ancestor awareness',
      'layoutBuilder': 'Responsive child',
      'globalKey': 'Cross-tree access',
    },
    {
      'feature': 'Widget tree impact',
      'notifier': 'No rebuild self',
      'layoutBuilder': 'Rebuilds child',
      'globalKey': 'No rebuild',
    },
  ];

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryItems = <Map<String, dynamic>>[
    {'icon': Icons.photo_size_select_small, 'text': 'SizeChangedLayoutNotifier '
        'detects when its child changes size during layout'},
    {'icon': Icons.notifications, 'text': 'Dispatches SizeChangedLayout'
        'Notification — a standard Flutter notification'},
    {'icon': Icons.hearing, 'text': 'Caught by ancestor NotificationListener '
        '— no callbacks, no GlobalKey needed'},
    {'icon': Icons.memory, 'text': 'Uses RenderSizeChangedWithCallback '
        'internally — integrates with the rendering pipeline'},
    {'icon': Icons.speed, 'text': 'Fires during layout phase — no post-frame '
        'delay unlike GlobalKey measurements'},
    {'icon': Icons.architecture, 'text': 'Decouples size tracking from the '
        'widget that changes — clean separation of concerns'},
  ];

  final summaryBullets = <Widget>[];
  for (var i = 0; i < summaryItems.length; i++) {
    final s = summaryItems[i];
    print('Summary: ${s['text']}');
    summaryBullets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(s['icon'] as IconData, size: 18.0, color: Colors.amber.shade600),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(s['text'] as String,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.35)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Build helper
  // ============================================================
  Widget buildSCLNBullet(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color ?? Colors.amber.shade600),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.3)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Main layout
  // ============================================================
  print('Building main tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SizeChangedLayoutNotifier Deep Demo'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11.0),
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Notification Flow'),
            Tab(text: 'Use Cases'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Listener'),
            Tab(text: 'Comparison'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // --- TAB 1: Concept ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSCLNBullet(Icons.info_outline,
                  'SizeChangedLayoutNotifier is a SingleChildRenderObjectWidget '
                  'that monitors its render object\'s size and dispatches a '
                  'notification when it changes.'),
              const SizedBox(height: 12.0),
              ...conceptCards,
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('How it differs from LayoutBuilder',
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Colors.amber.shade800)),
                    const SizedBox(height: 8.0),
                    buildSCLNBullet(Icons.compare,
                        'LayoutBuilder gives you constraints before building — '
                        'it rebuilds the child with new constraints.'),
                    buildSCLNBullet(Icons.notifications,
                        'SizeChangedLayoutNotifier fires after layout — it tells '
                        'ancestors what happened. The child is not rebuilt.'),
                    buildSCLNBullet(Icons.arrow_upward,
                        'LayoutBuilder flows downward (constraints). '
                        'SizeChangedLayoutNotifier flows upward (notifications).'),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              // Code pattern
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Basic usage pattern',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700)),
                    const SizedBox(height: 6.0),
                    Text(
                      'NotificationListener<SizeChangedLayoutNotification>(\n'
                      '  onNotification: (notification) {\n'
                      '    // React to size change\n'
                      '    return true; // consumed\n'
                      '  },\n'
                      '  child: SizeChangedLayoutNotifier(\n'
                      '    child: MyDynamicWidget(),\n'
                      '  ),\n'
                      ')',
                      style: TextStyle(fontSize: 11.5, fontFamily: 'monospace',
                          color: Colors.grey.shade800, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 2: Constructor ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'const SizeChangedLayoutNotifier({\n'
                  '  Key? key,\n'
                  '  Widget? child,\n'
                  '})',
                  style: TextStyle(fontSize: 12.5, fontFamily: 'monospace',
                      color: Colors.grey.shade800, height: 1.4),
                ),
              ),
              const SizedBox(height: 16.0),
              ...paramWidgets,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Simplest API in Flutter',
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Colors.amber.shade700)),
                    const SizedBox(height: 6.0),
                    Text(
                      'With only an optional child parameter, SizeChangedLayout'
                      'Notifier has one of the simplest constructors in the '
                      'Flutter framework. The complexity is in the rendering '
                      'layer — RenderSizeChangedWithCallback does the real work.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inheritance Chain',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.amber.shade700)),
                    const SizedBox(height: 8.0),
                    ...[
                      'Widget',
                      '  └─ RenderObjectWidget',
                      '      └─ SingleChildRenderObjectWidget',
                      '          └─ SizeChangedLayoutNotifier',
                    ].map((line) => Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(line, style: TextStyle(fontSize: 11.5,
                          fontFamily: 'monospace', color: Colors.amber.shade800, height: 1.3)),
                    )),
                    const SizedBox(height: 8.0),
                    Text('Creates: RenderSizeChangedWithCallback',
                        style: TextStyle(fontSize: 11.5, fontStyle: FontStyle.italic,
                            color: Colors.amber.shade600)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Related classes
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Related Classes',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.grey.shade700)),
                    const SizedBox(height: 8.0),
                    ...<Map<String, String>>[
                      {'name': 'SizeChangedLayoutNotification',
                          'desc': 'The notification dispatched (extends LayoutChangedNotification)'},
                      {'name': 'LayoutChangedNotification',
                          'desc': 'Base class for layout-related notifications'},
                      {'name': 'RenderSizeChangedWithCallback',
                          'desc': 'RenderProxyBox that triggers callback on size change'},
                      {'name': 'NotificationListener',
                          'desc': 'Widget that listens for notifications from descendants'},
                    ].map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 6.0, color: Colors.amber.shade400),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: r['name']!,
                                      style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                                          fontWeight: FontWeight.w600, color: Colors.amber.shade800)),
                                  TextSpan(text: ' — ${r['desc']}',
                                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 3: Notification Flow ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSCLNBullet(Icons.route,
                  'The notification flows from the RenderObject through the '
                  'Element tree up to any listening ancestor.'),
              const SizedBox(height: 12.0),
              ...flowWidgets,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Timing details', style: TextStyle(fontSize: 12.5,
                        fontWeight: FontWeight.w700, color: Colors.amber.shade700)),
                    const SizedBox(height: 8.0),
                    buildSCLNBullet(Icons.schedule,
                        '1. Layout phase: RenderSizeChangedWithCallback.performLayout()'),
                    buildSCLNBullet(Icons.compare_arrows,
                        '2. Size comparison: oldSize != newSize?'),
                    buildSCLNBullet(Icons.schedule_send,
                        '3. Callback scheduled via SchedulerBinding.addPostFrameCallback'),
                    buildSCLNBullet(Icons.notifications_active,
                        '4. Post-frame: notification.dispatch(context)'),
                    buildSCLNBullet(Icons.hearing,
                        '5. Notification bubbles up to NotificationListener'),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.purple.shade600, size: 18.0),
                        const SizedBox(width: 6.0),
                        Text('Key insight', style: TextStyle(fontSize: 12.5,
                            fontWeight: FontWeight.w700, color: Colors.purple.shade700)),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'The notification is dispatched in a post-frame callback, '
                      'not during the layout phase itself. This means listeners '
                      'can safely call setState() without interfering with the '
                      'current layout/paint cycle.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 4: Use Cases ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSCLNBullet(Icons.apps,
                  'Real-world scenarios where SizeChangedLayoutNotifier shines:'),
              const SizedBox(height: 12.0),
              ...useCaseCards,
            ],
          ),

          // --- TAB 5: Live Demo ---
          const _SCLNLiveDemo(),

          // --- TAB 6: Listener ---
          const _SCLNListenerDemo(),

          // --- TAB 7: Comparison ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSCLNBullet(Icons.compare,
                  'Three approaches to tracking widget size:'),
              const SizedBox(height: 12.0),
              // Comparison table
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.25)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.amber.shade700,
                      child: const Row(
                        children: [
                          Expanded(flex: 2, child: Text('Feature',
                              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                          Expanded(flex: 2, child: Text('Notifier',
                              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                          Expanded(flex: 2, child: Text('LayoutBuilder',
                              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                          Expanded(flex: 2, child: Text('GlobalKey',
                              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                        ],
                      ),
                    ),
                    ...comparisonData.asMap().entries.map((entry) {
                      final r = entry.value;
                      final isEven = entry.key.isEven;
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        color: isEven ? Colors.amber.withValues(alpha: 0.03) : Colors.white,
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text(r['feature']!,
                                style: TextStyle(fontSize: 10.5,
                                    fontWeight: FontWeight.w600, color: Colors.grey.shade800))),
                            Expanded(flex: 2, child: Text(r['notifier']!,
                                style: TextStyle(fontSize: 10.5, color: Colors.amber.shade700),
                                textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(r['layoutBuilder']!,
                                style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
                                textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(r['globalKey']!,
                                style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
                                textAlign: TextAlign.center)),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Detailed comparison cards
              ...<Map<String, dynamic>>[
                {
                  'title': 'SizeChangedLayoutNotifier',
                  'color': Colors.amber,
                  'pros': ['Zero boilerplate', 'Ancestor-aware', 'No rebuild needed'],
                  'cons': ['Only detects size changes', 'No size value in notification'],
                },
                {
                  'title': 'LayoutBuilder',
                  'color': Colors.blue,
                  'pros': ['Gives constraints', 'Reactive building', 'Very common'],
                  'cons': ['Rebuilds child on change', 'Local scope only'],
                },
                {
                  'title': 'GlobalKey measurement',
                  'color': Colors.green,
                  'pros': ['Exact Size value', 'Cross-tree access', 'RenderBox position'],
                  'cons': ['Post-frame delay', 'Manual scheduling', 'GlobalKey cost'],
                },
              ].map((approach) {
                final color = approach['color'] as MaterialColor;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: color.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(approach['title'] as String,
                          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                              color: color.shade700)),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pros', style: TextStyle(fontSize: 11.0,
                                    fontWeight: FontWeight.w600, color: Colors.green.shade600)),
                                const SizedBox(height: 4.0),
                                ...(approach['pros'] as List<String>).map((p) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.add_circle, size: 12.0,
                                          color: Colors.green.shade400),
                                      const SizedBox(width: 4.0),
                                      Expanded(child: Text(p,
                                          style: TextStyle(fontSize: 11.0,
                                              color: Colors.grey.shade700))),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cons', style: TextStyle(fontSize: 11.0,
                                    fontWeight: FontWeight.w600, color: Colors.red.shade600)),
                                const SizedBox(height: 4.0),
                                ...(approach['cons'] as List<String>).map((c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.remove_circle, size: 12.0,
                                          color: Colors.red.shade400),
                                      const SizedBox(width: 4.0),
                                      Expanded(child: Text(c,
                                          style: TextStyle(fontSize: 11.0,
                                              color: Colors.grey.shade700))),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('When to pick what', style: TextStyle(fontSize: 12.5,
                        fontWeight: FontWeight.w700, color: Colors.green.shade700)),
                    const SizedBox(height: 6.0),
                    buildSCLNBullet(Icons.arrow_right,
                        'Need parent to react to child size → SizeChangedLayoutNotifier',
                        color: Colors.amber.shade600),
                    buildSCLNBullet(Icons.arrow_right,
                        'Need to build differently based on space → LayoutBuilder',
                        color: Colors.blue.shade600),
                    buildSCLNBullet(Icons.arrow_right,
                        'Need exact pixel size cross-tree → GlobalKey measurement',
                        color: Colors.green.shade600),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 8: Summary ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade50, Colors.amber.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.photo_size_select_small, size: 40.0,
                        color: Colors.amber.shade700),
                    const SizedBox(height: 8.0),
                    Text('SizeChangedLayoutNotifier',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                            color: Colors.amber.shade800)),
                    const SizedBox(height: 4.0),
                    Text('Passive size-change detection via notifications',
                        style: TextStyle(fontSize: 12.5, color: Colors.amber.shade600,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ...summaryBullets,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quick Reference',
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Colors.amber.shade700)),
                    const SizedBox(height: 8.0),
                    Text(
                      '// Wrap content that may resize:\n'
                      'SizeChangedLayoutNotifier(\n'
                      '  child: AnimatedContainer(...),\n'
                      ')\n'
                      '\n'
                      '// Listen in an ancestor:\n'
                      'NotificationListener<\n'
                      '  SizeChangedLayoutNotification\n'
                      '>(\n'
                      '  onNotification: (_) {\n'
                      '    // handle size change\n'
                      '    return true;\n'
                      '  },\n'
                      '  child: ...,\n'
                      ')',
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                          color: Colors.grey.shade800, height: 1.35),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// _SCLNLiveDemo — Interactive size-change detection
// ============================================================
class _SCLNLiveDemo extends StatefulWidget {
  const _SCLNLiveDemo();

  @override
  State<_SCLNLiveDemo> createState() => _SCLNLiveDemoState();
}

class _SCLNLiveDemoState extends State<_SCLNLiveDemo> {
  double _width = 200.0;
  double _height = 100.0;
  int _notificationCount = 0;
  final List<String> _sizeLog = [];
  bool _showExtraContent = false;

  void _onSizeChanged() {
    setState(() {
      _notificationCount++;
      final timestamp = DateTime.now().toString().substring(11, 19);
      _sizeLog.insert(0, '[$timestamp] Notification #$_notificationCount — '
          'size changed!');
      if (_sizeLog.length > 15) _sizeLog.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Controls
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resize Controls', style: TextStyle(fontSize: 13.0,
                  fontWeight: FontWeight.w700, color: Colors.amber.shade700)),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text('Width: ${_width.toInt()}px',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                  Expanded(
                    child: Slider(
                      value: _width,
                      min: 80.0,
                      max: 350.0,
                      divisions: 27,
                      activeColor: Colors.amber.shade600,
                      onChanged: (v) => setState(() => _width = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Height: ${_height.toInt()}px',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                  Expanded(
                    child: Slider(
                      value: _height,
                      min: 40.0,
                      max: 200.0,
                      divisions: 16,
                      activeColor: Colors.amber.shade600,
                      onChanged: (v) => setState(() => _height = v),
                    ),
                  ),
                ],
              ),
              SwitchListTile(
                title: Text('Show extra content inside',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                subtitle: Text('Triggers internal size change',
                    style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500)),
                value: _showExtraContent,
                activeColor: Colors.amber.shade600,
                dense: true,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) => setState(() => _showExtraContent = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // Notification counter
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _notificationCount > 0
                ? Colors.green.withValues(alpha: 0.06)
                : Colors.grey.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _notificationCount > 0
                  ? Colors.green.withValues(alpha: 0.25)
                  : Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.notifications_active,
                  color: _notificationCount > 0
                      ? Colors.green.shade600
                      : Colors.grey.shade400,
                  size: 22.0),
              const SizedBox(width: 8.0),
              Text('Notifications received: $_notificationCount',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600,
                      color: _notificationCount > 0
                          ? Colors.green.shade700
                          : Colors.grey.shade500)),
              const Spacer(),
              if (_notificationCount > 0)
                TextButton(
                  onPressed: () => setState(() {
                    _notificationCount = 0;
                    _sizeLog.clear();
                  }),
                  child: Text('Reset', style: TextStyle(fontSize: 11.0,
                      color: Colors.amber.shade700)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // The tracked widget
        Center(
          child: NotificationListener<SizeChangedLayoutNotification>(
            onNotification: (notification) {
              _onSizeChanged();
              return true;
            },
            child: SizeChangedLayoutNotifier(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _width,
                height: _showExtraContent ? _height + 40.0 : _height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.shade200,
                      Colors.amber.shade400,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withValues(alpha: 0.3),
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.crop_free, color: Colors.white, size: 28.0),
                    const SizedBox(height: 4.0),
                    Text('${_width.toInt()} × ${(_showExtraContent ? _height + 40 : _height).toInt()}',
                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    if (_showExtraContent) ...[
                      const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text('Extra content!',
                            style: TextStyle(fontSize: 10.0, color: Colors.white)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        // Event log
        if (_sizeLog.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Log', style: TextStyle(fontSize: 12.0,
                    fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
                const SizedBox(height: 6.0),
                ..._sizeLog.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(entry, style: TextStyle(fontSize: 10.5,
                      fontFamily: 'monospace', color: Colors.grey.shade600)),
                )),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What to try', style: TextStyle(fontSize: 12.5,
                  fontWeight: FontWeight.w700, color: Colors.amber.shade700)),
              const SizedBox(height: 6.0),
              Text('• Drag the width/height sliders — each size change fires '
                  'a notification\n'
                  '• Toggle "extra content" — the container grows, triggering '
                  'another notification\n'
                  '• Watch the event log — each entry is a real '
                  'SizeChangedLayoutNotification\n'
                  '• Reset counter to start fresh',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// _SCLNListenerDemo — NotificationListener integration patterns
// ============================================================
class _SCLNListenerDemo extends StatefulWidget {
  const _SCLNListenerDemo();

  @override
  State<_SCLNListenerDemo> createState() => _SCLNListenerDemoState();
}

class _SCLNListenerDemoState extends State<_SCLNListenerDemo> {
  bool _isExpanded = false;
  int _listenerHits = 0;
  Color _indicatorColor = Colors.grey.shade300;
  String _listenerStatus = 'Waiting for size change...';

  void _handleNotification() {
    setState(() {
      _listenerHits++;
      _indicatorColor = Colors.green.shade400;
      _listenerStatus = 'Size changed! (hit #$_listenerHits)';
    });
    // Reset indicator after brief flash
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _indicatorColor = Colors.amber.shade200;
          _listenerStatus = 'Ready — listening for changes...';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Code pattern explanation
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pattern: Wrapping with NotificationListener',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700)),
              const SizedBox(height: 8.0),
              Text(
                'NotificationListener<SizeChangedLayoutNotification>(\n'
                '  onNotification: (notification) {\n'
                '    // This fires when child size changes.\n'
                '    // The notification has no size data —\n'
                '    // it just tells you "something changed".\n'
                '    setState(() => _sizeChanged = true);\n'
                '    return true; // stop bubbling\n'
                '  },\n'
                '  child: SizeChangedLayoutNotifier(\n'
                '    child: myDynamicWidget,\n'
                '  ),\n'
                ')',
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                    color: Colors.grey.shade800, height: 1.35),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        // Live listener demo
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Live listener demo', style: TextStyle(fontSize: 13.0,
                  fontWeight: FontWeight.w700, color: Colors.amber.shade700)),
              const SizedBox(height: 8.0),
              // Status indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _indicatorColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _indicatorColor),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: _indicatorColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(_listenerStatus,
                          style: TextStyle(fontSize: 12.0,
                              color: Colors.grey.shade700)),
                    ),
                    Text('Hits: $_listenerHits',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                            color: Colors.amber.shade700)),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              // The actual wrapped widget
              NotificationListener<SizeChangedLayoutNotification>(
                onNotification: (notification) {
                  _handleNotification();
                  return true;
                },
                child: SizeChangedLayoutNotifier(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.article, color: Colors.amber.shade600,
                                size: 20.0),
                            const SizedBox(width: 8.0),
                            Text('Content Card',
                                style: TextStyle(fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.amber.shade700)),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () => setState(() =>
                                  _isExpanded = !_isExpanded),
                              icon: Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                size: 18.0,
                              ),
                              label: Text(_isExpanded ? 'Collapse' : 'Expand',
                                  style: const TextStyle(fontSize: 11.0)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'This card can be expanded to show more content. '
                          'When it resizes, the SizeChangedLayoutNotifier '
                          'dispatches a notification.',
                          style: TextStyle(fontSize: 12.0,
                              color: Colors.grey.shade600, height: 1.3),
                        ),
                        if (_isExpanded) ...[
                          const SizedBox(height: 12.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Expanded details',
                                    style: TextStyle(fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.amber.shade700)),
                                const SizedBox(height: 4.0),
                                Text(
                                  'This extra content increases the card\'s height. '
                                  'The RenderSizeChangedWithCallback detects this '
                                  'and fires a notification to the ancestor '
                                  'NotificationListener.',
                                  style: TextStyle(fontSize: 11.5,
                                      color: Colors.grey.shade600, height: 1.35),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Container(
                                      width: 60.0, height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.image,
                                          color: Colors.amber.shade400, size: 18.0),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Container(
                                      width: 60.0, height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.insert_chart,
                                          color: Colors.amber.shade400, size: 18.0),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Container(
                                      width: 60.0, height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.pie_chart,
                                          color: Colors.amber.shade400, size: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text('Tap "Expand" / "Collapse" to trigger size change notifications.',
                  style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        // Return value explanation
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.question_mark, color: Colors.purple.shade600, size: 18.0),
                  const SizedBox(width: 6.0),
                  Text('Return value matters', style: TextStyle(fontSize: 12.5,
                      fontWeight: FontWeight.w700, color: Colors.purple.shade700)),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'onNotification returns bool:\n'
                '• true — notification consumed, stops bubbling\n'
                '• false — notification continues to ancestors\n\n'
                'Multiple NotificationListeners can form a chain. '
                'Return false if you want ancestors to also react.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // Chained listeners visualization
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chained listener pattern',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                      color: Colors.amber.shade700)),
              const SizedBox(height: 8.0),
              ...<Map<String, dynamic>>[
                {'label': 'Listener A (return false)', 'color': Colors.blue.shade100,
                    'border': Colors.blue.shade300, 'arrow': true},
                {'label': 'Listener B (return false)', 'color': Colors.green.shade100,
                    'border': Colors.green.shade300, 'arrow': true},
                {'label': 'Listener C (return true)', 'color': Colors.red.shade100,
                    'border': Colors.red.shade300, 'arrow': false},
              ].map((l) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: l['color'] as Color,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: l['border'] as Color),
                    ),
                    child: Text(l['label'] as String,
                        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
                        textAlign: TextAlign.center),
                  ),
                  if (l['arrow'] as bool)
                    Icon(Icons.arrow_upward, size: 16.0,
                        color: Colors.amber.shade400),
                ],
              )),
              const SizedBox(height: 4.0),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: const Text('SizeChangedLayoutNotifier + child',
                      style: TextStyle(fontSize: 11.0),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 8.0),
              Text('A and B both see the notification. C stops it.',
                  style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}
