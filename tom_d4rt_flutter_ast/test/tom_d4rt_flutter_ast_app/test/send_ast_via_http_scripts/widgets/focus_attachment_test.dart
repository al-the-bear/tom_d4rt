// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — FocusAttachment
// Demonstrates FocusAttachment — the link object connecting a FocusNode
// to the widget tree. Covers the lifecycle (attach/reparent/detach),
// State management, relationship with Focus widget, debugging
// detached nodes, and practical patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusAttachment Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusAttachment?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.link,
      'title': 'The Link Between Node and Tree',
      'body': 'FocusAttachment is the object returned when you call '
          'FocusNode.attach(). It represents the live connection '
          'between a FocusNode and a specific BuildContext in the '
          'widget tree. Without it, the FocusNode is a detached '
          'object that cannot participate in focus traversal.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'The Bridge in Focus Architecture',
      'body': 'Flutter\'s focus system has three layers: (1) FocusNode '
          'holds focus state, (2) FocusAttachment connects it to the '
          'tree, (3) Focus widget manages both. Most developers '
          'interact only with the Focus widget, which handles '
          'attach/detach automatically.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.handyman,
      'title': 'Manual Management for Custom Widgets',
      'body': 'When building custom focusable widgets without using '
          'the Focus widget, you must manage FocusAttachment yourself. '
          'Call node.attach() in initState, attachment.reparent() in '
          'build, and attachment.detach() in dispose. Getting this '
          'wrong causes focus-related crashes.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Usually Automatic',
      'body': 'The Focus widget class handles FocusAttachment '
          'internally. It calls attach() when created, reparent() '
          'on every build, and detach() on dispose. For most apps, '
          'you never touch FocusAttachment directly — but '
          'understanding it helps debug focus issues.',
      'accent': Colors.amber[800]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Lifecycle
  // ============================================================
  print('=== Section 2: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'phase': 'attach',
      'step': 1,
      'icon': Icons.power,
      'color': Colors.deepOrange[700]!,
      'when': 'initState() / first use',
      'what': 'FocusNode.attach(context)',
      'detail': 'Creates the FocusAttachment and registers the node '
          'with the focus manager. The node becomes part of the '
          'focus tree but is not yet positioned (no parent). '
          'Returns the FocusAttachment object that you must store.',
    },
    {
      'phase': 'reparent',
      'step': 2,
      'icon': Icons.swap_horiz,
      'color': Colors.amber[700]!,
      'when': 'Every build() call',
      'what': 'attachment.reparent()',
      'detail': 'Ensures the FocusNode is correctly positioned in the '
          'focus tree relative to its parent FocusScope. Must be '
          'called in build() because the widget tree structure may '
          'have changed between builds. This is the critical step '
          'most custom implementations forget.',
    },
    {
      'phase': 'reparent (with parent)',
      'step': 3,
      'icon': Icons.account_tree,
      'color': Colors.deepOrange[600]!,
      'when': 'When moving nodes',
      'what': 'attachment.reparent(parent: newParent)',
      'detail': 'Optionally reparent to a specific FocusNode instead '
          'of the nearest FocusScopeNode ancestor. Used for advanced '
          'focus tree manipulation where automatic ancestor '
          'detection is insufficient.',
    },
    {
      'phase': 'detach',
      'step': 4,
      'icon': Icons.power_off,
      'color': Colors.red[600]!,
      'when': 'dispose()',
      'what': 'attachment.detach()',
      'detail': 'Removes the FocusNode from the focus tree. The node '
          'still exists as an object but is no longer connected. '
          'After detach, isAttached becomes false. Must be called '
          'before the widget is removed from the tree.',
    },
    {
      'phase': 'cleanup',
      'step': 5,
      'icon': Icons.delete_outline,
      'color': Colors.grey[600]!,
      'when': 'After detach',
      'what': 'node.dispose() (optional)',
      'detail': 'If you own the FocusNode, dispose it after detaching. '
          'If the node was passed in from a parent widget, do NOT '
          'dispose it — the parent owns its lifecycle. The Focus '
          'widget handles this distinction automatically.',
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 3: Properties and Methods
  // ============================================================
  print('=== Section 3: API ===');

  final api = <Map<String, dynamic>>[
    {
      'name': 'reparent()',
      'kind': 'method',
      'icon': Icons.swap_horiz,
      'color': Colors.deepOrange[700]!,
      'description': 'Ensures the attached FocusNode is correctly '
          'positioned in the focus tree. Call in build(). Finds '
          'the nearest FocusScopeNode ancestor and makes it the '
          'parent unless a specific parent is provided.',
    },
    {
      'name': 'reparent(parent: node)',
      'kind': 'method',
      'icon': Icons.account_tree,
      'color': Colors.amber[700]!,
      'description': 'Reparent to a specific FocusNode rather than '
          'auto-detecting the parent. Used in rare cases where '
          'the focus tree doesn\'t match the widget tree hierarchy.',
    },
    {
      'name': 'detach()',
      'kind': 'method',
      'icon': Icons.link_off,
      'color': Colors.red[600]!,
      'description': 'Disconnects the FocusNode from the focus tree. '
          'Removes parent-child relationships. After this, the '
          'node\'s isAttached returns false and it cannot receive '
          'or hold focus.',
    },
    {
      'name': 'isAttached',
      'kind': 'property',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'description': 'Returns true if the attachment is still active '
          '(detach() has not been called). Check this before '
          'performing focus operations to avoid exceptions on '
          'detached nodes.',
    },
  ];

  print('  Prepared ${api.length} API items');

  // ============================================================
  // SECTION 4: Focus Widget Internal Pattern
  // ============================================================
  print('=== Section 4: Focus Widget Pattern ===');

  final focusWidgetSteps = <Map<String, dynamic>>[
    {
      'phase': 'createState()',
      'icon': Icons.add_circle,
      'color': Colors.deepOrange[700]!,
      'description': 'Focus widget creates its State. No FocusNode '
          'or attachment exists yet. The State will manage the '
          'entire lifecycle.',
    },
    {
      'phase': 'initState()',
      'icon': Icons.play_arrow,
      'color': Colors.amber[700]!,
      'description': 'State creates or receives a FocusNode. Calls '
          'node.attach(context) which returns the FocusAttachment. '
          'Stores the attachment as a field. Sets up any listeners '
          'on the node.',
    },
    {
      'phase': 'build()',
      'icon': Icons.sync,
      'color': Colors.deepOrange[600]!,
      'description': 'Every build call runs attachment.reparent(). '
          'This is mandatory because the widget tree above this '
          'point may have changed (e.g., new FocusScope inserted). '
          'Without reparent, the node may have a stale parent.',
    },
    {
      'phase': 'didChangeDependencies()',
      'icon': Icons.compare_arrows,
      'color': Colors.amber[800]!,
      'description': 'If the BuildContext changes (rare), the Focus '
          'widget may detach and re-attach with the new context. '
          'This ensures the attachment always refers to the '
          'correct location in the tree.',
    },
    {
      'phase': 'dispose()',
      'icon': Icons.stop,
      'color': Colors.red[600]!,
      'description': 'State calls attachment.detach() and then '
          'node.dispose() if it owns the node (not passed via '
          'widget.focusNode parameter). Removes the node from '
          'the focus tree cleanly.',
    },
  ];

  print('  Prepared ${focusWidgetSteps.length} Focus widget steps');

  // ============================================================
  // SECTION 5: Common Mistakes
  // ============================================================
  print('=== Section 5: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'mistake': 'Forgetting reparent() in build',
      'icon': Icons.error_outline,
      'color': Colors.red[600]!,
      'consequence': 'Focus node has wrong parent after tree rebuild. '
          'Focus traversal may skip this widget or route focus '
          'to the wrong scope. Intermittent, hard-to-debug issue.',
      'fix': 'Always call attachment.reparent() at the start of '
          'build(). The Focus widget does this automatically.',
    },
    {
      'mistake': 'Calling attach() multiple times',
      'icon': Icons.warning_amber,
      'color': Colors.orange[700]!,
      'consequence': 'Creates multiple attachments for the same node. '
          'Previous attachments become invalid. Assertion error in '
          'debug mode.',
      'fix': 'Call attach() exactly once per lifecycle. Store the '
          'returned attachment. Use reparent() for subsequent builds.',
    },
    {
      'mistake': 'Not detaching on dispose',
      'icon': Icons.error_outline,
      'color': Colors.red[700]!,
      'consequence': 'FocusNode remains in the focus tree after the '
          'widget is removed. Memory leak. May cause errors when '
          'the focus manager tries to notify a dead node.',
      'fix': 'Always call attachment.detach() in dispose(). Then '
          'dispose the node if you own it.',
    },
    {
      'mistake': 'Using a detached node',
      'icon': Icons.warning_amber,
      'color': Colors.orange[600]!,
      'consequence': 'Calling requestFocus() on a detached node '
          'throws. Checking hasFocus returns false but gives no '
          'indication of why.',
      'fix': 'Check isAttached before focus operations. Re-attach '
          'if needed, or ensure proper lifecycle management.',
    },
    {
      'mistake': 'Disposing a borrowed node',
      'icon': Icons.error_outline,
      'color': Colors.red[500]!,
      'consequence': 'If the FocusNode was passed in from a parent '
          'widget, disposing it removes it from the parent\'s '
          'control. The parent may crash when trying to use it.',
      'fix': 'Only dispose nodes you created. If the node was '
          'passed via constructor, just detach — don\'t dispose.',
    },
  ];

  print('  Prepared ${mistakes.length} common mistakes');

  // ============================================================
  // SECTION 6: StatefulWidget Example Pattern
  // ============================================================
  print('=== Section 6: Manual Pattern ===');

  final manualCodeSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Declare fields',
      'icon': Icons.text_fields,
      'color': Colors.deepOrange[700]!,
      'code': 'late FocusNode _focusNode;\n'
          'FocusAttachment? _attachment;',
      'note': 'Node and attachment as instance fields. '
          'Attachment is nullable until initState.',
    },
    {
      'step': 2,
      'label': 'initState: create and attach',
      'icon': Icons.play_arrow,
      'color': Colors.amber[700]!,
      'code': '_focusNode = FocusNode(debugLabel: \'myField\');\n'
          '_attachment = _focusNode.attach(context);',
      'note': 'Create node with debug label for easier '
          'debugging. Attach returns the attachment.',
    },
    {
      'step': 3,
      'label': 'build: reparent',
      'icon': Icons.sync,
      'color': Colors.deepOrange[600]!,
      'code': '_attachment!.reparent();\n'
          'return GestureDetector(...);',
      'note': 'Always reparent first in build. Then '
          'build your widget tree.',
    },
    {
      'step': 4,
      'label': 'dispose: detach and dispose',
      'icon': Icons.delete_outline,
      'color': Colors.red[600]!,
      'code': '_attachment?.detach();\n'
          '_focusNode.dispose();',
      'note': 'Detach first, then dispose the node. '
          'Order matters for clean teardown.',
    },
  ];

  print('  Prepared ${manualCodeSteps.length} manual code steps');

  // ============================================================
  // SECTION 7: Debug & Inspect
  // ============================================================
  print('=== Section 7: Debugging ===');

  final debugTips = <Map<String, dynamic>>[
    {
      'tip': 'Use debugLabel on FocusNode',
      'icon': Icons.label,
      'color': Colors.deepOrange[700]!,
      'description': 'Pass a descriptive debugLabel when creating '
          'FocusNode. It appears in focus tree dumps and DevTools, '
          'making it easy to identify which node belongs to which '
          'widget when debugging attachment issues.',
    },
    {
      'tip': 'FocusManager.instance.rootScope',
      'icon': Icons.account_tree,
      'color': Colors.amber[700]!,
      'description': 'The root of the focus tree. Walk it to see all '
          'attached nodes and their hierarchy. A detached node '
          'will not appear in this tree. Useful for verifying '
          'that your attachment is working.',
    },
    {
      'tip': 'debugDumpFocusTree()',
      'icon': Icons.bug_report,
      'color': Colors.deepOrange[600]!,
      'description': 'Call this function to print the entire focus '
          'tree to the console. Shows parent-child relationships, '
          'which node has focus, and debug labels. Invaluable for '
          'diagnosing focus traversal problems.',
    },
    {
      'tip': 'DevTools Focus Inspector',
      'icon': Icons.developer_board,
      'color': Colors.amber[800]!,
      'description': 'Flutter DevTools has a widget inspector that '
          'shows focus information. Select a widget to see its '
          'FocusNode, whether it is attached, its parent scope, '
          'and whether it currently has focus.',
    },
  ];

  print('  Prepared ${debugTips.length} debug tips');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'name': 'Custom Text Field',
      'icon': Icons.text_fields,
      'color': Colors.deepOrange[700]!,
      'description': 'A custom text input widget manages its own '
          'FocusNode and attachment. On tap, it calls '
          'node.requestFocus(). On focus change, it shows/hides '
          'the cursor and border highlight. Attachment lifecycle '
          'is tied to State lifecycle.',
    },
    {
      'name': 'Game Input Handler',
      'icon': Icons.gamepad,
      'color': Colors.amber[700]!,
      'description': 'A game widget attaches a FocusNode to receive '
          'keyboard events without showing any visual focus '
          'indicator. The attachment connects the node to the tree '
          'so RawKeyboardListener works. Detach on pause/dispose.',
    },
    {
      'name': 'Focus-on-Mount Pattern',
      'icon': Icons.open_in_new,
      'color': Colors.deepOrange[600]!,
      'description': 'A dialog or screen that should auto-focus a '
          'specific field on mount. In initState, create node and '
          'attach it. Post-frame callback calls requestFocus(). '
          'The attachment ensures the node is in the tree before '
          'focus is requested.',
    },
    {
      'name': 'Conditional Focus',
      'icon': Icons.toggle_on,
      'color': Colors.amber[800]!,
      'description': 'A widget that is conditionally focusable based '
          'on an enabled/disabled state. When disabled, detach the '
          'attachment and unfocus. When re-enabled, re-attach. '
          'This pattern prevents disabled widgets from receiving '
          'focus via keyboard traversal.',
    },
    {
      'name': 'Focus Restoration',
      'icon': Icons.restore,
      'color': Colors.deepOrange[800]!,
      'description': 'When navigating back to a previous screen, '
          'restore focus to the last focused element. Store the '
          'FocusNode reference. On return, if the attachment is '
          'still valid (isAttached), call requestFocus() to '
          'restore the user\'s position.',
    },
  ];

  print('  Prepared ${realWorldPatterns.length} patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final finalTips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Focus Widget Does It All',
      'body': 'In 99% of cases, use the Focus widget or '
          'FocusableActionDetector. They manage attachment '
          'internally. Only manage FocusAttachment yourself when '
          'building truly custom focus-aware primitives.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Reparent Is Not Optional',
      'body': 'Every build must call reparent(). Even if you think '
          'the tree didn\'t change, a parent might have rebuilt. '
          'Reparent is idempotent when nothing changed — it is '
          'cheap to call but expensive to forget.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Tab Navigation',
      'body': 'The quickest way to verify your attachment is correct: '
          'press Tab and see if focus reaches your widget in the '
          'expected order. If it is skipped, the attachment is '
          'likely missing or has the wrong parent.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Context Must Be Stable',
      'body': 'The BuildContext passed to attach() must remain valid '
          'for the attachment\'s lifetime. If the context becomes '
          'invalid (widget removed), the attachment breaks. This '
          'is why attach is called in initState, not in build.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'One Attachment Per Node',
      'body': 'A FocusNode can have only one active attachment at '
          'a time. Calling attach() again creates a new attachment '
          'and invalidates the previous one. This is by design — '
          'a node represents one location in the tree.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Composition Over Inheritance',
      'body': 'Don\'t subclass FocusAttachment. Instead, compose '
          'focus behavior by wrapping FocusNode management in a '
          'mixin or helper class. The attachment API is deliberately '
          'minimal to encourage composition.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${finalTips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('FocusAttachment'),
      backgroundColor: Colors.deepOrange[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange[700]!, Colors.amber[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.link, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FocusAttachment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The link object that connects a FocusNode to '
                  'the widget tree. Manages the lifecycle of the '
                  'connection: attach, reparent on every build, '
                  'and detach on dispose. Usually handled '
                  'automatically by the Focus widget.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _attHead('1', 'What is FocusAttachment?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Lifecycle ──
          _attHead('2', 'Attachment Lifecycle'),
          SizedBox(height: 12),
          ...lifecycleSteps.map((ls) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ls['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: ls['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ls['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(ls['icon'] as IconData,
                                  color: ls['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Text(ls['phase'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: ls['color'] as Color)),
                              Spacer(),
                              _attTag(ls['when'] as String,
                                  Colors.grey[500]!),
                            ]),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(ls['what'] as String,
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 10,
                                      color: Colors.deepOrange[800])),
                            ),
                            SizedBox(height: 4),
                            Text(ls['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: API ──
          _attHead('3', 'Properties & Methods'),
          SizedBox(height: 12),
          ...api.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: item['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(item['icon'] as IconData,
                            color: item['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(item['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: item['color'] as Color)),
                        ),
                        _attTag(item['kind'] as String,
                            Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(item['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Focus Widget Pattern ──
          _attHead('4', 'How Focus Widget Manages It'),
          SizedBox(height: 12),
          ...focusWidgetSteps.asMap().entries.map((entry) {
            final idx = entry.key;
            final step = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: idx == focusWidgetSteps.length - 1
                      ? Colors.red[50]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    left: BorderSide(
                        color: step['color'] as Color, width: 4),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ],
                ),
                child: Row(children: [
                  Icon(step['icon'] as IconData,
                      color: step['color'] as Color, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step['phase'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: step['color'] as Color)),
                        SizedBox(height: 2),
                        Text(step['description'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[700],
                                height: 1.3)),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 5: Common Mistakes ──
          _attHead('5', 'Common Mistakes'),
          SizedBox(height: 12),
          ...mistakes.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['mistake'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: m['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(m['consequence'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.red[800],
                                height: 1.3)),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check, size: 14,
                                color: Colors.green[700]),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(m['fix'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green[800],
                                      height: 1.3)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Manual Code Steps ──
          _attHead('6', 'Manual StatefulWidget Pattern'),
          SizedBox(height: 12),
          ...manualCodeSteps.map((cs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: cs['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: cs['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('${cs['step']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10)),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(cs['icon'] as IconData,
                            color: cs['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Text(cs['label'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cs['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.green[300],
                                height: 1.4)),
                      ),
                      SizedBox(height: 4),
                      Text(cs['note'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Debugging ──
          _attHead('7', 'Debugging Focus Attachment'),
          SizedBox(height: 12),
          ...debugTips.map((dt) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: dt['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(dt['icon'] as IconData,
                            color: dt['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(dt['tip'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Text(dt['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _attHead('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realWorldPatterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _attHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...finalTips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of FocusAttachment Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _attHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepOrange[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small tag/badge
// ──────────────────────────────────────────────────────────
Widget _attTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
