// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionOverlay – the low-level object that
// manages selection handles, toolbar, and magnifier as Overlay entries.
// Used internally by TextField, SelectableText, and other text-editing
// widgets. Deep Demo: Concept, architecture, handle types, LayerLinks,
// live editing demo, methods lifecycle, code patterns, summary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionOverlay Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept – What is SelectionOverlay?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.layers,
      'title': 'Overlay Management Object',
      'body': 'SelectionOverlay is NOT a widget – it is an object that '
          'inserts and manages OverlayEntries for selection handles, a '
          'toolbar (context menu), and a magnifier glass. It belongs to '
          'the low-level text selection infrastructure.',
    },
    {
      'icon': Icons.edit,
      'title': 'Used by Text Editing Widgets',
      'body': 'TextField, EditableText, and SelectableText create a '
          'SelectionOverlay internally via TextSelectionOverlay. You '
          'rarely create one directly unless building a custom editor.',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Handles and Toolbar',
      'body': 'Manages a start handle, end handle, and a floating toolbar. '
          'Handles can be dragged to change selection. The toolbar shows '
          'actions like Cut, Copy, Paste, Select All.',
    },
    {
      'icon': Icons.search,
      'title': 'Magnifier Support',
      'body': 'On mobile platforms, shows a magnifier glass that follows '
          'the finger during selection. Configuration is provided via '
          'TextMagnifierConfiguration.',
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
            Icon(p['icon'] as IconData, color: Colors.indigo.shade700, size: 26.0),
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
                      color: Colors.indigo.shade700,
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
  // SECTION 2: Architecture – Where It Fits
  // ============================================================
  print('=== Section 2: Architecture ===');

  final archLayers = <Map<String, dynamic>>[
    {
      'layer': 'User-Facing Widget',
      'items': 'TextField, SelectableText, EditableText',
      'color': Colors.green,
      'desc': 'High-level widgets you use in your app',
    },
    {
      'layer': 'TextSelectionOverlay',
      'items': 'Wrapper around SelectionOverlay',
      'color': Colors.blue,
      'desc': 'Connects TextEditingValue to overlay management',
    },
    {
      'layer': 'SelectionOverlay',
      'items': 'Manages OverlayEntries',
      'color': Colors.indigo,
      'desc': 'Creates/destroys handles, toolbar, magnifier entries',
    },
    {
      'layer': 'Overlay / CompositedTransformFollower',
      'items': 'Flutter rendering layer',
      'color': Colors.purple,
      'desc': 'Positions overlay elements relative to text via LayerLinks',
    },
  ];

  final archWidgets = <Widget>[];
  for (var i = 0; i < archLayers.length; i++) {
    final layer = archLayers[i];
    final color = layer['color'] as Color;
    archWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 2.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          layer['layer'] as String,
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          layer['items'] as String,
                          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i < archLayers.length - 1)
              SizedBox(
                height: 18.0,
                child: Center(
                  child: Icon(Icons.arrow_downward, size: 14.0, color: Colors.grey.shade400),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Handle Types (TextSelectionHandleType)
  // ============================================================
  print('=== Section 3: Handle Types ===');

  final handleTypes = <Map<String, dynamic>>[
    {
      'type': 'TextSelectionHandleType.left',
      'icon': Icons.format_textdirection_l_to_r,
      'color': Colors.blue,
      'desc': 'Start handle (left side of LTR selection). The teardrop '
          'points right, anchored at the left edge of the selection.',
      'usage': 'Used as startHandleType when selection starts on the left.',
    },
    {
      'type': 'TextSelectionHandleType.right',
      'icon': Icons.format_textdirection_r_to_l,
      'color': Colors.green,
      'desc': 'End handle (right side of LTR selection). The teardrop '
          'points left, anchored at the right edge of the selection.',
      'usage': 'Used as endHandleType when selection ends on the right.',
    },
    {
      'type': 'TextSelectionHandleType.collapsed',
      'icon': Icons.text_fields,
      'color': Colors.orange,
      'desc': 'Single cursor handle. Shown when the selection is collapsed '
          '(cursor position with no highlighted text). Rendered as a '
          'single teardrop below the cursor.',
      'usage': 'Used for both start and end when selection is collapsed.',
    },
  ];

  final handleCards = <Widget>[];
  for (final ht in handleTypes) {
    final color = ht['color'] as Color;
    handleCards.add(
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
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
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
                    child: Icon(ht['icon'] as IconData, color: color, size: 20.0),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      ht['type'] as String,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ht['desc'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      ht['usage'] as String,
                      style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Colors.grey.shade600),
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

  // ============================================================
  // SECTION 4: Required Parameters
  // ============================================================
  print('=== Section 4: Parameters ===');

  final requiredParams = <Map<String, dynamic>>[
    {
      'name': 'context',
      'type': 'BuildContext',
      'group': 'Core',
      'desc': 'Must have an Overlay ancestor. Used to insert entries.',
    },
    {
      'name': 'startHandleType',
      'type': 'TextSelectionHandleType',
      'group': 'Start Handle',
      'desc': 'Type of the start selection handle (left/right/collapsed).',
    },
    {
      'name': 'lineHeightAtStart',
      'type': 'double',
      'group': 'Start Handle',
      'desc': 'Line height at the start position. Sizes the handle.',
    },
    {
      'name': 'endHandleType',
      'type': 'TextSelectionHandleType',
      'group': 'End Handle',
      'desc': 'Type of the end selection handle.',
    },
    {
      'name': 'lineHeightAtEnd',
      'type': 'double',
      'group': 'End Handle',
      'desc': 'Line height at the end position.',
    },
    {
      'name': 'selectionEndpoints',
      'type': 'List<TextSelectionPoint>',
      'group': 'Positioning',
      'desc': 'Positions of the selection endpoints. Used to place handles.',
    },
    {
      'name': 'startHandleLayerLink',
      'type': 'LayerLink',
      'group': 'Positioning',
      'desc': 'CompositedTransformTarget link for start handle placement.',
    },
    {
      'name': 'endHandleLayerLink',
      'type': 'LayerLink',
      'group': 'Positioning',
      'desc': 'CompositedTransformTarget link for end handle placement.',
    },
    {
      'name': 'toolbarLayerLink',
      'type': 'LayerLink',
      'group': 'Positioning',
      'desc': 'CompositedTransformTarget link for toolbar placement.',
    },
    {
      'name': 'selectionControls',
      'type': 'TextSelectionControls?',
      'group': 'Rendering',
      'desc': 'Builds the actual handle and toolbar widgets (Material/Cupertino).',
    },
    {
      'name': 'clipboardStatus',
      'type': 'ClipboardStatusNotifier?',
      'group': 'Toolbar',
      'desc': 'Reports clipboard data availability for paste button state.',
    },
  ];

  final paramGroups = <String, List<Map<String, dynamic>>>{};
  for (final p in requiredParams) {
    final g = p['group'] as String;
    paramGroups.putIfAbsent(g, () => []);
    paramGroups[g]!.add(p);
  }

  final groupColors = <String, Color>{
    'Core': Colors.blue,
    'Start Handle': Colors.green,
    'End Handle': Colors.teal,
    'Positioning': Colors.purple,
    'Rendering': Colors.orange,
    'Toolbar': Colors.red,
  };

  final paramSections = <Widget>[];
  for (final entry in paramGroups.entries) {
    final color = groupColors[entry.key] ?? Colors.grey;
    paramSections.add(
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(
                entry.key,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
              ),
            ),
            ...entry.value.map((p) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        p['name'] as String,
                        style: TextStyle(fontSize: 11.5, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: color),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        p['type'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Editing Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final editingDemo = _SOEditingDemo();

  // ============================================================
  // SECTION 6: Methods Lifecycle
  // ============================================================
  print('=== Section 6: Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'method': 'showHandles()',
      'color': Colors.green,
      'desc': 'Inserts start and end handle OverlayEntries into the Overlay. '
          'Handles become visible and draggable. Only works if '
          'selectionControls is non-null.',
    },
    {
      'method': 'hideHandles()',
      'color': Colors.red,
      'desc': 'Removes handle entries from the Overlay. Handles disappear '
          'and cannot be interacted with until showHandles() is called again.',
    },
    {
      'method': 'showToolbar()',
      'color': Colors.blue,
      'desc': 'Shows the selection toolbar (context menu) at the appropriate '
          'position. Can accept contextMenuBuilder for custom menu UI.',
    },
    {
      'method': 'hideToolbar()',
      'color': Colors.orange,
      'desc': 'Hides the toolbar. Call when the user taps away, scrolls, '
          'or the selection is cleared.',
    },
    {
      'method': 'showMagnifier(info)',
      'color': Colors.purple,
      'desc': 'Shows the magnifier lens at the given MagnifierInfo position. '
          'Used during drag gestures on mobile to show zoomed text.',
    },
    {
      'method': 'updateMagnifier(info)',
      'color': Colors.teal,
      'desc': 'Updates the magnifier position as the user drags. Called '
          'on each frame during a handle drag gesture.',
    },
    {
      'method': 'hideMagnifier()',
      'color': Colors.brown,
      'desc': 'Removes the magnifier overlay entry. Called when the drag '
          'gesture ends or is cancelled.',
    },
    {
      'method': 'markNeedsBuild()',
      'color': Colors.indigo,
      'desc': 'Marks handle and toolbar entries as needing rebuild. Call '
          'after updating properties (endPoints, handleType, etc.).',
    },
    {
      'method': 'hide()',
      'color': Colors.grey,
      'desc': 'Convenience method: hides handles, toolbar, and magnifier '
          'all at once.',
    },
    {
      'method': 'dispose()',
      'color': Colors.red.shade900,
      'desc': 'Releases all overlay entries and resources. Must be called '
          'when the SelectionOverlay is no longer needed.',
    },
  ];

  final methodCards = <Widget>[];
  for (final m in methods) {
    final color = m['color'] as Color;
    methodCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m['method'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    m['desc'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
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
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Setup',
      'color': Colors.blue,
      'desc': 'Creating a SelectionOverlay requires LayerLinks for positioning '
          'handles relative to the text, selectionControls for the visual '
          'appearance, and the BuildContext for overlay insertion.',
      'code': 'final startLink = LayerLink();\n'
          'final endLink = LayerLink();\n'
          'final toolbarLink = LayerLink();\n'
          '\n'
          'final overlay = SelectionOverlay(\n'
          '  context: context,\n'
          '  startHandleType:\n'
          '    TextSelectionHandleType.left,\n'
          '  endHandleType:\n'
          '    TextSelectionHandleType.right,\n'
          '  lineHeightAtStart: 16.0,\n'
          '  lineHeightAtEnd: 16.0,\n'
          '  selectionEndpoints: endpoints,\n'
          '  selectionControls:\n'
          '    materialTextSelectionControls,\n'
          '  selectionDelegate: null,\n'
          '  clipboardStatus: null,\n'
          '  startHandleLayerLink: startLink,\n'
          '  endHandleLayerLink: endLink,\n'
          '  toolbarLayerLink: toolbarLink,\n'
          ');',
    },
    {
      'title': 'Handle Drag Callbacks',
      'color': Colors.green,
      'desc': 'Attach callbacks to handle drag events to update the text '
          'selection as the user drags handles.',
      'code': 'SelectionOverlay(\n'
          '  // ...other params...\n'
          '  onStartHandleDragStart: (details) {\n'
          '    // Begin tracking drag\n'
          '  },\n'
          '  onStartHandleDragUpdate: (details) {\n'
          '    // Update selection start\n'
          '    overlay.selectionEndpoints =\n'
          '      newEndpoints;\n'
          '    overlay.markNeedsBuild();\n'
          '  },\n'
          '  onStartHandleDragEnd: (details) {\n'
          '    // Finalize selection\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Visibility Control',
      'color': Colors.purple,
      'desc': 'Use ValueNotifier<bool> to control handle and toolbar '
          'visibility without destroying the overlay entries.',
      'code': 'final handleVisible =\n'
          '  ValueNotifier<bool>(true);\n'
          'final toolbarVisible =\n'
          '  ValueNotifier<bool>(false);\n'
          '\n'
          'SelectionOverlay(\n'
          '  // ...other params...\n'
          '  startHandlesVisible: handleVisible,\n'
          '  endHandlesVisible: handleVisible,\n'
          '  toolbarVisible: toolbarVisible,\n'
          ')',
    },
    {
      'title': 'Lifecycle Management',
      'color': Colors.orange,
      'desc': 'Always dispose the overlay when done to prevent overlay '
          'entry leaks. Show/hide as needed during the editing lifecycle.',
      'code': '// Show selection UI\n'
          'overlay.showHandles();\n'
          'overlay.showToolbar();\n'
          '\n'
          '// When user taps away\n'
          'overlay.hideToolbar();\n'
          '\n'
          '// When selection is cleared\n'
          'overlay.hide();\n'
          '\n'
          '// When widget is disposed\n'
          'overlay.dispose();',
    },
  ];

  final patternCards = <Widget>[];
  for (final p in patterns) {
    final color = p['color'] as Color;
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
              child: Text(
                p['title'] as String,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                p['desc'] as String,
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
                p['code'] as String,
                style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade700),
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
    {'icon': Icons.layers, 'text': 'SelectionOverlay is an object, not a widget – manages OverlayEntries'},
    {'icon': Icons.edit, 'text': 'Used internally by TextField and SelectableText for selection UI'},
    {'icon': Icons.touch_app, 'text': 'Manages start handle, end handle, toolbar, and magnifier'},
    {'icon': Icons.link, 'text': 'Uses LayerLinks to position handles relative to text via CompositedTransform'},
    {'icon': Icons.visibility, 'text': 'show/hide methods control overlay entry lifecycle'},
    {'icon': Icons.delete_outline, 'text': 'Always dispose() to clean up overlay entries and prevent leaks'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.indigo.shade700),
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
        title: const Text('SelectionOverlay'),
        backgroundColor: Colors.indigo.shade700,
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
            Tab(text: 'Handle Types'),
            Tab(text: 'Parameters'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Methods'),
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
                _buildSOBullet('What is SelectionOverlay?',
                    'A low-level object that manages OverlayEntries for '
                    'text selection handles, toolbar, and magnifier. It is '
                    'the engine behind the selection UI in text editors.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
                const SizedBox(height: 10.0),
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
                          'You rarely need to create a SelectionOverlay directly. '
                          'It is created by TextSelectionOverlay, which is used '
                          'by EditableTextState. Understanding it helps debug '
                          'selection issues and build custom text editors.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 2: Architecture
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('Text Selection Stack',
                    'The layers from high-level widget to low-level overlay.'),
                const SizedBox(height: 14.0),
                ...archWidgets,
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LayerLink Positioning System',
                          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                              color: Colors.indigo.shade700)),
                      const SizedBox(height: 8.0),
                      Text(
                        'Each handle and the toolbar are positioned using a '
                        'CompositedTransformTarget/Follower pair connected by a '
                        'LayerLink. The target is placed at the text position, '
                        'and the overlay follower tracks it even during scrolling.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          '// Text widget side:\n'
                          'CompositedTransformTarget(\n'
                          '  link: startHandleLayerLink,\n'
                          '  child: textWidget,\n'
                          ')\n\n'
                          '// Overlay side (internal):\n'
                          'CompositedTransformFollower(\n'
                          '  link: startHandleLayerLink,\n'
                          '  child: handleWidget,\n'
                          ')',
                          style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Handle Types
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('TextSelectionHandleType',
                    'Three handle types control the visual appearance '
                    'and anchor position of selection handles.'),
                const SizedBox(height: 14.0),
                ...handleCards,
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Handle Type Transitions',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                              color: Colors.indigo.shade700)),
                      const SizedBox(height: 6.0),
                      Text(
                        'Handle types change dynamically as the user drags:\n'
                        '- Tap to place cursor -> both collapsed\n'
                        '- Double-tap to select word -> left + right\n'
                        '- Drag start past end -> types swap (left/right)\n'
                        '- Selection collapses -> back to collapsed',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: Parameters
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('Constructor Parameters',
                    'Required parameters grouped by function.'),
                const SizedBox(height: 14.0),
                ...paramSections,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('Interactive Selection Demo',
                    'Tap and drag to select text. The SelectionOverlay '
                    'manages the handles and toolbar that appear.'),
                const SizedBox(height: 14.0),
                editingDemo,
              ],
            ),
          ),
          // Tab 6: Methods
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('Overlay Lifecycle Methods',
                    'Methods to show, hide, update, and dispose '
                    'the overlay entries.'),
                const SizedBox(height: 14.0),
                ...methodCards,
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSOBullet('Usage Patterns',
                    'Code examples for common SelectionOverlay operations.'),
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
                _buildSOBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withValues(alpha: 0.05),
                        Colors.purple.withValues(alpha: 0.05),
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
Widget _buildSOBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.indigo.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.indigo.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Editing Demo – TextField showing SelectionOverlay in action
// ---------------------------------------------------------------------------
class _SOEditingDemo extends StatefulWidget {
  @override
  State<_SOEditingDemo> createState() => _SOEditingDemoState();
}

class _SOEditingDemoState extends State<_SOEditingDemo> {
  final TextEditingController _ctrl = TextEditingController(
    text: 'SelectionOverlay manages the handles you see when selecting '
        'this text. Try double-tapping to select a word, then drag the '
        'handles to extend the selection. The toolbar with Cut, Copy, '
        'and Paste appears above the selection. All of this is managed '
        'by a SelectionOverlay instance created internally by the '
        'TextField widget.',
  );
  final FocusNode _focus = FocusNode();
  String _lastAction = 'None';
  int _selectionStart = 0;
  int _selectionEnd = 0;
  bool _hasSelection = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onSelectionChange);
  }

  void _onSelectionChange() {
    setState(() {
      final sel = _ctrl.selection;
      _selectionStart = sel.start;
      _selectionEnd = sel.end;
      _hasSelection = sel.start != sel.end;
      if (_hasSelection) {
        _lastAction = 'Selected ${sel.end - sel.start} chars';
      } else if (sel.isValid) {
        _lastAction = 'Cursor at offset ${sel.start}';
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
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
            'Select text to see SelectionOverlay in action',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Double-tap to select a word, long-press for cursor, '
            'drag handles to extend selection.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: _ctrl,
            focusNode: _focus,
            maxLines: 5,
            style: const TextStyle(fontSize: 14.0, height: 1.6),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              contentPadding: const EdgeInsets.all(12.0),
              filled: true,
              fillColor: Colors.indigo.withValues(alpha: 0.02),
            ),
          ),
          const SizedBox(height: 14.0),
          // Selection state panel
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
                    Icon(Icons.info, size: 16.0, color: Colors.indigo.shade700),
                    const SizedBox(width: 6.0),
                    Text('Selection State (read from TextEditingController)',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: Colors.indigo.shade700)),
                  ],
                ),
                const SizedBox(height: 10.0),
                _stateRow('Has Selection', _hasSelection ? 'Yes' : 'No',
                    _hasSelection ? Colors.green : Colors.grey),
                _stateRow('Selection Start', '$_selectionStart', Colors.blue),
                _stateRow('Selection End', '$_selectionEnd', Colors.blue),
                _stateRow('Last Action', _lastAction, Colors.purple),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Text(
                    'The handles and toolbar you see are managed by a '
                    'SelectionOverlay instance created internally. It uses '
                    'three LayerLinks to position the start handle, end '
                    'handle, and toolbar relative to the text.',
                    style: TextStyle(fontSize: 10.5, color: Colors.amber.shade900, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          // SelectableText demo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SelectableText (also uses SelectionOverlay)',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                        color: Colors.indigo.shade700)),
                const SizedBox(height: 8.0),
                const SelectableText(
                  'This SelectableText also uses SelectionOverlay internally. '
                  'Try selecting this text – you will see the same handles '
                  'and toolbar, all managed by SelectionOverlay.',
                  style: TextStyle(fontSize: 13.0, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120.0,
            child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(value, style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                fontWeight: FontWeight.w600, color: color)),
          ),
        ],
      ),
    );
  }
}
