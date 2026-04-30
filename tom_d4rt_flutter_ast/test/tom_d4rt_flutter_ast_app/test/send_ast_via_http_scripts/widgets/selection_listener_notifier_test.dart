// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionListenerNotifier – not a real Flutter
// widget. This demo covers the conceptual *pattern* of listening and
// notifying about selection changes in the Flutter selection system,
// using ValueNotifier<String> and ChangeNotifier to show how custom
// selection listeners work.  Also demonstrates the real
// onSelectionChanged callback on SelectionArea.
// Deep Demo: Notifier patterns, real-time selection tracking, event
// history, custom listener widgets, debounce simulation, and analytics.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionListenerNotifier Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept – Listening to Selection
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.notifications_active,
      'title': 'Selection Events',
      'body': 'The Flutter selection system emits events when the user '
          'starts, updates, or ends a selection. SelectionArea exposes '
          'an onSelectionChanged callback for reacting to these events.',
    },
    {
      'icon': Icons.hearing,
      'title': 'Listener Pattern',
      'body': 'A listener subscribes to selection changes and receives '
          'the selected content whenever it changes. This enables '
          'analytics, live previews, word counts, and clipboard tracking.',
    },
    {
      'icon': Icons.broadcast_on_personal,
      'title': 'Notifier Pattern',
      'body': 'A notifier (ChangeNotifier/ValueNotifier) broadcasts '
          'selection state to multiple consumers. This decouples the '
          'selection source from the widgets that react to it.',
    },
    {
      'icon': Icons.sync,
      'title': 'Real-Time Updates',
      'body': 'By combining onSelectionChanged with a ValueNotifier, '
          'you get a reactive pipeline: selection changes flow from '
          'the gesture layer through the notifier to any number of '
          'listening widgets.',
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
          color: Colors.indigo.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.indigo, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo,
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
  // SECTION 2: Architecture Diagram
  // ============================================================
  print('=== Section 2: Architecture ===');

  final archSteps = <Map<String, dynamic>>[
    {'label': 'User Gesture', 'icon': Icons.touch_app, 'color': Colors.blue},
    {'label': 'SelectableRegion', 'icon': Icons.view_in_ar, 'color': Colors.purple},
    {'label': 'onSelectionChanged', 'icon': Icons.notifications, 'color': Colors.orange},
    {'label': 'ValueNotifier', 'icon': Icons.broadcast_on_personal, 'color': Colors.teal},
    {'label': 'Listener Widgets', 'icon': Icons.widgets, 'color': Colors.green},
  ];

  final archWidgets = <Widget>[];
  for (var i = 0; i < archSteps.length; i++) {
    final step = archSteps[i];
    final color = step['color'] as Color;
    archWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(step['icon'] as IconData, color: color, size: 20.0),
            const SizedBox(width: 6.0),
            Text(
              step['label'] as String,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
            ),
          ],
        ),
      ),
    );
    if (i < archSteps.length - 1) {
      archWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Icon(Icons.arrow_downward, size: 20.0, color: Colors.grey.shade400),
        ),
      );
    }
  }

  // ============================================================
  // SECTION 3: onSelectionChanged Callback
  // ============================================================
  print('=== Section 3: Callback Reference ===');

  final callbackParams = <Map<String, String>>[
    {
      'param': 'onSelectionChanged',
      'type': 'ValueChanged<SelectedContent?>?',
      'desc': 'Called when the selection changes. Receives the currently '
          'selected content, or null when selection is cleared.',
    },
  ];

  final callbackInfo = <Map<String, String>>[
    {
      'title': 'When It Fires',
      'body': 'Every time the selection changes: start, update during drag, '
          'and end. Also fires with null when selection is cleared.',
    },
    {
      'title': 'What It Receives',
      'body': 'A SelectedContent object containing the plainText of the '
          'selected content. Currently only plainText is populated; '
          'rich content may be added in future Flutter versions.',
    },
    {
      'title': 'Performance Note',
      'body': 'The callback fires frequently during drag operations. '
          'Keep the callback lightweight or debounce if doing expensive '
          'work like analytics or network calls.',
    },
  ];

  final callbackInfoWidgets = <Widget>[];
  for (final ci in callbackInfo) {
    callbackInfoWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ci['title']!,
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.orange.shade800),
            ),
            const SizedBox(height: 4.0),
            Text(
              ci['body']!,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Live Selection Listener Demo
  // ============================================================
  print('=== Section 4: Live Demo ===');

  final liveDemo = _SelectionListenerDemo();

  // ============================================================
  // SECTION 5: ValueNotifier Pattern
  // ============================================================
  print('=== Section 5: ValueNotifier Pattern ===');

  final patternSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Create a ValueNotifier<String>',
      'code': 'final selectionNotifier = ValueNotifier<String>("");',
      'desc': 'Holds the current selection text. Empty string means no selection.',
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'Wire onSelectionChanged',
      'code': 'SelectionArea(\n'
          '  onSelectionChanged: (content) {\n'
          '    selectionNotifier.value =\n'
          '      content?.plainText ?? "";\n'
          '  },\n'
          '  child: ...\n'
          ')',
      'desc': 'Forward selected text to the notifier on every change.',
      'color': Colors.purple,
    },
    {
      'step': '3',
      'title': 'Listen in Multiple Widgets',
      'code': 'ValueListenableBuilder<String>(\n'
          '  valueListenable: selectionNotifier,\n'
          '  builder: (ctx, text, _) {\n'
          '    return Text("Selected: \$text");\n'
          '  },\n'
          ')',
      'desc': 'Any widget can subscribe to the notifier and rebuild when selection changes.',
      'color': Colors.teal,
    },
    {
      'step': '4',
      'title': 'Dispose Properly',
      'code': 'selectionNotifier.dispose();',
      'desc': 'Clean up the notifier in the State dispose() method to avoid memory leaks.',
      'color': Colors.red,
    },
  ];

  final patternWidgets = <Widget>[];
  for (final ps in patternSteps) {
    final color = ps['color'] as Color;
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            // Header
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
                        ps['step'] as String,
                        style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    ps['title'] as String,
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            // Code
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey.shade50,
              child: Text(
                ps['code'] as String,
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade800),
              ),
            ),
            // Desc
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                ps['desc'] as String,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Analytics Dashboard Demo
  // ============================================================
  print('=== Section 6: Analytics ===');

  final analyticsDemo = _SelectionAnalyticsDemo();

  // ============================================================
  // SECTION 7: Comparison with Other Patterns
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'pattern': 'onSelectionChanged Callback',
      'pros': 'Simple, direct, no extra objects',
      'cons': 'Single consumer, tightly coupled',
      'use': 'Quick reactions like status bar updates',
      'color': Colors.blue,
    },
    {
      'pattern': 'ValueNotifier Broadcast',
      'pros': 'Multi-consumer, decoupled, testable',
      'cons': 'Requires manual lifecycle (create + dispose)',
      'use': 'Multi-widget UIs reacting to selection',
      'color': Colors.purple,
    },
    {
      'pattern': 'StreamController',
      'pros': 'Async-friendly, transformable (debounce, map)',
      'cons': 'More boilerplate, needs subscription management',
      'use': 'Analytics, logging, network operations',
      'color': Colors.teal,
    },
    {
      'pattern': 'InheritedNotifier',
      'pros': 'Automatic rebuild via InheritedWidget, no builders needed',
      'cons': 'Must be in widget tree, more complex setup',
      'use': 'Selection state shared across deep widget trees',
      'color': Colors.orange,
    },
  ];

  final compWidgets = <Widget>[];
  for (final c in comparisons) {
    final color = c['color'] as Color;
    compWidgets.add(
      Container(
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
            Text(
              c['pattern'] as String,
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.add_circle, color: Colors.green, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    c['pros'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.green.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.remove_circle, color: Colors.red, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    c['cons'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'Best for: ${c['use']}',
                    style: TextStyle(fontSize: 11.5, color: Colors.amber.shade800, fontStyle: FontStyle.italic),
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.notifications_active, 'text': 'onSelectionChanged is the primary callback for selection events'},
    {'icon': Icons.broadcast_on_personal, 'text': 'ValueNotifier decouples selection source from consumers'},
    {'icon': Icons.hearing, 'text': 'Multiple widgets can listen to the same notifier independently'},
    {'icon': Icons.speed, 'text': 'Debounce or throttle for expensive operations during drag'},
    {'icon': Icons.analytics, 'text': 'Selection analytics: word count, char count, event history'},
    {'icon': Icons.code, 'text': 'Dispose notifiers/streams in State.dispose() to avoid leaks'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.indigo),
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
  // BUILD FINAL TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Selection Listener & Notifier'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Architecture'),
            Tab(text: 'Callback'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Notifier Pattern'),
            Tab(text: 'Analytics'),
            Tab(text: 'Comparison'),
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
                _buildSLNBullet('Listening to Selection Changes',
                    'The selection listener/notifier pattern connects '
                    'selection events to reactive UI updates using '
                    'ValueNotifier and onSelectionChanged.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Architecture
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('Event Flow Architecture',
                    'Selection events flow from user gestures through '
                    'SelectableRegion to your listener callback, then '
                    'optionally into a notifier for multi-widget broadcast.'),
                const SizedBox(height: 14.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: archWidgets,
                  ),
                ),
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
                          'Each arrow represents a synchronous call on the '
                          'main thread. Keep listeners fast to avoid jank '
                          'during drag operations.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Callback
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('onSelectionChanged Reference',
                    'The callback on SelectionArea that fires whenever '
                    'selection content changes.'),
                const SizedBox(height: 14.0),
                // Callback signature
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signature',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 6.0),
                      ...callbackParams.map((cp) => Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cp['param']!,
                              style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: Colors.indigo),
                            ),
                            Text(
                              cp['type']!,
                              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.teal.shade700),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              cp['desc']!,
                              style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 14.0),
                ...callbackInfoWidgets,
              ],
            ),
          ),
          // Tab 4: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('Live Selection Listener',
                    'Select text below and watch the listener panel '
                    'update in real time with selected text, char count, '
                    'and word count.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 5: Notifier Pattern
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('ValueNotifier Broadcast Pattern',
                    'Step-by-step recipe for using ValueNotifier to '
                    'broadcast selection state to multiple widgets.'),
                const SizedBox(height: 14.0),
                ...patternWidgets,
              ],
            ),
          ),
          // Tab 6: Analytics
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('Selection Analytics Dashboard',
                    'A practical example showing how to track selection '
                    'metrics: event count, character count, word count, '
                    'and maintain an event history log.'),
                const SizedBox(height: 14.0),
                analyticsDemo,
              ],
            ),
          ),
          // Tab 7: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('Pattern Comparison',
                    'Four different approaches to listening for selection '
                    'changes, with pros, cons, and recommended use cases.'),
                const SizedBox(height: 14.0),
                ...compWidgets,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSLNBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withValues(alpha: 0.05),
                        Colors.blue.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
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
Widget _buildSLNBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.indigo, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.indigo)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Selection Listener Demo
// ---------------------------------------------------------------------------
class _SelectionListenerDemo extends StatefulWidget {
  @override
  State<_SelectionListenerDemo> createState() => _SelectionListenerDemoState();
}

class _SelectionListenerDemoState extends State<_SelectionListenerDemo> {
  String _selectedText = '';
  int _eventCount = 0;

  @override
  Widget build(BuildContext context) {
    final charCount = _selectedText.length;
    final wordCount = _selectedText.trim().isEmpty ? 0 : _selectedText.trim().split(RegExp(r'\s+')).length;

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
            'Select text below to trigger the listener',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12.0),
          SelectionArea(
            onSelectionChanged: (dynamic content) {
              setState(() {
                _eventCount++;
                if (content != null) {
                  _selectedText = content.plainText as String;
                } else {
                  _selectedText = '';
                }
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Flutter selection system provides a rich set of APIs '
                    'for handling text selection across multiple widgets. '
                    'SelectableRegion manages the fundamental selection state '
                    'while SelectionArea provides a convenient wrapper.',
                    style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Selection containers group related selectable content '
                    'and can be selectively disabled to prevent selection '
                    'on navigation elements, buttons, and other UI chrome. '
                    'The onSelectionChanged callback fires on every change.',
                    style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          // Listener output panel
          Container(
            width: double.infinity,
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
                    Icon(Icons.hearing, size: 16.0, color: Colors.indigo),
                    const SizedBox(width: 6.0),
                    const Text(
                      'Listener Output',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.indigo),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'Events: $_eventCount',
                        style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                // Metrics row
                Row(
                  children: [
                    _metricChip('Characters', '$charCount', Colors.blue),
                    const SizedBox(width: 8.0),
                    _metricChip('Words', '$wordCount', Colors.purple),
                    const SizedBox(width: 8.0),
                    _metricChip('Events', '$_eventCount', Colors.teal),
                  ],
                ),
                const SizedBox(height: 10.0),
                // Selected text display
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 100.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    _selectedText.isEmpty ? '(no selection)' : _selectedText,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: _selectedText.isEmpty ? Colors.grey.shade400 : Colors.grey.shade800,
                      fontStyle: _selectedText.isEmpty ? FontStyle.italic : FontStyle.normal,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: color)),
            Text(label, style: TextStyle(fontSize: 10.0, color: color.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Selection Analytics Dashboard Demo
// ---------------------------------------------------------------------------
class _SelectionAnalyticsDemo extends StatefulWidget {
  @override
  State<_SelectionAnalyticsDemo> createState() => _SelectionAnalyticsDemoState();
}

class _SelectionAnalyticsDemoState extends State<_SelectionAnalyticsDemo> {
  final ValueNotifier<String> _selectionNotifier = ValueNotifier<String>('');
  final List<Map<String, dynamic>> _eventLog = [];
  int _totalEvents = 0;
  int _maxChars = 0;
  int _maxWords = 0;

  @override
  void dispose() {
    _selectionNotifier.dispose();
    super.dispose();
  }

  void _onSelectionChanged(dynamic content) {
    final text = content != null ? (content.plainText as String) : '';
    _selectionNotifier.value = text;
    setState(() {
      _totalEvents++;
      final chars = text.length;
      final words = text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
      if (chars > _maxChars) _maxChars = chars;
      if (words > _maxWords) _maxWords = words;
      _eventLog.insert(0, {
        'index': _totalEvents,
        'chars': chars,
        'words': words,
        'preview': text.length > 40 ? '${text.substring(0, 40)}...' : text,
        'isEmpty': text.isEmpty,
      });
      if (_eventLog.length > 15) _eventLog.removeLast();
    });
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
            'Selection Analytics',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Select text below. The analytics dashboard tracks every event '
            'with char count, word count, and maintains a scrollable log.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          // Selectable content
          SelectionArea(
            onSelectionChanged: _onSelectionChanged,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter framework provides comprehensive tools for '
                    'building rich, interactive applications. The selection '
                    'system is one example of this depth, offering fine-grained '
                    'control over text selection behavior.',
                    style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Material Design components integrate seamlessly with the '
                    'selection system. Themes, colors, and animations all work '
                    'together to create polished user experiences.',
                    style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Custom selection handlers enable advanced features like '
                    'analytics tracking, clipboard management, accessibility '
                    'announcements, and collaborative editing support.',
                    style: TextStyle(fontSize: 13.0, height: 1.55, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          // Stats row
          Row(
            children: [
              _statCard('Total Events', '$_totalEvents', Colors.blue),
              const SizedBox(width: 8.0),
              _statCard('Max Chars', '$_maxChars', Colors.purple),
              const SizedBox(width: 8.0),
              _statCard('Max Words', '$_maxWords', Colors.teal),
            ],
          ),
          const SizedBox(height: 14.0),
          // Current selection via ValueListenableBuilder
          ValueListenableBuilder<String>(
            valueListenable: _selectionNotifier,
            builder: (context, text, _) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: text.isEmpty
                      ? Colors.grey.shade50
                      : Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: text.isEmpty ? Colors.grey.shade300 : Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      text.isEmpty ? Icons.deselect : Icons.select_all,
                      size: 16.0,
                      color: text.isEmpty ? Colors.grey : Colors.green,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        text.isEmpty ? 'No active selection' : text,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: text.isEmpty ? Colors.grey.shade500 : Colors.grey.shade800,
                          fontStyle: text.isEmpty ? FontStyle.italic : FontStyle.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 14.0),
          // Event log
          Container(
            padding: const EdgeInsets.all(10.0),
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
                    Icon(Icons.list_alt, size: 16.0, color: Colors.grey.shade600),
                    const SizedBox(width: 6.0),
                    Text('Event Log', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.grey.shade700)),
                    const Spacer(),
                    Text(
                      '${_eventLog.length} entries',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                if (_eventLog.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Select text to see events',
                        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                else
                  ..._eventLog.take(8).map((e) => Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: (e['isEmpty'] as bool)
                          ? Colors.red.withValues(alpha: 0.03)
                          : Colors.green.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.0,
                          child: Text(
                            '#${e['index']}',
                            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.grey.shade500, fontFamily: 'monospace'),
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '${e['chars']}c/${e['words']}w',
                            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (e['isEmpty'] as bool)
                                ? '(cleared)'
                                : e['preview'] as String,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: (e['isEmpty'] as bool) ? Colors.red.shade400 : Colors.grey.shade700,
                              fontStyle: (e['isEmpty'] as bool) ? FontStyle.italic : FontStyle.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: color)),
            const SizedBox(height: 2.0),
            Text(label, style: TextStyle(fontSize: 10.0, color: color.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}
