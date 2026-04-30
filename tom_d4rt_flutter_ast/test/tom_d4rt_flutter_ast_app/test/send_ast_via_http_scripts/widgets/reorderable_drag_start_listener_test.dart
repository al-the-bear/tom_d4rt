// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ReorderableDragStartListener
// Demonstrates ReorderableDragStartListener — the immediate variant
// that begins dragging as soon as the user starts a drag gesture,
// without requiring a long-press delay. Best suited for desktop and
// pointer-based interfaces where scroll conflicts are minimal.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableDragStartListener Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — Immediate Drag for Reorderable Lists
  // ============================================================
  print('=== Section 1: Concept ===');

  // ReorderableDragStartListener responds to pointer-down events
  // immediately — as soon as the user starts moving the item, the
  // reorder operation begins. This is the preferred approach on
  // desktop / mouse-driven interfaces where scrolling uses the
  // scroll wheel and dragging uses click-and-drag.
  //
  // The class is the base for ReorderableDelayedDragStartListener.
  // It uses ImmediateMultiDragGestureRecognizer internally.
  //
  // Key properties:
  //   - index (int): Position inside the reorderable list
  //   - child (Widget): Visual content that can be dragged
  //   - enabled (bool): Whether drag reordering is allowed

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1565C0), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.open_with, size: 36.0, color: Color(0xFF1565C0)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ReorderableDragStartListener',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'The immediate-drag variant for reorderable lists. '
          'Dragging starts as soon as the pointer moves — there '
          'is no long-press delay. Ideal for desktop / pointer '
          'interfaces where scroll conflicts are not an issue.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ReorderableDragStartListener(\n'
            '  index: 2,\n'
            '  child: MyTile(item),\n'
            ')\n\n'
            '// Uses ImmediateMultiDragGestureRecognizer\n'
            '// — drag begins without any delay.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: API Surface — Properties & Inheritance
  // ============================================================
  print('=== Section 2: API surface ===');

  Widget buildApiRow(
    String propertyName,
    String type,
    String description,
    Color tagColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: tagColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: tagColor,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertyName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final apiSurface = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'API Surface',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ReorderableDragStartListener extends StatelessWidget',
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 12.0),
        buildApiRow(
          'index',
          'int',
          'Position of this item in the reorderable list. '
              'Required — the framework uses this to track '
              'which item the user is dragging.',
          Color(0xFF1976D2),
        ),
        buildApiRow(
          'child',
          'Widget',
          'The widget wrapped by this listener. It becomes '
              'the draggable content.',
          Color(0xFF388E3C),
        ),
        buildApiRow(
          'enabled',
          'bool',
          'If false, the listener ignores pointer events. '
              'Default: true.',
          Color(0xFFF57C00),
        ),
        SizedBox(height: 12.0),
        // Inheritance chain
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inheritance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF4527A0),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Widget → StatelessWidget\n'
                '  → ReorderableDragStartListener  (immediate)\n'
                '     → ReorderableDelayedDragStartListener  (delayed)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF4527A0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Immediate vs Delayed — Key Differences
  // ============================================================
  print('=== Section 3: Immediate vs delayed ===');

  Widget buildDiffRow(
    String aspect,
    String immediate,
    String delayed,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Container(
            width: 100.0,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
              ),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              aspect,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                border: Border.all(color: Color(0xFF1565C0).withValues(alpha: 0.3)),
              ),
              child: Text(
                immediate,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF0D47A1)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                ),
                border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.3)),
              ),
              child: Text(
                delayed,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF1B5E20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final diffTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Immediate vs Delayed',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        // Header row
        Row(
          children: [
            Container(
              width: 100.0,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Aspect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                  ),
                ),
                child: Text(
                  'Immediate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2E7D32),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6.0),
                  ),
                ),
                child: Text(
                  'Delayed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        buildDiffRow(
          'Gesture',
          'Drag immediately',
          'Long-press then drag',
        ),
        buildDiffRow(
          'Recognizer',
          'ImmediateMultiDrag',
          'DelayedMultiDrag',
        ),
        buildDiffRow(
          'Best for',
          'Desktop / mouse',
          'Touch / mobile',
        ),
        buildDiffRow(
          'Scroll conflict',
          'Can conflict on touch',
          'Avoids conflicts',
        ),
        buildDiffRow(
          'Response time',
          '0ms — instant',
          '~500ms long-press',
        ),
        buildDiffRow(
          'Use case',
          'Drag handles, desktop lists',
          'Mobile list reordering',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Desktop-Style List with Drag Handles
  // ============================================================
  print('=== Section 4: Desktop list with drag handles ===');

  // A typical desktop usage: the entire item is NOT draggable,
  // but a drag handle icon on the side is wrapped with
  // ReorderableDragStartListener. Clicking and dragging the
  // handle immediately starts reordering.

  final fileItems = <Map<String, dynamic>>[
    {
      'name': 'README.md',
      'icon': Icons.description,
      'size': '4.2 KB',
      'color': Color(0xFF1976D2),
      'type': 'Markdown',
    },
    {
      'name': 'main.dart',
      'icon': Icons.code,
      'size': '12.8 KB',
      'color': Color(0xFF00897B),
      'type': 'Dart',
    },
    {
      'name': 'pubspec.yaml',
      'icon': Icons.settings,
      'size': '1.1 KB',
      'color': Color(0xFFF4511E),
      'type': 'YAML',
    },
    {
      'name': 'analysis_options.yaml',
      'icon': Icons.tune,
      'size': '892 B',
      'color': Color(0xFF7B1FA2),
      'type': 'YAML',
    },
    {
      'name': 'test_runner.dart',
      'icon': Icons.play_circle,
      'size': '6.3 KB',
      'color': Color(0xFF388E3C),
      'type': 'Dart',
    },
    {
      'name': 'CHANGELOG.md',
      'icon': Icons.history,
      'size': '2.7 KB',
      'color': Color(0xFF5D4037),
      'type': 'Markdown',
    },
    {
      'name': 'LICENSE',
      'icon': Icons.gavel,
      'size': '1.1 KB',
      'color': Color(0xFF455A64),
      'type': 'Text',
    },
  ];

  Widget buildFileRow(
    Map<String, dynamic> file,
    int index, {
    bool showDragHandle = true,
    bool isDragging = false,
  }) {
    final color = file['color'] as Color;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: isDragging
            ? color.withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isDragging ? color : Colors.grey.shade200,
          width: isDragging ? 2.0 : 1.0,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.25),
                  blurRadius: 10.0,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            if (showDragHandle) ...[
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: isDragging
                      ? color.withValues(alpha: 0.15)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Icon(
                  Icons.drag_indicator,
                  size: 18.0,
                  color: isDragging ? color : Colors.grey.shade400,
                ),
              ),
              SizedBox(width: 10.0),
            ],
            Icon(file['icon'] as IconData, color: color, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                      color: isDragging ? color : Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    '${file['type']} · ${file['size']}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '#${index + 1}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final desktopList = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.folder_open, color: Color(0xFF1976D2), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'File Explorer — Drag Handle Reorder',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Click and drag the ≡ handle to reorder files instantly.\n'
          'No long-press needed — ideal for mouse-based interaction.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        // The file list
        for (var i = 0; i < fileItems.length; i++)
          buildFileRow(fileItems[i], i),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Drag Feedback — What Happens During the Drag
  // ============================================================
  print('=== Section 5: Drag feedback visuals ===');

  // Show three visual states of a drag operation:
  // 1. Before drag (at rest)
  // 2. During drag (elevated item + placeholder)
  // 3. After drop (final position)

  Widget buildDragState(
    String label,
    Color labelColor,
    List<Widget> items,
  ) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: labelColor),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: labelColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: labelColor,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ...items,
        ],
      ),
    );
  }

  Widget buildMiniItem(String label, Color color, {bool isPlaceholder = false, bool isElevated = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      height: 32.0,
      decoration: BoxDecoration(
        color: isPlaceholder
            ? Colors.grey.shade200
            : isElevated
                ? color.withValues(alpha: 0.2)
                : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: isPlaceholder
              ? Colors.grey.shade400
              : isElevated
                  ? color
                  : color.withValues(alpha: 0.3),
          width: isElevated ? 2.0 : 1.0,
        ),
        boxShadow: isElevated
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 6.0,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Text(
        isPlaceholder ? '---' : label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: isElevated ? FontWeight.bold : FontWeight.normal,
          color: isPlaceholder ? Colors.grey.shade500 : color,
        ),
      ),
    );
  }

  final dragFeedbackSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Drag Feedback — Three States',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How the list looks at each stage of the reorder operation.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            // Before
            buildDragState(
              '① Before',
              Color(0xFF9E9E9E),
              [
                buildMiniItem('Apple', Color(0xFFF44336)),
                buildMiniItem('Banana', Color(0xFFFFC107)),
                buildMiniItem('Cherry', Color(0xFFE91E63)),
                buildMiniItem('Date', Color(0xFF795548)),
              ],
            ),
            // During — Banana is being dragged to after Cherry
            buildDragState(
              '② During',
              Color(0xFF2196F3),
              [
                buildMiniItem('Apple', Color(0xFFF44336)),
                buildMiniItem('', Colors.grey, isPlaceholder: true),
                buildMiniItem('Cherry', Color(0xFFE91E63)),
                buildMiniItem('Banana', Color(0xFFFFC107), isElevated: true),
                buildMiniItem('Date', Color(0xFF795548)),
              ],
            ),
            // After — new order
            buildDragState(
              '③ After',
              Color(0xFF4CAF50),
              [
                buildMiniItem('Apple', Color(0xFFF44336)),
                buildMiniItem('Cherry', Color(0xFFE91E63)),
                buildMiniItem('Banana', Color(0xFFFFC107)),
                buildMiniItem('Date', Color(0xFF795548)),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Custom Builder Pattern
  // ============================================================
  print('=== Section 6: Custom builder pattern ===');

  // Show how to compose ReorderableDragStartListener into a
  // custom header-like list with different item types.

  Widget buildLayerItem(
    String name,
    IconData icon,
    Color color,
    int idx,
    String opacity,
    bool visible,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.drag_indicator,
            color: Colors.grey.shade400,
            size: 18.0,
          ),
          SizedBox(width: 8.0),
          Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: visible ? Colors.grey.shade600 : Colors.grey.shade300,
            size: 18.0,
          ),
          SizedBox(width: 8.0),
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: visible ? Colors.grey.shade800 : Colors.grey.shade400,
              ),
            ),
          ),
          Text(
            opacity,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  final layerPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.white70, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Layer Panel — Design Tool Style',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Drag the ≡ handles to reorder layers instantly.\n'
          'Common in design apps like Figma, Photoshop, etc.',
          style: TextStyle(fontSize: 11.0, color: Colors.white54),
        ),
        SizedBox(height: 12.0),
        buildLayerItem(
          'Background',
          Icons.image,
          Color(0xFF3F51B5),
          0,
          '100%',
          true,
        ),
        buildLayerItem(
          'Header Text',
          Icons.text_fields,
          Color(0xFFF44336),
          1,
          '100%',
          true,
        ),
        buildLayerItem(
          'Logo',
          Icons.star,
          Color(0xFFFFC107),
          2,
          '75%',
          true,
        ),
        buildLayerItem(
          'Shadow Overlay',
          Icons.gradient,
          Color(0xFF212121),
          3,
          '40%',
          true,
        ),
        buildLayerItem(
          'Grid Lines',
          Icons.grid_on,
          Color(0xFF9E9E9E),
          4,
          '50%',
          false,
        ),
        buildLayerItem(
          'Watermark',
          Icons.water_drop,
          Color(0xFF81D4FA),
          5,
          '20%',
          false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Platform Usage Guide
  // ============================================================
  print('=== Section 7: Platform usage guide ===');

  Widget buildPlatformCard(
    String platform,
    IconData icon,
    String listener,
    String reason,
    Color color,
  ) {
    return Container(
      width: 210.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.0),
          SizedBox(height: 8.0),
          Text(
            platform,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: color,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              listener,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            reason,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  final platformGuide = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Platform Guidance',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Which listener to use on each platform.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildPlatformCard(
              'Desktop',
              Icons.desktop_windows,
              'DragStartListener',
              'Mouse click-and-drag never conflicts '
                  'with scrolling (scroll wheel).',
              Color(0xFF1565C0),
            ),
            buildPlatformCard(
              'Mobile / Touch',
              Icons.smartphone,
              'DelayedDragStart\nListener',
              'Touch-scroll and touch-drag look the '
                  'same — delay resolves the ambiguity.',
              Color(0xFF2E7D32),
            ),
            buildPlatformCard(
              'Web',
              Icons.public,
              'Platform-dependent',
              'Detect pointer type at runtime. Use '
                  'immediate for mouse, delayed for touch.',
              Color(0xFFF57C00),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Handle-Only vs Full-Item Drag
  // ============================================================
  print('=== Section 8: Handle-only vs full-item ===');

  final handleVsFullItem = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'Handle-Only vs Full-Item Drag',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 12.0),
        // Handle only
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF7B1FA2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '① Handle-Only Drag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF7B1FA2),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Only the drag handle triggers reordering.',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF7B1FA2).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xFF7B1FA2)),
                      ),
                      child: Icon(
                        Icons.drag_indicator,
                        color: Color(0xFF7B1FA2),
                        size: 20.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Item content — clicking here does NOT drag',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Wrap only the drag-handle icon: \n'
                'ReorderableDragStartListener(\n'
                '  index: idx,\n'
                '  child: Icon(Icons.drag_indicator),\n'
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Color(0xFF4A148C),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Full item
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFAD1457)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '② Full-Item Drag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFFAD1457),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Touching anywhere on the item starts the drag.',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFAD1457).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Color(0xFFAD1457),
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.open_with,
                      color: Color(0xFFAD1457),
                      size: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Entire item is draggable — click anywhere',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFFAD1457),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Wrap the entire tile: \n'
                'ReorderableDragStartListener(\n'
                '  index: idx,\n'
                '  child: ListTile(title: Text(item)),\n'
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Color(0xFF880E4F),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Code Example — Minimal Complete Usage
  // ============================================================
  print('=== Section 9: Code example ===');

  final codeExample = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF80CBC4), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Minimal Usage Example',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1B2631),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ReorderableList(\n'
            '  itemCount: items.length,\n'
            '  onReorder: (old, new_) {\n'
            '    final item = items.removeAt(old);\n'
            '    items.insert(new_, item);\n'
            '  },\n'
            '  itemBuilder: (ctx, index) {\n'
            '    return ReorderableDragStartListener(\n'
            '      key: ValueKey(items[index].id),\n'
            '      index: index,\n'
            '      child: ListTile(\n'
            '        leading: Icon(Icons.drag_indicator),\n'
            '        title: Text(items[index].name),\n'
            '      ),\n'
            '    );\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _buildDragCodeStep(
          '1',
          'Use with ReorderableList or ReorderableListView.builder',
        ),
        SizedBox(height: 4.0),
        _buildDragCodeStep(
          '2',
          'Provide a unique Key on the listener — required for tracking',
        ),
        SizedBox(height: 4.0),
        _buildDragCodeStep(
          '3',
          'Set index to the item\'s current position in the data list',
        ),
        SizedBox(height: 4.0),
        _buildDragCodeStep(
          '4',
          'In onReorder, update your data model (remove + insert)',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF1565C0), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF1565C0), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildDragSummaryItem(
          Icons.flash_on,
          'Instant response',
          'Drag starts immediately — no waiting delay',
          Color(0xFFFF9800),
        ),
        SizedBox(height: 8.0),
        _buildDragSummaryItem(
          Icons.desktop_windows,
          'Desktop-first',
          'Best for pointer/mouse interfaces with scroll-wheel',
          Color(0xFF1976D2),
        ),
        SizedBox(height: 8.0),
        _buildDragSummaryItem(
          Icons.drag_indicator,
          'Handle pattern',
          'Commonly used with a drag-handle icon to isolate the drag area',
          Color(0xFF7B1FA2),
        ),
        SizedBox(height: 8.0),
        _buildDragSummaryItem(
          Icons.extension,
          'Base class',
          'ReorderableDelayedDragStartListener extends this class',
          Color(0xFF388E3C),
        ),
        SizedBox(height: 8.0),
        _buildDragSummaryItem(
          Icons.key,
          'Index required',
          'Must provide the correct index to track item position',
          Color(0xFFE91E63),
        ),
      ],
    ),
  );

  print('ReorderableDragStartListener Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1565C0),
                Color(0xFF1976D2),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.open_with, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ReorderableDragStartListener',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Immediate drag — no delay',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. API Surface',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        apiSurface,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Immediate vs Delayed',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        diffTable,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Desktop File Explorer',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        desktopList,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Drag Feedback States',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        dragFeedbackSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Layer Panel — Design Tool',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        layerPanel,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Platform Guidance',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        platformGuide,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Handle-Only vs Full-Item',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        handleVsFullItem,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Code Example',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        codeExample,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '10. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildDragCodeStep(String number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 22.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: Color(0xFF80CBC4),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            color: Color(0xFF263238),
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 11.0, color: Colors.white70),
        ),
      ),
    ],
  );
}

Widget _buildDragSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
