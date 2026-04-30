// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TextSelectionOverlay
// Demonstrates TextSelectionOverlay, which manages the floating selection
// handles and context-toolbar that appear when the user selects text in
// an editable field. It controls handle visibility, toolbar positioning,
// and the lifecycle of overlay entries in the Overlay stack.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionOverlay Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.select_all,
      'title': 'What is TextSelectionOverlay?',
      'body': 'TextSelectionOverlay is the object that creates and manages '
          'the draggable selection handles and the context toolbar (cut, '
          'copy, paste) when the user selects text. It inserts entries '
          'into the nearest Overlay and positions them relative to the '
          'selected text region.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.drag_handle,
      'title': 'Selection Handles',
      'body': 'Two handles appear at the start and end of the selection. '
          'The user drags these to expand or shrink the selection range. '
          'Handle appearance varies by platform — tear-drop on Android, '
          'thin bar with circle on iOS.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.content_cut,
      'title': 'Context Toolbar',
      'body': 'The toolbar offers actions like Cut, Copy, Paste, and Select '
          'All. It appears above or below the selection depending on '
          'available space. Each action modifies the clipboard or '
          'selection state.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.layers,
      'title': 'Overlay Integration',
      'body': 'TextSelectionOverlay uses OverlayEntry to float handles '
          'and toolbar above all other content. The entries are inserted '
          'when showing and removed when hiding or disposing. This is '
          'managed automatically by EditableText.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'context',
      'type': 'BuildContext',
      'desc': 'The build context of the editable text widget. Used to find '
          'the Overlay ancestor for inserting handle and toolbar entries.',
    },
    {
      'name': 'renderObject',
      'type': 'RenderEditable',
      'desc': 'The render object of the editable text. Provides text '
          'layout information: line heights, caret positions, and '
          'selection rects needed for handle positioning.',
    },
    {
      'name': 'value',
      'type': 'TextEditingValue',
      'desc': 'The current editing value with text content and selection. '
          'Updated via the update() method when the selection changes, '
          'which re-positions handles.',
    },
    {
      'name': 'selectionDelegate',
      'type': 'TextSelectionDelegate',
      'desc': 'Callback interface for text operations: cut, copy, paste, '
          'select all. The overlay calls these when the user taps '
          'toolbar actions.',
    },
    {
      'name': 'handlesVisible',
      'type': 'bool',
      'desc': 'Whether the drag handles are currently visible. Changing '
          'this does not insert/remove overlay entries — it controls '
          'the paint visibility of already-inserted handles.',
    },
    {
      'name': 'clipboardStatus',
      'type': 'ClipboardStatusNotifier?',
      'desc': 'Notifier that reports clipboard data availability. The '
          'toolbar uses this to enable/disable the Paste button.',
    },
    {
      'name': 'startHandleLayerLink',
      'type': 'LayerLink',
      'desc': 'Connects the start handle overlay to the editable text\'s '
          'compositing layer. Keeps the handle aligned with the text '
          'during layout and scroll.',
    },
    {
      'name': 'endHandleLayerLink',
      'type': 'LayerLink',
      'desc': 'Same as startHandleLayerLink but for the end selection '
          'handle. Both links ensure handles track text position.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Handle Types
  // ============================================================
  print('=== Section 3: Handle Types ===');

  final handleTypes = <Map<String, dynamic>>[
    {
      'type': 'Left Handle (Start)',
      'desc': 'Appears at the beginning of the selection. On Android, '
          'it is a tear-drop pointing right. On iOS, it is a vertical '
          'bar with a circle at the bottom. Drag leftward to expand '
          'selection start.',
      'visual': 'left',
      'color': Colors.teal,
    },
    {
      'type': 'Right Handle (End)',
      'desc': 'Appears at the end of the selection. On Android, a '
          'tear-drop pointing left. On iOS, a vertical bar with a '
          'circle at the top. Drag rightward to expand selection end.',
      'visual': 'right',
      'color': Colors.blue,
    },
    {
      'type': 'Collapsed Handle (Caret)',
      'desc': 'When the selection is collapsed (no text selected), a '
          'single handle appears at the caret position. Tapping near '
          'the caret shows this handle. Dragging repositions the caret.',
      'visual': 'collapsed',
      'color': Colors.deepOrange,
    },
  ];

  final handleWidgets = <Widget>[];
  for (var i = 0; i < handleTypes.length; i++) {
    final ht = handleTypes[i];
    final htColor = ht['color'] as Color;
    print('Handle ${i + 1}: ${ht['type']}');

    // Build a visual representation of the handle
    Widget handleVisual;
    if (ht['visual'] == 'left') {
      handleVisual = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: htColor,
              shape: BoxShape.circle,
            ),
          ),
          Container(width: 2, height: 22, color: htColor),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: htColor.withOpacity(0.15),
            child: Text(
              'Selected text region',
              style: TextStyle(fontSize: 10, color: htColor),
            ),
          ),
        ],
      );
    } else if (ht['visual'] == 'right') {
      handleVisual = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: htColor.withOpacity(0.15),
            child: Text(
              'Selected text region',
              style: TextStyle(fontSize: 10, color: htColor),
            ),
          ),
          const SizedBox(width: 4),
          Container(width: 2, height: 22, color: htColor),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: htColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    } else {
      handleVisual = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The quick ', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 2, height: 16, color: htColor),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: htColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Text(' brown fox', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      );
    }

    handleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: htColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: htColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ht['type'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: htColor,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: htColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: handleVisual,
              ),
              const SizedBox(height: 8),
              Text(
                ht['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Toolbar Actions
  // ============================================================
  print('=== Section 4: Toolbar ===');

  final toolbarActions = <Map<String, dynamic>>[
    {
      'action': 'Cut',
      'icon': Icons.content_cut,
      'desc': 'Copies the selected text to the clipboard and deletes it '
          'from the field. Only available when there is a non-empty '
          'selection and the field is not read-only.',
      'shortcut': 'Ctrl+X / Cmd+X',
      'color': Colors.red,
    },
    {
      'action': 'Copy',
      'icon': Icons.content_copy,
      'desc': 'Copies the selected text to the clipboard without removing '
          'it. Available whenever there is a non-empty selection. The '
          'most common toolbar action.',
      'shortcut': 'Ctrl+C / Cmd+C',
      'color': Colors.blue,
    },
    {
      'action': 'Paste',
      'icon': Icons.content_paste,
      'desc': 'Inserts clipboard content at the current cursor position '
          'or replaces the current selection. Only available when the '
          'clipboard contains text data.',
      'shortcut': 'Ctrl+V / Cmd+V',
      'color': Colors.green,
    },
    {
      'action': 'Select All',
      'icon': Icons.select_all,
      'desc': 'Expands the selection to include all text in the field. '
          'The handles move to the beginning and end of the text. '
          'Available when the field has content.',
      'shortcut': 'Ctrl+A / Cmd+A',
      'color': Colors.orange,
    },
  ];

  final toolbarWidgets = <Widget>[];
  for (var i = 0; i < toolbarActions.length; i++) {
    final ta = toolbarActions[i];
    final taColor = ta['color'] as Color;
    print('Toolbar ${i + 1}: ${ta['action']}');
    toolbarWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: taColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: taColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: taColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(ta['icon'] as IconData, color: taColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ta['action'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: taColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            ta['shortcut'] as String,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ta['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mini toolbar preview
  final toolbarPreview = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToolbarButton('Cut', Icons.content_cut, Colors.red),
        Container(width: 1, height: 24, color: Colors.grey.shade300),
        _buildToolbarButton('Copy', Icons.content_copy, Colors.blue),
        Container(width: 1, height: 24, color: Colors.grey.shade300),
        _buildToolbarButton('Paste', Icons.content_paste, Colors.green),
        Container(width: 1, height: 24, color: Colors.grey.shade300),
        _buildToolbarButton('All', Icons.select_all, Colors.orange),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Visibility Control
  // ============================================================
  print('=== Section 5: Visibility ===');

  final visibilityStates = <Map<String, dynamic>>[
    {
      'state': 'Both Visible',
      'desc': 'Handles and toolbar are both shown. This is the default '
          'state after the user makes a selection. The toolbar floats '
          'above (or below) the selection, handles at both ends.',
      'handles': true,
      'toolbar': true,
      'color': Colors.teal,
    },
    {
      'state': 'Handles Only',
      'desc': 'After scrolling or tapping the text (not the toolbar), '
          'the toolbar may be hidden while handles remain visible. '
          'Tapping a handle re-shows the toolbar.',
      'handles': true,
      'toolbar': false,
      'color': Colors.blue,
    },
    {
      'state': 'Toolbar Only',
      'desc': 'During keyboard-driven selection (Shift+arrows), the '
          'toolbar may appear without drag handles, since mouse/keyboard '
          'users don\'t need touch handles.',
      'handles': false,
      'toolbar': true,
      'color': Colors.deepOrange,
    },
    {
      'state': 'Both Hidden',
      'desc': 'When focus is lost or the selection is cleared, both '
          'handles and toolbar disappear. The overlay entries remain '
          'in the Overlay but are invisible.',
      'handles': false,
      'toolbar': false,
      'color': Colors.grey,
    },
  ];

  final visibilityWidgets = <Widget>[];
  for (var i = 0; i < visibilityStates.length; i++) {
    final vs = visibilityStates[i];
    final vsColor = vs['color'] as Color;
    final showHandles = vs['handles'] as bool;
    final showToolbar = vs['toolbar'] as bool;
    print('Visibility ${i + 1}: ${vs['state']}');

    visibilityWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: vsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: vsColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    vs['state'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: vsColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: (showHandles ? Colors.green : Colors.red)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Handles: ${showHandles ? "ON" : "OFF"}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: showHandles ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: (showToolbar ? Colors.green : Colors.red)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Toolbar: ${showToolbar ? "ON" : "OFF"}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: showToolbar ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Mini visual showing text with handles/toolbar state
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: vsColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    if (showToolbar)
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Cut | Copy | Paste',
                          style: TextStyle(fontSize: 9),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showHandles)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: vsColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          color: vsColor.withOpacity(0.15),
                          child: Text(
                            'Selected text',
                            style: TextStyle(fontSize: 10, color: vsColor),
                          ),
                        ),
                        if (showHandles)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: vsColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                vs['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Positioning
  // ============================================================
  print('=== Section 6: Positioning ===');

  final positioningItems = <Map<String, dynamic>>[
    {
      'title': 'Toolbar Above Selection',
      'desc': 'Default: the toolbar appears above the selected text. '
          'Offset is calculated from the top of the selection rect '
          'minus the toolbar height and padding.',
      'position': 'above',
      'color': Colors.teal,
    },
    {
      'title': 'Toolbar Below Selection',
      'desc': 'When there is not enough space above (near the top of '
          'screen), the toolbar shifts below the selection. The '
          'overlay automatically detects available space.',
      'position': 'below',
      'color': Colors.blue,
    },
    {
      'title': 'Handle Tracking via LayerLink',
      'desc': 'Handles are positioned using CompositedTransformFollower '
          'linked to the RenderEditable\'s compositing layer. This '
          'means handles automatically follow text during scroll, '
          'animation, and layout changes.',
      'position': 'linked',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Multi-Line Selection',
      'desc': 'For multi-line text, the start handle appears at the left '
          'of the first selected line and the end handle at the right '
          'of the last selected line. The toolbar centers above the '
          'selection midpoint.',
      'position': 'multiline',
      'color': Colors.green,
    },
  ];

  final positioningWidgets = <Widget>[];
  for (var i = 0; i < positioningItems.length; i++) {
    final pi = positioningItems[i];
    final piColor = pi['color'] as Color;
    print('Position ${i + 1}: ${pi['title']}');

    // Build a visual diagram
    Widget diagram;
    if (pi['position'] == 'above') {
      diagram = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Text('Cut | Copy | Paste', style: TextStyle(fontSize: 9)),
          ),
          Icon(Icons.arrow_drop_down, size: 16, color: piColor),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            color: piColor.withOpacity(0.15),
            child: Text('selected', style: TextStyle(fontSize: 10, color: piColor)),
          ),
        ],
      );
    } else if (pi['position'] == 'below') {
      diagram = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            color: piColor.withOpacity(0.15),
            child: Text('selected', style: TextStyle(fontSize: 10, color: piColor)),
          ),
          Icon(Icons.arrow_drop_down, size: 16, color: piColor),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('Cut | Copy | Paste', style: TextStyle(fontSize: 9)),
          ),
        ],
      );
    } else {
      diagram = Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.link, size: 14, color: piColor),
            const SizedBox(width: 4),
            Text(
              pi['position'] == 'linked' ? 'LayerLink sync' : 'Multi-line',
              style: TextStyle(fontSize: 10, color: piColor),
            ),
          ],
        ),
      );
    }

    positioningWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: piColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pi['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: piColor,
                ),
              ),
              const SizedBox(height: 10),
              Center(child: diagram),
              const SizedBox(height: 10),
              Text(
                pi['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Lifecycle
  // ============================================================
  print('=== Section 7: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1. Construction',
      'desc': 'TextSelectionOverlay is created by EditableTextState when '
          'the user begins text selection. The constructor receives '
          'the render object, editing value, and layer links.',
      'icon': Icons.build,
      'color': Colors.teal,
    },
    {
      'step': '2. showHandles()',
      'desc': 'Inserts handle OverlayEntries into the Overlay. The handles '
          'become visible and track the selection endpoints. Called '
          'after the user finishes a selection gesture.',
      'icon': Icons.visibility,
      'color': Colors.blue,
    },
    {
      'step': '3. showToolbar()',
      'desc': 'Inserts the toolbar OverlayEntry above the handles. The '
          'toolbar is positioned relative to the selection rect. '
          'Called after selection or on long-press.',
      'icon': Icons.build_circle,
      'color': Colors.deepOrange,
    },
    {
      'step': '4. update()',
      'desc': 'Called whenever the TextEditingValue changes. Re-positions '
          'handles and toolbar based on new selection range and text '
          'layout. Does not insert/remove entries.',
      'icon': Icons.refresh,
      'color': Colors.green,
    },
    {
      'step': '5. hide()',
      'desc': 'Makes handles and toolbar invisible without removing the '
          'overlay entries. Called during scroll or other temporary '
          'interruptions. Re-showing is cheap.',
      'icon': Icons.visibility_off,
      'color': Colors.orange,
    },
    {
      'step': '6. dispose()',
      'desc': 'Removes all overlay entries and releases resources. Called '
          'when the editable text loses focus, is removed from the '
          'tree, or the overlay is no longer needed.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final ls = lifecycleSteps[i];
    final lsColor = ls['color'] as Color;
    print('Lifecycle ${i + 1}: ${ls['step']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 20,
                  ),
                ),
                if (i < lifecycleSteps.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ls['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
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
    {
      'icon': Icons.select_all,
      'text': 'TextSelectionOverlay manages floating handles and toolbar '
          'for editable text selections.',
    },
    {
      'icon': Icons.drag_handle,
      'text': 'Three handle types: start, end, and collapsed (caret). '
          'Appearance varies by platform.',
    },
    {
      'icon': Icons.content_cut,
      'text': 'Toolbar provides Cut, Copy, Paste, Select All. Positioned '
          'above or below the selection.',
    },
    {
      'icon': Icons.layers,
      'text': 'Uses OverlayEntry for floating UI and LayerLink for '
          'position synchronization with the text.',
    },
    {
      'icon': Icons.loop,
      'text': 'Lifecycle: construct -> showHandles -> showToolbar -> '
          'update (repeating) -> hide -> dispose.',
    },
    {
      'icon': Icons.auto_awesome,
      'text': 'Managed automatically by EditableText/TextField. Direct '
          'usage only needed for custom text input widgets.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionOverlay'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.drag_handle), text: 'Handles'),
            Tab(icon: Icon(Icons.content_cut), text: 'Toolbar'),
            Tab(icon: Icon(Icons.visibility), text: 'Visibility'),
            Tab(icon: Icon(Icons.place), text: 'Position'),
            Tab(icon: Icon(Icons.loop), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextSelectionOverlay: floating handles and toolbar '
                  'for text selection management.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key parameters and properties of TextSelectionOverlay.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Handles
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Selection handle types and their visual appearance.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...handleWidgets,
            ],
          ),

          // Tab 4: Toolbar
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Context toolbar actions and their behavior.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              toolbarPreview,
              ...toolbarWidgets,
            ],
          ),

          // Tab 5: Visibility
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Controlling handle and toolbar visibility states.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...visibilityWidgets,
            ],
          ),

          // Tab 6: Position
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How handles and toolbar are positioned on screen.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...positioningWidgets,
            ],
          ),

          // Tab 7: Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Creation, updates, and disposal sequence.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.cyan.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TextSelectionOverlay.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildToolbarButton(String label, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 8, color: color)),
      ],
    ),
  );
}
