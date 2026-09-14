// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionListener – a widget that observes
// selection changes in its subtree via SelectionListenerNotifier.
// Uses ChangeNotifier pattern: create a SelectionListenerNotifier, pass
// it to SelectionListener, addListener to get notified, read .selection
// for status and range.
// Deep Demo: Concept, notifier lifecycle, status tracking, live demo,
// multi-listener, practical patterns, constructor reference, summary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionListener Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept – What is SelectionListener?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.hearing,
      'title': 'Selection Observer Widget',
      'body': 'SelectionListener is a widget that wraps content in a '
          'SelectionContainer and reports selection changes through a '
          'SelectionListenerNotifier. It does not manage selection – '
          'it only observes what the enclosing SelectionArea provides.',
    },
    {
      'icon': Icons.broadcast_on_personal,
      'title': 'SelectionListenerNotifier',
      'body': 'A ChangeNotifier that you create and pass to SelectionListener. '
          'Call addListener() to receive callbacks whenever selection changes. '
          'Access .selection for current SelectionDetails (status + range).',
    },
    {
      'icon': Icons.account_tree,
      'title': 'Works Inside SelectionArea',
      'body': 'Must be placed inside a SelectionArea (or SelectableRegion). '
          'SelectionListener wraps its child in a SelectionContainer with '
          'a special delegate that reports changes to the notifier.',
    },
    {
      'icon': Icons.tune,
      'title': 'Decoupled Architecture',
      'body': 'The notifier is created externally and passed in. This '
          'means multiple widgets can listen to the same notifier. '
          'The notifier survives widget rebuilds and can be shared.',
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
          color: Colors.cyan.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.cyan.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.cyan.shade700,
                    ),
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
  // SECTION 2: Notifier Lifecycle
  // ============================================================
  print('=== Section 2: Notifier Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Create SelectionListenerNotifier',
      'code': 'final notifier = SelectionListenerNotifier();',
      'desc': 'Create in initState or as a field. One notifier per listener.',
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'Pass to SelectionListener',
      'code': 'SelectionListener(\n'
          '  selectionNotifier: notifier,\n'
          '  child: Text("Content"),\n'
          ')',
      'desc': 'The listener registers its delegate with the notifier.',
      'color': Colors.purple,
    },
    {
      'step': '3',
      'title': 'Add Listener Callback',
      'code': 'notifier.addListener(() {\n'
          '  final details = notifier.selection;\n'
          '  print(details.status);\n'
          '  print(details.range);\n'
          '});',
      'desc': 'Subscribe to changes. Access status and range from selection.',
      'color': Colors.teal,
    },
    {
      'step': '4',
      'title': 'Read Selection Details',
      'code': 'final status = notifier.selection.status;\n'
          '// SelectionStatus.uncollapsed\n'
          '// SelectionStatus.collapsed\n'
          '// SelectionStatus.none',
      'desc': 'status tells you the current selection state. range has offsets.',
      'color': Colors.orange,
    },
    {
      'step': '5',
      'title': 'Dispose Notifier',
      'code': 'notifier.dispose();',
      'desc': 'Clean up in State.dispose(). Unregisters the delegate.',
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (final ls in lifecycleSteps) {
    final color = ls['color'] as Color;
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    child: Center(
                      child: Text(
                        ls['step'] as String,
                        style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    ls['title'] as String,
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey.shade50,
              child: Text(
                ls['code'] as String,
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade800),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                ls['desc'] as String,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: SelectionDetails & Status
  // ============================================================
  print('=== Section 3: Status ===');

  final statusStates = <Map<String, dynamic>>[
    {
      'status': 'SelectionStatus.none',
      'color': Colors.grey,
      'icon': Icons.deselect,
      'desc': 'No selection exists. The user has not selected anything '
          'or the selection has been cleared.',
    },
    {
      'status': 'SelectionStatus.collapsed',
      'color': Colors.orange,
      'icon': Icons.text_fields,
      'desc': 'Selection exists but has zero length – the cursor is '
          'positioned but no text is highlighted.',
    },
    {
      'status': 'SelectionStatus.uncollapsed',
      'color': Colors.green,
      'icon': Icons.select_all,
      'desc': 'Active selection with non-zero length. Text is highlighted '
          'and can be copied or acted upon.',
    },
  ];

  final statusCards = <Widget>[];
  for (final ss in statusStates) {
    final color = ss['color'] as Color;
    statusCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
              ),
              child: Icon(ss['icon'] as IconData, color: color, size: 22.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ss['status'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    ss['desc'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
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
  // SECTION 4: Comparison
  // ============================================================
  print('=== Section 4: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'feature': 'API Pattern',
      'listener': 'ChangeNotifier (addListener)',
      'area': 'Callback (onSelectionChanged)',
    },
    {
      'feature': 'Data Exposed',
      'listener': 'SelectionDetails (status + range)',
      'area': 'SelectedContent (plainText)',
    },
    {
      'feature': 'Multiple Consumers',
      'listener': 'Yes – share the notifier',
      'area': 'No – single callback',
    },
    {
      'feature': 'Selection Text',
      'listener': 'Not directly (status/range only)',
      'area': 'Yes – plainText string',
    },
    {
      'feature': 'Subtree Scoping',
      'listener': 'Yes – only its child subtree',
      'area': 'Entire wrapped region',
    },
    {
      'feature': 'Widget Output',
      'listener': 'Wraps in SelectionContainer',
      'area': 'Full selection UI + handles',
    },
  ];

  final compTableRows = <TableRow>[];
  compTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Feature', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.grey.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('SelectionListener', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('SelectionArea', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.blue.shade700)),
        ),
      ],
    ),
  );
  for (final cr in comparisonRows) {
    compTableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cr['feature'] as String, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cr['listener'] as String, style: TextStyle(fontSize: 11.0, color: Colors.cyan.shade800)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cr['area'] as String, style: TextStyle(fontSize: 11.0, color: Colors.blue.shade800)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SLListenerLiveDemo();

  // ============================================================
  // SECTION 6: Multi-Listener
  // ============================================================
  print('=== Section 6: Multi-Listener ===');

  final multiDemo = _SLMultiListenerDemo();

  // ============================================================
  // SECTION 7: Practical Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'icon': Icons.analytics,
      'title': 'Selection Analytics',
      'color': Colors.blue,
      'body': 'Track selection status transitions to understand user '
          'interaction patterns. Log when selections become uncollapsed '
          'to measure engagement with specific content sections.',
      'code': 'notifier.addListener(() {\n'
          '  if (notifier.selection.status ==\n'
          '      SelectionStatus.uncollapsed) {\n'
          '    analytics.log("selection_started");\n'
          '  }\n'
          '});',
    },
    {
      'icon': Icons.dashboard_customize,
      'title': 'Selection-Aware Toolbar',
      'color': Colors.green,
      'body': 'Show or hide a floating toolbar based on selection status. '
          'When status changes to uncollapsed, show copy/share options. '
          'When status returns to none, hide the toolbar.',
      'code': 'notifier.addListener(() {\n'
          '  final hasSelection = notifier\n'
          '    .selection.status ==\n'
          '    SelectionStatus.uncollapsed;\n'
          '  showToolbar(hasSelection);\n'
          '});',
    },
    {
      'icon': Icons.text_snippet,
      'title': 'Status Bar Indicator',
      'color': Colors.purple,
      'body': 'Display the current selection status in a status bar. '
          'Use AnimatedBuilder or ListenableBuilder with the notifier '
          'to rebuild only the status indicator widget.',
      'code': 'ListenableBuilder(\n'
          '  listenable: notifier,\n'
          '  builder: (ctx, _) {\n'
          '    return Text(\n'
          '      notifier.selection.status.name);\n'
          '  },\n'
          ')',
    },
    {
      'icon': Icons.share,
      'title': 'Scoped Section Tracking',
      'color': Colors.orange,
      'body': 'Place individual listeners on different content sections '
          'to know which section the user is selecting from. Each '
          'listener has its own notifier for independent tracking.',
      'code': 'SelectionListener(\n'
          '  selectionNotifier: sectionNotifier,\n'
          '  child: sectionContent,\n'
          ')',
    },
  ];

  final patternCards = <Widget>[];
  for (final pat in patterns) {
    final color = pat['color'] as Color;
    patternCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(pat['icon'] as IconData, color: color, size: 22.0),
                  const SizedBox(width: 8.0),
                  Text(
                    pat['title'] as String,
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                pat['body'] as String,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                pat['code'] as String,
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.hearing, 'text': 'SelectionListener observes selection via SelectionListenerNotifier'},
    {'icon': Icons.broadcast_on_personal, 'text': 'Notifier exposes .selection with status and range'},
    {'icon': Icons.account_tree, 'text': 'Must be placed inside a SelectionArea to function'},
    {'icon': Icons.layers, 'text': 'Multiple listeners with independent notifiers for section tracking'},
    {'icon': Icons.sync, 'text': 'Uses ChangeNotifier pattern: addListener / removeListener'},
    {'icon': Icons.delete_outline, 'text': 'Always dispose the notifier in State.dispose()'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.cyan.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SelectionListener'),
        backgroundColor: Colors.cyan.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Lifecycle'),
            Tab(text: 'Status'),
            Tab(text: 'Comparison'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Multi-Listener'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('What is SelectionListener?',
                    'A widget that wraps its child in a SelectionContainer '
                    'and reports selection changes through a '
                    'SelectionListenerNotifier (ChangeNotifier pattern).'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Lifecycle
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('Notifier Lifecycle',
                    'Step-by-step: create notifier, pass to widget, '
                    'add listener, read selection details, dispose.'),
                const SizedBox(height: 14.0),
                ...lifecycleWidgets,
              ],
            ),
          ),
          // Tab 3: Status
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('SelectionStatus Values',
                    'The selection details expose a SelectionStatus '
                    'indicating the current selection state.'),
                const SizedBox(height: 14.0),
                ...statusCards,
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'SelectionDetails also exposes .range which gives '
                          'the SelectedContentRange with start and end offsets '
                          'local to the SelectionListener subtree.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('SelectionListener vs SelectionArea',
                    'Different approaches to observing selection events.'),
                const SizedBox(height: 14.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1.2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      border: TableBorder.symmetric(
                        inside: BorderSide(color: Colors.grey.shade200),
                      ),
                      children: compTableRows,
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('When to Use Which', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
                      const SizedBox(height: 6.0),
                      Text(
                        'Use SelectionListener when you need structural/status '
                        'information (is something selected? where?). Use '
                        'SelectionArea.onSelectionChanged when you need the '
                        'actual selected text content.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('Live Selection Listener',
                    'Select text below and watch the notifier report '
                    'status changes in real time.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Multi-Listener
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('Independent Section Listeners',
                    'Two listeners with separate notifiers tracking '
                    'different content sections independently.'),
                const SizedBox(height: 14.0),
                multiDemo,
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('Practical Integration Patterns',
                    'Common ways to use SelectionListener in production.'),
                const SizedBox(height: 14.0),
                ...patternCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSL2Bullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan.withValues(alpha: 0.05),
                        Colors.teal.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSL2Bullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.cyan.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.cyan.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Listener Demo
// ---------------------------------------------------------------------------
class _SLListenerLiveDemo extends StatefulWidget {
  @override
  State<_SLListenerLiveDemo> createState() => _SLListenerLiveDemoState();
}

class _SLListenerLiveDemoState extends State<_SLListenerLiveDemo> {
  final SelectionListenerNotifier _notifier = SelectionListenerNotifier();
  String _statusText = 'none';
  int _eventCount = 0;
  final List<String> _statusLog = [];

  @override
  void initState() {
    super.initState();
    _notifier.addListener(_onSelectionChange);
  }

  void _onSelectionChange() {
    setState(() {
      _eventCount++;
      if (_notifier.registered) {
        final details = _notifier.selection;
        _statusText = details.status.name;
        final entry = '#$_eventCount: ${details.status.name}';
        _statusLog.insert(0, entry);
        if (_statusLog.length > 10) _statusLog.removeLast();
      }
    });
  }

  @override
  void dispose() {
    _notifier.removeListener(_onSelectionChange);
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    switch (_statusText) {
      case 'uncollapsed':
        statusColor = Colors.green;
        statusIcon = Icons.select_all;
        break;
      case 'collapsed':
        statusColor = Colors.orange;
        statusIcon = Icons.text_fields;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.deselect;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select text to trigger the listener notifier',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12.0),
          SelectionArea(
            child: SelectionListener(
              selectionNotifier: _notifier,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SelectionListener uses the ChangeNotifier pattern. '
                      'A SelectionListenerNotifier is created externally and '
                      'passed to the widget. You call addListener() to '
                      'receive notifications when selection changes.',
                      style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'The notifier exposes .selection which returns a '
                      'SelectionDetails object with status (none, collapsed, '
                      'uncollapsed) and range (start/end offsets). This gives '
                      'structural information about the selection.',
                      style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          // Status panel
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.hearing, size: 16.0, color: Colors.cyan.shade700),
                    const SizedBox(width: 6.0),
                    Text('Notifier Output', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('$_eventCount events', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                // Current status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 24.0),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Status', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
                          Text(
                            'SelectionStatus.$_statusText',
                            style: TextStyle(fontSize: 13.0, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: statusColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                // Status log
                if (_statusLog.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Event Log', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.grey.shade500)),
                        const SizedBox(height: 4.0),
                        ..._statusLog.take(6).map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            entry,
                            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                          ),
                        )),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Multi-Listener Demo
// ---------------------------------------------------------------------------
class _SLMultiListenerDemo extends StatefulWidget {
  @override
  State<_SLMultiListenerDemo> createState() => _SLMultiListenerDemoState();
}

class _SLMultiListenerDemoState extends State<_SLMultiListenerDemo> {
  final SelectionListenerNotifier _notifierA = SelectionListenerNotifier();
  final SelectionListenerNotifier _notifierB = SelectionListenerNotifier();
  String _statusA = 'none';
  String _statusB = 'none';
  int _eventsA = 0;
  int _eventsB = 0;

  @override
  void initState() {
    super.initState();
    _notifierA.addListener(_onChangeA);
    _notifierB.addListener(_onChangeB);
  }

  void _onChangeA() {
    setState(() {
      _eventsA++;
      if (_notifierA.registered) {
        _statusA = _notifierA.selection.status.name;
      }
    });
  }

  void _onChangeB() {
    setState(() {
      _eventsB++;
      if (_notifierB.registered) {
        _statusB = _notifierB.selection.status.name;
      }
    });
  }

  @override
  void dispose() {
    _notifierA.removeListener(_onChangeA);
    _notifierB.removeListener(_onChangeB);
    _notifierA.dispose();
    _notifierB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Two Independent Listeners',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Each section has its own SelectionListenerNotifier. '
            'Selecting in one section only triggers that notifier.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          SelectionArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SelectionListener(
                    selectionNotifier: _notifierA,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.hearing, size: 14.0, color: Colors.blue),
                              const SizedBox(width: 4.0),
                              Text('Section A', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'This paragraph is monitored by Notifier A. '
                            'Selecting here will only trigger the blue '
                            'status panel below.',
                            style: TextStyle(fontSize: 12.0, height: 1.45),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: SelectionListener(
                    selectionNotifier: _notifierB,
                    child: Container(
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
                              Icon(Icons.hearing, size: 14.0, color: Colors.purple),
                              const SizedBox(width: 4.0),
                              Text('Section B', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.purple)),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'This paragraph is monitored by Notifier B. '
                            'Selecting here will only trigger the purple '
                            'status panel below.',
                            style: TextStyle(fontSize: 12.0, height: 1.45),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(child: _statusPanel('Notifier A', _statusA, _eventsA, Colors.blue)),
              const SizedBox(width: 10.0),
              Expanded(child: _statusPanel('Notifier B', _statusB, _eventsB, Colors.purple)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusPanel(String label, String status, int events, Color color) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: color)),
              const Spacer(),
              Text('$events', style: TextStyle(fontSize: 10.0, color: color)),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
