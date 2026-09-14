// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectableRegion – the foundational widget that
// enables text selection across one or more child widgets (Text, RichText,
// etc.). SelectionArea is the convenience wrapper; SelectableRegion is the
// low-level engine underneath.
// Deep Demo: Live selection, custom context menus, multi-paragraph selection,
// gesture mechanics, and SelectableRegion vs SelectionArea comparison.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableRegion Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.select_all,
      'title': 'Core Selection Engine',
      'body': 'SelectableRegion is the low-level widget that manages text '
          'selection across one or more Selectable children. It handles '
          'gesture detection, selection state, magnifier, and context menus.',
    },
    {
      'icon': Icons.auto_awesome,
      'title': 'SelectionArea Wrapper',
      'body': 'SelectionArea is a convenience widget that wraps SelectableRegion '
          'with MaterialSelectionControls and default configuration. For most '
          'apps, SelectionArea is sufficient.',
    },
    {
      'icon': Icons.gesture,
      'title': 'Gesture Handling',
      'body': 'Recognises single-tap (to place cursor), double-tap (word '
          'selection), triple-tap (paragraph selection), and long-press + '
          'drag (free-form selection).',
    },
    {
      'icon': Icons.layers_outlined,
      'title': 'Multi-Widget Selection',
      'body': 'Unlike SelectableText (single widget), SelectableRegion enables '
          'selection that spans across multiple Text, RichText, and other '
          'Selectable descendants in a single contiguous highlight.',
    },
    {
      'icon': Icons.menu_book,
      'title': 'Context Menu Integration',
      'body': 'Provides contextMenuBuilder to customise the right-click / '
          'long-press menu. Default shows Copy and Select All.',
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
          color: Colors.teal.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.teal, size: 26.0),
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
                      color: Colors.teal,
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
  // SECTION 2: SelectableRegion vs SelectionArea
  // ============================================================
  print('=== Section 2: SelectableRegion vs SelectionArea ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'API Level',
      'region': 'Low-level',
      'area': 'High-level wrapper',
    },
    {
      'aspect': 'selectionControls',
      'region': 'Required parameter',
      'area': 'Auto: MaterialSelectionControls',
    },
    {
      'aspect': 'focusNode',
      'region': 'Required parameter',
      'area': 'Auto-managed (optional)',
    },
    {
      'aspect': 'contextMenuBuilder',
      'region': 'Fully customisable',
      'area': 'Customisable (optional)',
    },
    {
      'aspect': 'magnifierConfiguration',
      'region': 'Fully customisable',
      'area': 'Customisable (optional)',
    },
    {
      'aspect': 'onSelectionChanged',
      'region': 'Available',
      'area': 'Available',
    },
    {
      'aspect': 'Use When',
      'region': 'Custom controls, non-Material design',
      'area': 'Standard Material selection',
    },
  ];

  final compTable = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SelectableRegion vs SelectionArea',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10.0),
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: const Row(
            children: [
              Expanded(flex: 2, child: Text('Aspect', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 3, child: Text('SelectableRegion', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 3, child: Text('SelectionArea', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...comparisonRows.map((row) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  row['aspect'] as String,
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  row['region'] as String,
                  style: TextStyle(fontSize: 11.5, color: Colors.teal.shade700),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  row['area'] as String,
                  style: TextStyle(fontSize: 11.5, color: Colors.indigo.shade700),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Constructor Parameters Reference
  // ============================================================
  print('=== Section 3: Constructor Parameters ===');

  final params = <Map<String, String>>[
    {
      'name': 'selectionControls',
      'type': 'TextSelectionControls',
      'req': 'Required',
      'desc': 'Controls the visual style of selection handles and toolbar. '
          'Use materialTextSelectionControls for Material 2 or '
          'materialTextSelectionHandleControls for Material 3.',
    },
    {
      'name': 'focusNode',
      'type': 'FocusNode',
      'req': 'Required',
      'desc': 'Focus node for the region. Must be provided and managed '
          'by the parent. Receives focus when selection starts.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'req': 'Required',
      'desc': 'The widget subtree whose Selectable descendants will '
          'participate in the selection.',
    },
    {
      'name': 'contextMenuBuilder',
      'type': 'WidgetBuilder?',
      'req': 'Optional',
      'desc': 'Builder for the context menu shown on right-click or '
          'long-press. Receives an EditableTextState-like context.',
    },
    {
      'name': 'magnifierConfiguration',
      'type': 'TextMagnifierConfiguration?',
      'req': 'Optional',
      'desc': 'Configuration for the magnifier shown during selection '
          'drag on mobile platforms.',
    },
    {
      'name': 'onSelectionChanged',
      'type': 'ValueChanged<SelectedContent?>?',
      'req': 'Optional',
      'desc': 'Called when the selection changes. The SelectedContent '
          'contains the plain text of the current selection.',
    },
  ];

  final paramCards = <Widget>[];
  for (final p in params) {
    final isReq = p['req'] == 'Required';
    paramCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(
              color: isReq ? Colors.red.shade400 : Colors.blueGrey.shade300,
              width: 3.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  p['name']!,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: isReq
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    p['req']!,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: isReq ? Colors.red.shade700 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3.0),
            Text(
              '→ ${p['type']}',
              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.teal.shade700),
            ),
            const SizedBox(height: 4.0),
            Text(
              p['desc']!,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Live SelectionArea Demo
  // ============================================================
  print('=== Section 4: Live SelectionArea ===');

  final liveSelectionDemo = _LiveSelectionDemo();

  // ============================================================
  // SECTION 5: Multi-Paragraph Selection
  // ============================================================
  print('=== Section 5: Multi-Paragraph Selection ===');

  final multiParaDemo = _MultiParagraphDemo();

  // ============================================================
  // SECTION 6: Gesture Mechanics
  // ============================================================
  print('=== Section 6: Gesture Mechanics ===');

  final gestures = <Map<String, dynamic>>[
    {
      'gesture': 'Single Tap',
      'icon': Icons.touch_app,
      'color': Colors.blue,
      'effect': 'Places cursor at tap position, clears existing selection',
      'platform': 'All platforms',
    },
    {
      'gesture': 'Double Tap',
      'icon': Icons.ads_click,
      'color': Colors.purple,
      'effect': 'Selects the word at the tap position',
      'platform': 'All platforms',
    },
    {
      'gesture': 'Triple Tap',
      'icon': Icons.mouse,
      'color': Colors.deepOrange,
      'effect': 'Selects the entire paragraph at the tap position',
      'platform': 'Desktop + web',
    },
    {
      'gesture': 'Long Press',
      'icon': Icons.pan_tool,
      'color': Colors.teal,
      'effect': 'Selects the word and shows magnifier on mobile',
      'platform': 'Mobile (iOS/Android)',
    },
    {
      'gesture': 'Long Press + Drag',
      'icon': Icons.swipe,
      'color': Colors.indigo,
      'effect': 'Extends selection while showing magnifier',
      'platform': 'Mobile (iOS/Android)',
    },
    {
      'gesture': 'Click + Drag',
      'icon': Icons.open_with,
      'color': Colors.brown,
      'effect': 'Free-form selection from drag start to current position',
      'platform': 'Desktop + web',
    },
    {
      'gesture': 'Shift + Click',
      'icon': Icons.keyboard,
      'color': Colors.cyan,
      'effect': 'Extends selection from current anchor to click position',
      'platform': 'Desktop + web',
    },
  ];

  final gestureCards = <Widget>[];
  for (final g in gestures) {
    final color = g['color'] as Color;
    gestureCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
              ),
              child: Center(child: Icon(g['icon'] as IconData, color: color, size: 18.0)),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        g['gesture'] as String,
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          g['platform'] as String,
                          style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    g['effect'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.3),
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
  // SECTION 7: Selection with Styled Text
  // ============================================================
  print('=== Section 7: Styled Text Selection ===');

  final styledTextDemo = _StyledTextSelectionDemo();

  // ============================================================
  // SECTION 8: Selection Lifecycle
  // ============================================================
  print('=== Section 8: Selection Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Region Created',
      'desc': 'SelectableRegion builds and registers its SelectionContainer '
          'scope with Selectable children.',
      'icon': Icons.add_circle_outline,
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'Gesture Detected',
      'desc': 'RawGestureDetector inside the region recognises a selection '
          'gesture (tap, double-tap, drag, etc.).',
      'icon': Icons.touch_app,
      'color': Colors.orange,
    },
    {
      'step': '3',
      'title': 'Selection Updated',
      'desc': 'The SelectionHandler communicates with each Selectable child '
          'to determine what content is in the gesture\'s range.',
      'icon': Icons.sync,
      'color': Colors.purple,
    },
    {
      'step': '4',
      'title': 'Status Scope Updated',
      'desc': 'SelectableRegionSelectionStatusScope is updated to reflect '
          'the new status (none / selecting / selected).',
      'icon': Icons.layers,
      'color': Colors.indigo,
    },
    {
      'step': '5',
      'title': 'Callback Fired',
      'desc': 'onSelectionChanged is called with the selected plainText '
          'content, or null if the selection was cleared.',
      'icon': Icons.notifications_active,
      'color': Colors.teal,
    },
    {
      'step': '6',
      'title': 'UI Updates',
      'desc': 'Selection handles appear, context menu can be shown, '
          'and dependent widgets rebuild.',
      'icon': Icons.visibility,
      'color': Colors.green,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (final ls in lifecycleSteps) {
    final color = ls['color'] as Color;
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                child: Text(
                  ls['step'] as String,
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(ls['icon'] as IconData, color: color, size: 18.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ls['title'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
                  ),
                  Text(
                    ls['desc'] as String,
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Arrow between steps (except last)
    if (ls != lifecycleSteps.last) {
      lifecycleWidgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Column(
            children: [
              Container(width: 2.0, height: 4.0, color: Colors.grey.shade300),
              Icon(Icons.arrow_drop_down, size: 14.0, color: Colors.grey.shade400),
            ],
          ),
        ),
      );
    }
  }

  // ============================================================
  // SECTION 9: Clipboard Integration
  // ============================================================
  print('=== Section 9: Clipboard Integration ===');

  final clipboardInfo = Container(
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
          'Clipboard & Context Menu',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10.0),
        _buildClipboardRow(
          Icons.content_copy,
          'Copy',
          'Copies selected text to system clipboard',
          Colors.blue,
          'Ctrl+C / Cmd+C',
        ),
        _buildClipboardRow(
          Icons.select_all,
          'Select All',
          'Selects all selectable content in the region',
          Colors.purple,
          'Ctrl+A / Cmd+A',
        ),
        _buildClipboardRow(
          Icons.share,
          'Share (Mobile)',
          'Shares selected text via platform share sheet',
          Colors.teal,
          'Context menu',
        ),
        _buildClipboardRow(
          Icons.search,
          'Web Search',
          'Searches for selected text in browser',
          Colors.orange,
          'Context menu (iOS)',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
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
                  'Custom context menus can be built via contextMenuBuilder. '
                  'This receives the build context and positions the menu '
                  'near the selection. Return any Widget – a simple Column, '
                  'a Material DropdownMenu, or a custom floating panel.',
                  style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.select_all, 'text': 'Core widget for multi-widget text selection'},
    {'icon': Icons.auto_awesome, 'text': 'SelectionArea is the high-level convenience wrapper'},
    {'icon': Icons.gesture, 'text': 'Handles tap, double-tap, triple-tap, long-press, drag'},
    {'icon': Icons.layers, 'text': 'Creates SelectionContainer & StatusScope for descendants'},
    {'icon': Icons.menu_book, 'text': 'Customisable context menus via contextMenuBuilder'},
    {'icon': Icons.content_copy, 'text': 'Built-in clipboard integration (Copy, Select All)'},
    {'icon': Icons.zoom_in, 'text': 'Magnifier support on mobile via magnifierConfiguration'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.teal),
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
        title: const Text('SelectableRegion'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Comparison'),
            Tab(text: 'Parameters'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Multi-Para'),
            Tab(text: 'Gestures'),
            Tab(text: 'Styled Text'),
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
                _buildSRBullet('What is SelectableRegion?',
                    'The foundational widget that enables text selection across '
                    'one or more child widgets. It creates a SelectionContainer '
                    'scope and handles all gesture recognition, selection state, '
                    'and platform integration.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('SelectableRegion vs SelectionArea',
                    'SelectionArea is a convenience wrapper around SelectableRegion '
                    'that provides Material defaults. Use SelectableRegion directly '
                    'when you need full control.'),
                const SizedBox(height: 14.0),
                compTable,
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, color: Colors.green, size: 18.0),
                          const SizedBox(width: 8.0),
                          const Text(
                            'When to Use Which?',
                            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        '• SelectionArea: Most apps, standard Material design\n'
                        '• SelectableRegion: Custom handle styles, Cupertino design, '
                        'or platform-specific context menus',
                        style: TextStyle(fontSize: 12.0, color: Colors.green.shade800, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Parameters
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Constructor Parameters',
                    'All parameters of SelectableRegion and their roles.'),
                const SizedBox(height: 14.0),
                ...paramCards,
              ],
            ),
          ),
          // Tab 4: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Live Selection Demo',
                    'Select text in the region below. The status and selected '
                    'content are displayed in real time.'),
                const SizedBox(height: 14.0),
                liveSelectionDemo,
              ],
            ),
          ),
          // Tab 5: Multi-Paragraph
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Multi-Paragraph Selection',
                    'SelectableRegion enables selection across multiple Text '
                    'widgets in a single contiguous highlight – a key feature '
                    'not available with individual SelectableText widgets.'),
                const SizedBox(height: 14.0),
                multiParaDemo,
              ],
            ),
          ),
          // Tab 6: Gestures
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Gesture Mechanics',
                    'All the gestures that SelectableRegion recognises '
                    'and their effects on the selection.'),
                const SizedBox(height: 14.0),
                ...gestureCards,
              ],
            ),
          ),
          // Tab 7: Styled Text
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Selection with Styled Text',
                    'SelectableRegion works with RichText / Text.rich that '
                    'contain TextSpan trees with mixed styles.'),
                const SizedBox(height: 14.0),
                styledTextDemo,
                const SizedBox(height: 16.0),
                // Lifecycle + clipboard
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selection Lifecycle',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10.0),
                      ...lifecycleWidgets,
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                clipboardInfo,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withValues(alpha: 0.05),
                        Colors.green.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
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
Widget _buildSRBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.teal.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.teal, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.teal)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: clipboard row
// ---------------------------------------------------------------------------
Widget _buildClipboardRow(IconData icon, String action, String desc, Color color, String shortcut) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: color, width: 2.0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(action, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(shortcut, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
                  ),
                ],
              ),
              Text(desc, style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Selection Demo
// ---------------------------------------------------------------------------
class _LiveSelectionDemo extends StatefulWidget {
  @override
  State<_LiveSelectionDemo> createState() => _LiveSelectionDemoState();
}

class _LiveSelectionDemoState extends State<_LiveSelectionDemo> {
  String _selectedText = '';
  int _charCount = 0;
  int _wordCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(color: Colors.teal.withValues(alpha: 0.08), blurRadius: 8.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.touch_app, color: Colors.teal, size: 22.0),
              const SizedBox(width: 8.0),
              const Text(
                'Select Any Text Below',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.teal),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          SelectionArea(
            onSelectionChanged: (dynamic value) {
              setState(() {
                if (value != null) {
                  final txt = value.plainText as String;
                  _selectedText = txt.length > 60 ? '${txt.substring(0, 60)}...' : txt;
                  _charCount = txt.length;
                  _wordCount = txt.trim().isEmpty ? 0 : txt.trim().split(RegExp(r'\s+')).length;
                } else {
                  _selectedText = '';
                  _charCount = 0;
                  _wordCount = 0;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.12)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter text selection system is built on a layered '
                    'architecture. At the bottom sits SelectableRegion, which '
                    'provides the gesture recognition and selection state '
                    'management.',
                    style: TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'The SelectionArea convenience widget wraps it with '
                    'Material-themed handles and context menus. Most apps '
                    'only need to wrap their content in a SelectionArea to '
                    'enable full text selection.',
                    style: TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'For advanced use cases – custom handle widgets, '
                    'platform-specific context menus, or integration with '
                    'custom accessibility features – use SelectableRegion '
                    'directly.',
                    style: TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          // Stats row
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
                    _buildStatChip('Chars', '$_charCount', Colors.blue),
                    const SizedBox(width: 8.0),
                    _buildStatChip('Words', '$_wordCount', Colors.purple),
                    const SizedBox(width: 8.0),
                    _buildStatChip(
                      'Status',
                      _charCount > 0 ? 'selected' : 'none',
                      _charCount > 0 ? Colors.green : Colors.blueGrey,
                    ),
                  ],
                ),
                if (_selectedText.isNotEmpty) ...[
                  const SizedBox(height: 8.0),
                  Text(
                    'Selected: "$_selectedText"',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 10.0, color: color)),
          const SizedBox(width: 4.0),
          Text(value, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Multi-Paragraph Selection Demo
// ---------------------------------------------------------------------------
class _MultiParagraphDemo extends StatefulWidget {
  @override
  State<_MultiParagraphDemo> createState() => _MultiParagraphDemoState();
}

class _MultiParagraphDemoState extends State<_MultiParagraphDemo> {
  int _selectedLength = 0;
  bool _spansMultiple = false;

  @override
  Widget build(BuildContext context) {
    final paragraphs = <Map<String, dynamic>>[
      {
        'title': 'Paragraph 1: The Widget Tree',
        'icon': Icons.account_tree,
        'color': Colors.blue,
        'text': 'Flutter builds user interfaces as a tree of Widget objects. '
            'Each widget describes what its view should look like given its '
            'current configuration and state. Widgets are lightweight and '
            'immutable descriptions of a part of the UI.',
      },
      {
        'title': 'Paragraph 2: The Element Tree',
        'icon': Icons.device_hub,
        'color': Colors.purple,
        'text': 'When a Widget is inflated, Flutter creates a corresponding '
            'Element. Elements are mutable and manage the lifecycle of their '
            'widget – holding references to the widget, parent element, '
            'and child elements.',
      },
      {
        'title': 'Paragraph 3: The RenderObject Tree',
        'icon': Icons.layers,
        'color': Colors.teal,
        'text': 'For visual widgets, the Element also creates a RenderObject '
            'which handles layout and painting. RenderObjects are what '
            'actually compute positions, sizes, and draw to the screen. '
            'This three-tree architecture is the foundation of Flutter.',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.select_all, color: Colors.indigo, size: 20.0),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  'Try selecting across multiple paragraphs',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.indigo),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            'With SelectableRegion / SelectionArea, you can drag from one '
            'paragraph into the next and the selection spans seamlessly.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 12.0),
          SelectionArea(
            onSelectionChanged: (dynamic value) {
              setState(() {
                if (value != null) {
                  final txt = value.plainText as String;
                  _selectedLength = txt.length;
                  _spansMultiple = txt.contains('\n') || _selectedLength > 200;
                } else {
                  _selectedLength = 0;
                  _spansMultiple = false;
                }
              });
            },
            child: Column(
              children: [
                for (final para in paragraphs)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: (para['color'] as Color).withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border(
                        left: BorderSide(color: para['color'] as Color, width: 3.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(para['icon'] as IconData, color: para['color'] as Color, size: 16.0),
                            const SizedBox(width: 6.0),
                            Text(
                              para['title'] as String,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: para['color'] as Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          para['text'] as String,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade800,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Status bar
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _spansMultiple
                  ? Colors.green.withValues(alpha: 0.06)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: _spansMultiple ? Colors.green.shade300 : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _spansMultiple ? Icons.check_circle : Icons.info_outline,
                  size: 16.0,
                  color: _spansMultiple ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 6.0),
                Text(
                  _selectedLength == 0
                      ? 'No selection – try dragging across paragraphs'
                      : '$_selectedLength chars selected${_spansMultiple ? ' (multi-paragraph!)' : ''}',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: _spansMultiple ? Colors.green.shade700 : Colors.grey.shade600,
                    fontWeight: _spansMultiple ? FontWeight.w600 : FontWeight.normal,
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
// Styled Text Selection Demo
// ---------------------------------------------------------------------------
class _StyledTextSelectionDemo extends StatefulWidget {
  @override
  State<_StyledTextSelectionDemo> createState() => _StyledTextSelectionDemoState();
}

class _StyledTextSelectionDemoState extends State<_StyledTextSelectionDemo> {
  String _styledSelection = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_color_text, color: Colors.deepPurple, size: 20.0),
              const SizedBox(width: 8.0),
              const Text(
                'Mixed-Style Selectable Text',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.deepPurple),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            'Selection works correctly across styled TextSpans – bold, italic, '
            'coloured, and linked text can all be selected together.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 12.0),
          SelectionArea(
            onSelectionChanged: (dynamic value) {
              setState(() {
                if (value != null) {
                  final txt = value.plainText as String;
                  _styledSelection = txt.length > 80 ? '${txt.substring(0, 80)}...' : txt;
                } else {
                  _styledSelection = '';
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'The '),
                        TextSpan(
                          text: 'SelectableRegion',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        const TextSpan(text: ' widget supports selection across '),
                        const TextSpan(
                          text: 'rich text spans',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.deepPurple),
                        ),
                        const TextSpan(text: ' with mixed styles. You can have '),
                        TextSpan(
                          text: 'bold text',
                          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.blue.shade800),
                        ),
                        const TextSpan(text: ', '),
                        TextSpan(
                          text: 'coloured text',
                          style: TextStyle(color: Colors.orange.shade800),
                        ),
                        const TextSpan(text: ', and even '),
                        TextSpan(
                          text: 'underlined text',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const TextSpan(text: ' all seamlessly selected together.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'The selected '),
                        TextSpan(
                          text: 'plain text',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            backgroundColor: Colors.yellow.withValues(alpha: 0.3),
                          ),
                        ),
                        const TextSpan(
                          text: ' returned by onSelectionChanged strips formatting – '
                              'you receive the raw characters regardless of styling. '
                              'This makes clipboard integration consistent.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_styledSelection.isNotEmpty) ...[
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'Plain text: "$_styledSelection"',
                style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
