// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DragBoundary
// Demonstrates DragBoundary — an InheritedWidget that provides a
// boundary area to constrain drag gestures. Draggable children can
// query the nearest DragBoundary to know their allowed drag region.
// The delegate (DragBoundaryDelegate) defines the clamping logic.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragBoundary Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DragBoundary?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_square,
      'title': 'Drag Region Constraint',
      'body': 'DragBoundary is an InheritedWidget that defines a '
          'boundary region within which drag gestures are constrained. '
          'Draggable widgets and drag recognizers query the nearest '
          'DragBoundary ancestor to determine the permitted drag '
          'area, preventing objects from being dragged outside the '
          'designated region.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.extension,
      'title': 'DragBoundaryDelegate',
      'body': 'The actual clamping logic lives in a DragBoundaryDelegate '
          'object. DragBoundary holds a reference to this delegate. '
          'When a drag gesture needs to be constrained, the delegate\'s '
          'clampDrag method is called to adjust the drag offset. '
          'This separation allows different clamping strategies.',
      'accent': Colors.purple[700]!,
    },
    {
      'icon': Icons.open_with,
      'title': 'Automatic Integration',
      'body': 'Drag recognizers in Flutter automatically look up the '
          'nearest DragBoundary when processing drag events. When '
          'a DragBoundary is present, the recognizer calls the '
          'delegate to clamp drag offsets before reporting them to '
          'the gesture handler. No manual wiring needed.',
      'accent': Colors.pink[600]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Nested Boundaries',
      'body': 'DragBoundary widgets can be nested. The innermost '
          'boundary applies to child drag gestures. This enables '
          'patterns like a large scrollable area containing smaller '
          'constrained zones where specific items can be dragged '
          'within limited sub-regions.',
      'accent': Colors.purple[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  final hierarchyItems = <Map<String, dynamic>>[
    {
      'name': 'InheritedWidget',
      'depth': 0,
      'color': Colors.grey[500]!,
      'note': 'Base Flutter widget for propagating data down the tree',
    },
    {
      'name': 'DragBoundary',
      'depth': 1,
      'color': Colors.pink[700]!,
      'note': 'InheritedWidget holding a DragBoundaryDelegate. '
          'Look up with DragBoundary.of(context) or '
          'DragBoundary.maybeOf(context).',
    },
    {
      'name': 'DragBoundaryDelegate',
      'depth': 0,
      'color': Colors.purple[700]!,
      'note': 'Abstract base for drag clamping logic. Implement '
          'clampDrag(Offset proposed, Offset original) to constrain.',
    },
    {
      'name': 'Custom Delegate',
      'depth': 1,
      'color': Colors.purple[500]!,
      'note': 'Your implementation: e.g., RectDragBoundaryDelegate, '
          'CircleDragBoundaryDelegate, etc.',
    },
  ];

  print('  Prepared ${hierarchyItems.length} hierarchy items');

  // ============================================================
  // SECTION 3: Properties
  // ============================================================
  print('=== Section 3: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'delegate',
      'type': 'DragBoundaryDelegate',
      'icon': Icons.settings,
      'color': Colors.pink[700]!,
      'description': 'The delegate that defines the drag clamping '
          'behavior. When a drag gesture queries this boundary, the '
          'delegate\'s clampDrag method is called to constrain the '
          'proposed drag offset.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'icon': Icons.widgets,
      'color': Colors.purple[700]!,
      'description': 'The widget subtree within which drag gestures '
          'are constrained. All drag gestures from descendant widgets '
          'will query this boundary for clamping.',
    },
    {
      'name': 'of(context)',
      'type': 'DragBoundaryDelegate (static)',
      'icon': Icons.search,
      'color': Colors.pink[600]!,
      'description': 'Retrieves the nearest DragBoundary ancestor\'s '
          'delegate. Throws if no DragBoundary is found. Use when '
          'a boundary is expected to always be present.',
    },
    {
      'name': 'maybeOf(context)',
      'type': 'DragBoundaryDelegate? (static)',
      'icon': Icons.search_off,
      'color': Colors.purple[600]!,
      'description': 'Retrieves the nearest DragBoundary ancestor\'s '
          'delegate, or null if none exists. Use for optional '
          'boundary support where unconstrained drag is acceptable.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 4: DragBoundaryDelegate API
  // ============================================================
  print('=== Section 4: Delegate API ===');

  final delegateMethods = <Map<String, dynamic>>[
    {
      'name': 'clampDrag',
      'signature': 'Offset clampDrag(\n'
          '  Offset proposedPosition,\n'
          '  Offset originalPosition,\n'
          ')',
      'color': Colors.pink[700]!,
      'description': 'Called during a drag gesture to constrain the '
          'proposed position. Returns the clamped position. '
          'proposedPosition is where the drag wants to go, '
          'originalPosition is where the drag started.',
    },
    {
      'name': 'shouldRelayout',
      'signature': 'bool shouldRelayout(\n'
          '  DragBoundaryDelegate oldDelegate,\n'
          ')',
      'color': Colors.purple[700]!,
      'description': 'Called when the delegate changes to determine '
          'whether dependent widgets should re-layout. Return true '
          'if the new clamping logic differs from the old one.',
    },
  ];

  print('  Prepared ${delegateMethods.length} delegate methods');

  // ============================================================
  // SECTION 5: Visual Boundary Examples
  // ============================================================
  print('=== Section 5: Boundary Examples ===');

  final boundaryExamples = <Map<String, dynamic>>[
    {
      'title': 'Rectangular Boundary',
      'icon': Icons.crop_square,
      'color': Colors.pink[700]!,
      'shape': 'rectangle',
      'description': 'Constrains drag to a rectangular area defined '
          'by left, top, right, bottom offsets. The most common '
          'boundary type. Item cannot leave the rectangle.',
      'clampLogic': 'dx clamped to [left, right]\n'
          'dy clamped to [top, bottom]',
    },
    {
      'title': 'Circular Boundary',
      'icon': Icons.circle_outlined,
      'color': Colors.purple[700]!,
      'shape': 'circle',
      'description': 'Constrains drag to a circular area defined by '
          'center and radius. If the proposed position exceeds '
          'the radius, it is projected back onto the circle edge.',
      'clampLogic': 'distance = offset.distance\n'
          'if distance > radius:\n'
          '  offset = offset / distance * radius',
    },
    {
      'title': 'Horizontal Only',
      'icon': Icons.swap_horiz,
      'color': Colors.pink[600]!,
      'shape': 'horizontal',
      'description': 'Constrains drag to horizontal movement only, '
          'ignoring vertical component. Useful for sliders, '
          'horizontal carousels, and timeline scrubbers.',
      'clampLogic': 'return Offset(proposed.dx, original.dy)',
    },
    {
      'title': 'Vertical Only',
      'icon': Icons.swap_vert,
      'color': Colors.purple[600]!,
      'shape': 'vertical',
      'description': 'Constrains drag to vertical movement only, '
          'ignoring horizontal component. Useful for vertical '
          'range selectors and height-adjustable panels.',
      'clampLogic': 'return Offset(original.dx, proposed.dy)',
    },
    {
      'title': 'Snap-to-Grid',
      'icon': Icons.grid_on,
      'color': Colors.pink[500]!,
      'shape': 'grid',
      'description': 'Snaps drag position to the nearest grid point. '
          'Useful for diagram editors, tile placement, and any '
          'layout where alignment matters.',
      'clampLogic': 'dx = (proposed.dx / gridSize).round()\n'
          '     * gridSize\n'
          'dy = (proposed.dy / gridSize).round()\n'
          '     * gridSize',
    },
  ];

  print('  Prepared ${boundaryExamples.length} boundary examples');

  // ============================================================
  // SECTION 6: Use Cases
  // ============================================================
  print('=== Section 6: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Kanban Board',
      'icon': Icons.view_column,
      'color': Colors.pink[700]!,
      'description': 'A Kanban board where cards can be dragged within '
          'a column but cannot be dragged outside the column '
          'boundaries. Each column has its own DragBoundary ensuring '
          'cards stay within their lane.',
    },
    {
      'title': 'Image Cropping',
      'icon': Icons.crop,
      'color': Colors.purple[700]!,
      'description': 'A crop rectangle with drag handles that must '
          'stay within the image bounds. The DragBoundary prevents '
          'handles from being dragged beyond the image edges.',
    },
    {
      'title': 'Game Character Movement',
      'icon': Icons.games,
      'color': Colors.pink[600]!,
      'description': 'A game where a character can be dragged around '
          'a play area but cannot leave the game board. The boundary '
          'constrains movement to the board rectangle.',
    },
    {
      'title': 'Slider Track',
      'icon': Icons.linear_scale,
      'color': Colors.purple[600]!,
      'description': 'A custom slider where the thumb can only be '
          'dragged along the track. A horizontal-only DragBoundary '
          'constrains the drag to the track\'s horizontal axis.',
    },
    {
      'title': 'Diagram Editor',
      'icon': Icons.account_tree,
      'color': Colors.pink[500]!,
      'description': 'A node-based diagram editor where nodes can be '
          'dragged within the canvas area. The boundary prevents '
          'nodes from being dragged off-canvas. A grid delegate '
          'adds snap-to-grid behavior.',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Setup with Custom Delegate',
      'color': Colors.pink[700]!,
      'code': '// Define a boundary with a custom delegate\n'
          'class RectBoundaryDelegate\n'
          '    extends DragBoundaryDelegate {\n'
          '  final Rect bounds;\n'
          '  RectBoundaryDelegate(this.bounds);\n'
          '\n'
          '  @override\n'
          '  Offset clampDrag(\n'
          '    Offset proposed,\n'
          '    Offset original,\n'
          '  ) {\n'
          '    return Offset(\n'
          '      proposed.dx.clamp(\n'
          '        bounds.left, bounds.right,\n'
          '      ),\n'
          '      proposed.dy.clamp(\n'
          '        bounds.top, bounds.bottom,\n'
          '      ),\n'
          '    );\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  bool shouldRelayout(\n'
          '    DragBoundaryDelegate old,\n'
          '  ) => true;\n'
          '}',
    },
    {
      'title': 'Using DragBoundary in Widget Tree',
      'color': Colors.purple[700]!,
      'code': '// Wrap draggable content\n'
          'DragBoundary(\n'
          '  delegate: RectBoundaryDelegate(\n'
          '    Rect.fromLTWH(0, 0, 300, 300),\n'
          '  ),\n'
          '  child: Stack(\n'
          '    children: [\n'
          '      // Background\n'
          '      Container(\n'
          '        width: 300,\n'
          '        height: 300,\n'
          '        color: Colors.grey[200],\n'
          '      ),\n'
          '      // Draggable item\n'
          '      Positioned(\n'
          '        left: _x,\n'
          '        top: _y,\n'
          '        child: GestureDetector(\n'
          '          onPanUpdate: (d) {\n'
          '            // Drag auto-clamped\n'
          '          },\n'
          '          child: _item(),\n'
          '        ),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Querying the Boundary',
      'color': Colors.pink[600]!,
      'code': '// Look up the nearest boundary\n'
          'final delegate =\n'
          '    DragBoundary.of(context);\n'
          '\n'
          'final clamped = delegate.clampDrag(\n'
          '  proposedOffset,\n'
          '  originalOffset,\n'
          ');\n'
          '\n'
          '// Or safely with maybeOf:\n'
          'final maybeDelegate =\n'
          '    DragBoundary.maybeOf(context);\n'
          'if (maybeDelegate != null) {\n'
          '  final safe = maybeDelegate.clampDrag(\n'
          '    proposedOffset,\n'
          '    originalOffset,\n'
          '  );\n'
          '}',
    },
    {
      'title': 'Nested Boundaries',
      'color': Colors.purple[600]!,
      'code': '// Outer boundary: full canvas\n'
          'DragBoundary(\n'
          '  delegate: RectBoundaryDelegate(\n'
          '    Rect.fromLTWH(0, 0, 600, 400),\n'
          '  ),\n'
          '  child: Stack(\n'
          '    children: [\n'
          '      // Inner boundary: zone\n'
          '      Positioned(\n'
          '        left: 50,\n'
          '        top: 50,\n'
          '        child: DragBoundary(\n'
          '          delegate: RectBoundaryDelegate(\n'
          '            Rect.fromLTWH(\n'
          '              0, 0, 200, 200,\n'
          '            ),\n'
          '          ),\n'
          '          child: _zoneContent(),\n'
          '        ),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: How It Works Under the Hood
  // ============================================================
  print('=== Section 8: Under the Hood ===');

  final mechanismSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'DragBoundary in Widget Tree',
      'color': Colors.pink[700]!,
      'detail': 'DragBoundary extends InheritedWidget and stores a '
          'DragBoundaryDelegate. It inserts itself into the build '
          'context inheritance chain so descendants can find it.',
    },
    {
      'step': 2,
      'title': 'Drag Gesture Starts',
      'color': Colors.purple[700]!,
      'detail': 'When a drag gesture is recognized (e.g., by a '
          'GestureDetector or Draggable), the drag recognizer '
          'checks for a DragBoundary ancestor using '
          'DragBoundary.maybeOf(context).',
    },
    {
      'step': 3,
      'title': 'Delegate Queried on Each Frame',
      'color': Colors.pink[600]!,
      'detail': 'On each drag update, the recognizer calls '
          'delegate.clampDrag(proposed, original) where proposed '
          'is the new offset from the raw gesture and original is '
          'the reference point (usually the drag start position).',
    },
    {
      'step': 4,
      'title': 'Clamped Offset Returned',
      'color': Colors.purple[600]!,
      'detail': 'The delegate computes and returns a constrained '
          'offset. This might clamp to a rectangle, project onto '
          'a circle, snap to a grid, or apply any custom logic.',
    },
    {
      'step': 5,
      'title': 'Drag Event with Clamped Delta',
      'color': Colors.pink[500]!,
      'detail': 'The recognizer uses the clamped offset to compute '
          'the reported drag delta. The gesture consumer (e.g., '
          'onPanUpdate) receives a constrained delta that respects '
          'the boundary.',
    },
  ];

  print('  Prepared ${mechanismSteps.length} mechanism steps');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Keep Delegates Lightweight',
      'body': 'The clampDrag method is called on every drag frame. '
          'Keep the computation simple — basic clamping, rounding, '
          'or projection. Avoid allocations or heavy math in the '
          'delegate.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Boundary != Containment Enforcement',
      'body': 'DragBoundary constrains the reported drag offset, but '
          'the actual widget positioning is up to your code. If '
          'you do not use the clamped values for positioning, the '
          'widget can still visually escape the boundary.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Coordinate Systems',
      'body': 'Ensure the delegate works in the correct coordinate '
          'system. The proposed/original offsets are relative to '
          'the drag start point. Transform to local coordinates '
          'if your boundary is defined in parent space.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Testing Boundaries',
      'body': 'In widget tests, use tester.drag() and verify the '
          'final position of the dragged widget. The boundary '
          'should prevent movement beyond the specified limits '
          'even when the simulated drag exceeds them.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Pair with Draggable or GestureDetector',
      'body': 'DragBoundary works with any drag-based widget. Use '
          'it with Draggable for drag-and-drop, GestureDetector '
          'for custom drag handling, or drag recognizers directly '
          'for low-level control.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Dynamic Boundaries',
      'body': 'The delegate can change at runtime. For example, '
          'resizing a container updates the boundary rectangle. '
          'Implement shouldRelayout to trigger re-layout when the '
          'bounds change.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('DragBoundary'),
      backgroundColor: Colors.pink[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink[700]!, Colors.purple[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.crop_square, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DragBoundary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An InheritedWidget that provides a DragBoundaryDelegate '
                  'to constrain drag gestures within a defined region. '
                  'Draggable children query the nearest boundary to '
                  'clamp their drag offsets, preventing items from '
                  'being dragged outside the permitted area.',
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
          _dbHead('1', 'What is DragBoundary?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Hierarchy ──
          _dbHead('2', 'Class Hierarchy'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                ...hierarchyItems.map((h) {
                  final depth = h['depth'] as int;
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 8, left: depth * 24.0),
                    child: Row(children: [
                      if (depth > 0)
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text('└─',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: Colors.grey[400])),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (h['color'] as Color)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: h['color'] as Color),
                        ),
                        child: Text(h['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: h['color'] as Color)),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(h['note'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[600])),
                      ),
                    ]),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 3: Properties ──
          _dbHead('3', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
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
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _dbTag(p['type'] as String,
                            p['color'] as Color),
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

          // ── Section 4: Delegate API ──
          _dbHead('4', 'DragBoundaryDelegate API'),
          SizedBox(height: 12),
          ...delegateMethods.map((dm) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: dm['color'] as Color, width: 4),
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
                      Text(dm['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'monospace',
                              color: dm['color'] as Color)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(dm['signature'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.pink[200])),
                      ),
                      SizedBox(height: 8),
                      Text(dm['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Boundary Examples ──
          _dbHead('5', 'Boundary Shape Examples'),
          SizedBox(height: 12),
          ...boundaryExamples.map((be) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: be['color'] as Color, width: 4),
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
                        Icon(be['icon'] as IconData,
                            color: be['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(be['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(be['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(be['clampLogic'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.pink[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Use Cases ──
          _dbHead('6', 'Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
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
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _dbHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.pink[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Under the Hood ──
          _dbHead('8', 'How It Works Under the Hood'),
          SizedBox(height: 12),
          ...mechanismSteps.map((ms) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ms['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: ms['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ms['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(ms['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(ms['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
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

          // ── Section 9: Tips ──
          _dbHead('9', 'Tips & Best Practices'),
          SizedBox(height: 12),
          ...tips.map((tip) {
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
          Center(
            child: Text(
              'End of DragBoundary Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _dbHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.pink[700],
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
// Helper: Type tag
// ──────────────────────────────────────────────────────────
Widget _dbTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
