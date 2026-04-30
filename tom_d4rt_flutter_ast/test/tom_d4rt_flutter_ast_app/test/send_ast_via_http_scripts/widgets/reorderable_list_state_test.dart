// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ReorderableListState
// Demonstrates ReorderableListState — the State object for
// ReorderableList that manages drag-to-reorder interactions.
// Covers the API (startItemDragReorder, cancelReorder), drag
// lifecycle, proxyDecorator customization, callback events,
// and practical reorderable list patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableListState Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ReorderableListState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.drag_handle,
      'title': 'Drag-to-Reorder Controller',
      'body': 'ReorderableListState is the State for ReorderableList '
          '(and ReorderableListView). It manages the drag recognizer, '
          'tracks the dragged item index, animates the gap where the '
          'item will land, and calls onReorder when the drag finishes.',
      'accent': Colors.cyan[800]!,
    },
    {
      'icon': Icons.api,
      'title': 'Two Key Methods',
      'body': 'startItemDragReorder(index, event, recognizer) — '
          'programmatically initiates a drag on a specific item. '
          'cancelReorder() — cancels any active drag and resets '
          'the list to its pre-drag state.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Delegates to SliverReorderableList',
      'body': 'Internally, ReorderableListState builds a CustomScrollView '
          'containing a SliverReorderableList. The actual reorder logic '
          'lives in SliverReorderableListState; the outer state '
          'delegates via a GlobalKey.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.brush,
      'title': 'Proxy Decorator',
      'body': 'While dragging, the item is rendered using a proxyDecorator '
          'callback that receives the child, index, and animation. '
          'This lets you add elevation, rotation, scaling, or color '
          'changes to the dragged item\'s appearance.',
      'accent': Colors.pink[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'startItemDragReorder',
      'signature': 'void startItemDragReorder({\n'
          '  required int index,\n'
          '  required PointerDownEvent event,\n'
          '  required MultiDragGestureRecognizer recognizer,\n'
          '})',
      'description': 'Initiates a drag reorder on the item at index. The '
          'recognizer takes ownership of the gesture. Typically called '
          'by ReorderableDragStartListener or '
          'ReorderableDelayedDragStartListener.',
      'icon': Icons.play_arrow,
      'color': Colors.cyan[800]!,
    },
    {
      'name': 'cancelReorder',
      'signature': 'void cancelReorder()',
      'description': 'Cancels any active drag operation. The dragged item '
          'returns to its original position. Safe to call when no drag '
          'is active. Call this before making major list changes.',
      'icon': Icons.cancel,
      'color': Colors.pink[700]!,
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 3: Live ReorderableListView
  // ============================================================
  print('=== Section 3: Live Demo ===');

  final listItems = <Map<String, dynamic>>[
    {'title': 'Design Review', 'subtitle': 'Q2 product roadmap', 'icon': Icons.design_services, 'color': Colors.cyan[400]!},
    {'title': 'Sprint Planning', 'subtitle': 'Backend team capacity', 'icon': Icons.calendar_month, 'color': Colors.pink[300]!},
    {'title': 'Code Review', 'subtitle': 'Auth module PR #247', 'icon': Icons.code, 'color': Colors.cyan[300]!},
    {'title': 'Security Audit', 'subtitle': 'Dependency scan results', 'icon': Icons.security, 'color': Colors.pink[400]!},
    {'title': 'Deploy v3.2', 'subtitle': 'Production rollout', 'icon': Icons.rocket_launch, 'color': Colors.cyan[500]!},
    {'title': 'Retrospective', 'subtitle': 'Sprint 14 feedback', 'icon': Icons.feedback, 'color': Colors.pink[200]!},
  ];

  print('  List items: ${listItems.length}');

  // ============================================================
  // SECTION 4: Drag Lifecycle
  // ============================================================
  print('=== Section 4: Drag Lifecycle ===');

  final dragPhases = <Map<String, dynamic>>[
    {
      'phase': 1,
      'title': 'Touch Down',
      'detail': 'User touches the drag handle. The DragStartListener '
          'captures the PointerDownEvent and creates a '
          'MultiDragGestureRecognizer.',
      'icon': Icons.touch_app,
      'color': Colors.cyan[800]!,
    },
    {
      'phase': 2,
      'title': 'Drag Start',
      'detail': 'startItemDragReorder is called. The state removes the '
          'item from the list flow and creates a proxy overlay widget. '
          'onReorderStart callback fires.',
      'icon': Icons.open_with,
      'color': Colors.pink[700]!,
    },
    {
      'phase': 3,
      'title': 'Drag Update',
      'detail': 'As the user drags, the proxy follows the finger. The '
          'state calculates which index the item would land at and '
          'opens a gap animation at that position.',
      'icon': Icons.swap_vert,
      'color': Colors.cyan[700]!,
    },
    {
      'phase': 4,
      'title': 'Drop / Release',
      'detail': 'User lifts finger. The proxy animates to the gap position. '
          'onReorder(oldIndex, newIndex) fires so you can update your '
          'data model. The list rebuilds with the new order.',
      'icon': Icons.place,
      'color': Colors.pink[600]!,
    },
    {
      'phase': 5,
      'title': 'Settle',
      'detail': 'The gap animation completes. The proxy is removed. '
          'onReorderEnd callback fires. The list is in its new order. '
          'All states are reset for the next drag.',
      'icon': Icons.check_circle,
      'color': Colors.cyan[600]!,
    },
  ];

  print('  Drag phases: ${dragPhases.length}');

  // ============================================================
  // SECTION 5: Proxy Decorator Patterns
  // ============================================================
  print('=== Section 5: Proxy Decorators ===');

  final proxyPatterns = <Map<String, dynamic>>[
    {
      'title': 'Material Elevation',
      'description': 'The default Material pattern: wrap in Material with '
          'elevation animated from 0 to 6. Gives a floating card effect.',
      'code': 'proxyDecorator: (child, index, anim) {\n'
          '  return Material(\n'
          '    elevation: lerpDouble(0, 6, anim.value)!,\n'
          '    child: child,\n'
          '  );\n'
          '}',
      'color': Colors.cyan[800]!,
    },
    {
      'title': 'Scale + Shadow',
      'description': 'Scale the proxy slightly larger and add a shadow to '
          'make it "pop" above the list.',
      'code': 'proxyDecorator: (child, index, anim) {\n'
          '  final scale = lerpDouble(1, 1.05, anim.value)!;\n'
          '  return Transform.scale(\n'
          '    scale: scale,\n'
          '    child: child,\n'
          '  );\n'
          '}',
      'color': Colors.pink[700]!,
    },
    {
      'title': 'Color Tint',
      'description': 'Apply a semi-transparent color overlay while dragging '
          'to indicate the item is being moved.',
      'code': 'proxyDecorator: (child, index, anim) {\n'
          '  return ColorFiltered(\n'
          '    colorFilter: ColorFilter.mode(\n'
          '      Colors.blue.withOpacity(0.1),\n'
          '      BlendMode.srcATop,\n'
          '    ),\n'
          '    child: child,\n'
          '  );\n'
          '}',
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Rotation Wobble',
      'description': 'Add a slight rotation using the animation value to '
          'give a "picked up" feeling.',
      'code': 'proxyDecorator: (child, index, anim) {\n'
          '  final rotation = lerpDouble(0, 0.02, anim.value)!;\n'
          '  return Transform.rotate(\n'
          '    angle: rotation,\n'
          '    child: child,\n'
          '  );\n'
          '}',
      'color': Colors.pink[600]!,
    },
  ];

  print('  Proxy patterns: ${proxyPatterns.length}');

  // ============================================================
  // SECTION 6: Callback Events
  // ============================================================
  print('=== Section 6: Callbacks ===');

  final callbacks = <Map<String, dynamic>>[
    {
      'name': 'onReorder',
      'signature': '(int oldIndex, int newIndex)',
      'description': 'REQUIRED. Called when the user drops the item at a '
          'new position. You must update your data model here. If '
          'oldIndex < newIndex, newIndex is decremented before the '
          'move (item was already removed from old position).',
      'required': true,
      'timing': 'On drop',
      'color': Colors.cyan[800]!,
    },
    {
      'name': 'onReorderStart',
      'signature': '(int index)',
      'description': 'Called when a drag operation begins. Use this to '
          'save the original order, show a visual indicator, or '
          'disable other interactions during the drag.',
      'required': false,
      'timing': 'On drag start',
      'color': Colors.pink[700]!,
    },
    {
      'name': 'onReorderEnd',
      'signature': '(int index)',
      'description': 'Called after the reorder animation finishes. The '
          'index is the final position. Use this to re-enable '
          'interactions or persist the new order to storage.',
      'required': false,
      'timing': 'After animation',
      'color': Colors.cyan[700]!,
    },
  ];

  print('  Callbacks: ${callbacks.length}');

  // ============================================================
  // SECTION 7: Widget Comparison
  // ============================================================
  print('=== Section 7: Widget Comparison ===');

  final widgetComparison = <Map<String, dynamic>>[
    {
      'widget': 'ReorderableListView',
      'state': 'ReorderableListState',
      'scroll': 'Built-in scroll',
      'use': 'Simple reorderable list',
    },
    {
      'widget': 'ReorderableList',
      'state': 'ReorderableListState',
      'scroll': 'Built-in scroll',
      'use': 'Same as ListView variant',
    },
    {
      'widget': 'SliverReorderableList',
      'state': 'SliverReorderableListState',
      'scroll': 'In CustomScrollView',
      'use': 'Combined with other slivers',
    },
  ];

  print('  Widget comparison rows: ${widgetComparison.length}');

  // ============================================================
  // SECTION 8: DragStartListener Variants
  // ============================================================
  print('=== Section 8: Drag Start Listeners ===');

  final listeners = <Map<String, dynamic>>[
    {
      'name': 'ReorderableDragStartListener',
      'description': 'Starts the drag immediately on pointer down. '
          'Best for handle-based reordering where the drag handle '
          'is a distinct region (like a drag_handle icon).',
      'icon': Icons.drag_handle,
      'color': Colors.cyan[800]!,
      'best': 'Drag handle UI',
    },
    {
      'name': 'ReorderableDelayedDragStartListener',
      'description': 'Starts the drag after a long-press delay. Best '
          'when the entire list tile is the drag target and you '
          'need to distinguish tap from drag.',
      'icon': Icons.timer,
      'color': Colors.pink[700]!,
      'best': 'Long-press to drag',
    },
  ];

  print('  Listeners: ${listeners.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan[800]!, Colors.pink[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.drag_handle, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'ReorderableListState',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'The state engine behind drag-to-reorder lists — managing '
                'drag recognizers, gap animations, proxy decorators, and '
                'reorder callbacks.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.cyan[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: API ----
        _sectionHeader('2. Key Methods', Icons.api, Colors.pink[700]!),
        SizedBox(height: 10),
        ...apiEntries.map((a) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(a['icon'] as IconData, color: a['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(a['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: a['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(a['signature'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                    SizedBox(height: 6),
                    Text(a['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Live ReorderableListView ----
        _sectionHeader('3. Live Task List', Icons.list, Colors.cyan[800]!),
        SizedBox(height: 10),
        Text(
          'A ReorderableListView displaying prioritized tasks. In an '
          'interactive app, drag handles would allow reordering:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          height: 340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.cyan[200]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: ReorderableListView.builder(
            itemCount: listItems.length,
            onReorder: (oldIndex, newIndex) {
              print('  Reorder: $oldIndex → $newIndex');
            },
            itemBuilder: (ctx, i) {
              final item = listItems[i];
              return Container(
                key: ValueKey('task_$i'),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (item['color'] as Color).withValues(alpha: 0.3)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 22),
                  ),
                  title: Text(item['title'] as String,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(item['subtitle'] as String,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('#${i + 1}', style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.grey[600])),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.drag_handle, color: Colors.grey[400]),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Drag Lifecycle ----
        _sectionHeader('4. Drag Lifecycle', Icons.timeline, Colors.pink[700]!),
        SizedBox(height: 10),
        ...dragPhases.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: p['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${p['phase']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(p['icon'] as IconData, size: 16, color: p['color'] as Color),
                            SizedBox(width: 6),
                            Text(p['title'] as String,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(p['detail'] as String,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Proxy Decorators ----
        _sectionHeader('5. Proxy Decorator Patterns', Icons.brush, Colors.cyan[800]!),
        SizedBox(height: 10),
        Text(
          'The proxyDecorator callback customizes the appearance of the '
          'item while it\'s being dragged:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        ...proxyPatterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                    SizedBox(height: 4),
                    Text(p['description'] as String, style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Callbacks ----
        _sectionHeader('6. Reorder Callbacks', Icons.notifications_active, Colors.pink[700]!),
        SizedBox(height: 10),
        ...callbacks.map((cb) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(cb['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: cb['color'] as Color)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (cb['required'] as bool) ? Colors.red[700] : Colors.grey[600],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text((cb['required'] as bool) ? 'REQUIRED' : 'OPTIONAL',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(cb['signature'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (cb['color'] as Color).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(cb['timing'] as String,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: cb['color'] as Color)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(cb['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 10),

        // ---- onReorder index adjustment note ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber[400]!),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.amber[800], size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Index Adjustment Rule',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.amber[900])),
                    SizedBox(height: 4),
                    Text(
                      'When oldIndex < newIndex, you must subtract 1 from '
                      'newIndex before inserting. The item was already '
                      'removed from oldIndex, shifting subsequent indices:',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'onReorder: (oldIndex, newIndex) {\n'
                        '  if (oldIndex < newIndex) newIndex -= 1;\n'
                        '  final item = items.removeAt(oldIndex);\n'
                        '  items.insert(newIndex, item);\n'
                        '}',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Widget Comparison ----
        _sectionHeader('7. Reorderable Widget Family', Icons.compare, Colors.cyan[800]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.cyan[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('State Class', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(widgetComparison.length, (i) {
                final w = widgetComparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.cyan[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(w['widget'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(w['state'] as String, style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(w['use'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 8: DragStartListener Variants ----
        _sectionHeader('8. Drag Start Listeners', Icons.touch_app, Colors.pink[700]!),
        SizedBox(height: 10),
        ...listeners.map((l) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (l['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(l['icon'] as IconData, color: l['color'] as Color, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(l['name'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: l['color'] as Color)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (l['color'] as Color).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(l['best'] as String,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: l['color'] as Color)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(l['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.drag_handle, color: Colors.cyan[600], size: 28),
              SizedBox(height: 6),
              Text(
                'ReorderableListState: the state engine that transforms '
                'pointer events into smooth drag-and-drop list reordering.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
