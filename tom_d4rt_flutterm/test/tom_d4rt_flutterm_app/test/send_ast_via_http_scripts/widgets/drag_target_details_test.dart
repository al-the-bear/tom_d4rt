// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DragTargetDetails
// Demonstrates DragTargetDetails<T>, the class that carries information
// about data accepted by a DragTarget. Covers its properties (data,
// offset), integration with Draggable/DragTarget/LongPressDraggable,
// typed drag data, offset coordinate systems, multi-type drag targets,
// visual feedback, and real-world drag-and-drop patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragTargetDetails Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DragTargetDetails?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.move_to_inbox,
      'title': 'Accepted Drag Data Carrier',
      'body': 'DragTargetDetails<T> is an immutable class that holds '
          'the data and offset of a drag operation that was accepted '
          'by a DragTarget. When a Draggable is dropped onto a '
          'DragTarget and the onWillAcceptWithDetails callback '
          'returns true, a DragTargetDetails instance is created '
          'containing the accepted payload.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.data_object,
      'title': 'Two Key Properties',
      'body': 'DragTargetDetails has two properties:\n'
          '• data — the typed payload (T) carried by the Draggable\n'
          '• offset — the Offset where the pointer was when the '
          'drop occurred, in global (screen) coordinates.\n\n'
          'These are all you need to process a drop: what was '
          'dropped and where it landed.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.sync_alt,
      'title': 'Bridge Between Draggable and DragTarget',
      'body': 'DragTargetDetails connects the producer (Draggable, '
          'which creates the data) with the consumer (DragTarget, '
          'which accepts and processes it). The DragTarget receives '
          'the details in onAcceptWithDetails, where you can use '
          'both the data and the precise drop position.',
      'accent': Colors.brown[500]!,
    },
    {
      'icon': Icons.pin_drop,
      'title': 'Position-Aware Drops',
      'body': 'The offset property enables position-aware drop '
          'handling. You can determine where in the target the '
          'item was dropped: left side vs. right side, top vs. '
          'bottom, or map to a grid cell. Convert from global '
          'to local coordinates with the RenderBox.',
      'accent': Colors.brown[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: DragTargetDetails Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'data',
      'type': 'T',
      'icon': Icons.inventory_2,
      'color': Colors.amber[700]!,
      'desc': 'The payload carried by the Draggable. The type T is '
          'the generic type parameter of both the Draggable and '
          'the DragTarget. For example, Draggable<String> produces '
          'DragTargetDetails<String> where data is the String.',
      'example': 'details.data  // → "task-42" (String)',
    },
    {
      'name': 'offset',
      'type': 'Offset',
      'icon': Icons.my_location,
      'color': Colors.brown[500]!,
      'desc': 'The global position (screen coordinates) of the '
          'pointer at the moment the drop was accepted. To convert '
          'to local coordinates within the DragTarget, use:\n\n'
          'final box = context.findRenderObject() as RenderBox;\n'
          'final local = box.globalToLocal(details.offset);',
      'example': 'details.offset  // → Offset(183.2, 412.7)',
    },
  ];

  print('  Listed ${properties.length} properties');

  // ============================================================
  // SECTION 3: Drag & Drop Architecture
  // ============================================================
  print('=== Section 3: Architecture ===');

  final architectureParts = <Map<String, dynamic>>[
    {
      'title': 'Draggable<T>',
      'subtitle': 'Producer',
      'icon': Icons.open_with,
      'color': Colors.blue[600]!,
      'body': 'Creates the drag data. Has a child (display widget), '
          'feedback (widget shown during drag), and data property '
          '(the payload). When the user starts dragging, the '
          'feedback widget follows the pointer.',
    },
    {
      'title': 'DragTarget<T>',
      'subtitle': 'Consumer',
      'icon': Icons.inbox,
      'color': Colors.green[600]!,
      'body': 'Receives the drag data. Has builder (display), '
          'onWillAcceptWithDetails (accept/reject test), and '
          'onAcceptWithDetails (process the drop). The builder '
          'receives lists of accepted and rejected candidates.',
    },
    {
      'title': 'DragTargetDetails<T>',
      'subtitle': 'Data Envelope',
      'icon': Icons.mail,
      'color': Colors.amber[700]!,
      'body': 'Created when a drop is accepted. Contains the data '
          'payload and the drop offset. Passed to onAcceptWithDetails '
          'and onWillAcceptWithDetails callbacks.',
    },
    {
      'title': 'LongPressDraggable<T>',
      'subtitle': 'Alternative Producer',
      'icon': Icons.touch_app,
      'color': Colors.orange[600]!,
      'body': 'Like Draggable but requires a long press to start the '
          'drag. Prevents accidental drags. Produces the same '
          'DragTargetDetails when dropped on a compatible target.',
    },
  ];

  print('  Listed ${architectureParts.length} architecture parts');

  // ============================================================
  // SECTION 4: Callback Flow
  // ============================================================
  print('=== Section 4: Callback Flow ===');

  final callbackFlow = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Drag starts',
      'color': Colors.blue[400]!,
      'desc': 'User starts dragging a Draggable<T>. The feedback '
          'widget appears under the pointer. No DragTargetDetails '
          'object exists yet.',
    },
    {
      'step': '2',
      'title': 'Pointer enters DragTarget',
      'color': Colors.amber[400]!,
      'desc': 'When the pointer enters a DragTarget<T>, '
          'onWillAcceptWithDetails is called with a '
          'DragTargetDetails containing the data and current offset. '
          'Return true to indicate the target will accept this data.',
    },
    {
      'step': '3',
      'title': 'DragTarget rebuilds',
      'color': Colors.amber[600]!,
      'desc': 'The builder callback fires with the Draggable\'s data '
          'in the candidateData list (if accepted) or rejectedData '
          'list (if not). Use this to show visual feedback: '
          'highlight the target, change its color or border.',
    },
    {
      'step': '4',
      'title': 'Drop occurs',
      'color': Colors.green[500]!,
      'desc': 'User releases the pointer over the DragTarget. '
          'onAcceptWithDetails is called with the final '
          'DragTargetDetails (data + drop offset). This is where '
          'you process the drop: add to a list, reorder, etc.',
    },
    {
      'step': '5',
      'title': 'Cleanup',
      'color': Colors.grey[500]!,
      'desc': 'The DragTarget\'s builder fires again with empty '
          'candidate/rejected lists, removing visual highlights. '
          'The Draggable returns to its rest state (unless '
          'childWhenDragging replaces it).',
    },
  ];

  print('  Prepared ${callbackFlow.length} callback flow steps');

  // ============================================================
  // SECTION 5: Offset Coordinate System
  // ============================================================
  print('=== Section 5: Offset Coordinates ===');

  final offsetInfo = <Map<String, dynamic>>[
    {
      'title': 'Global Coordinates',
      'icon': Icons.public,
      'color': Colors.red[500]!,
      'body': 'details.offset returns screen coordinates. (0, 0) is '
          'the top-left of the screen. This is always relative to '
          'the device display, not any particular widget.',
    },
    {
      'title': 'Converting to Local',
      'icon': Icons.transform,
      'color': Colors.blue[500]!,
      'body': 'To get the position relative to the DragTarget:\n\n'
          'final box = context.findRenderObject() as RenderBox;\n'
          'final local = box.globalToLocal(details.offset);\n\n'
          'Now local.dx and local.dy are relative to the top-left '
          'of the DragTarget widget.',
    },
    {
      'title': 'Grid Cell Mapping',
      'icon': Icons.grid_on,
      'color': Colors.green[500]!,
      'body': 'With local coordinates, map to a grid cell:\n\n'
          'final col = (local.dx / cellWidth).floor();\n'
          'final row = (local.dy / cellHeight).floor();\n\n'
          'This is how chess boards, Kanban boards, and inventory '
          'systems determine where to place a dropped item.',
    },
    {
      'title': 'Feedback Offset',
      'icon': Icons.near_me,
      'color': Colors.purple[500]!,
      'body': 'The offset is the pointer position, not the center of '
          'the feedback widget. If you need the feedback widget\'s '
          'center, adjust by half the feedback\'s size. Draggable\'s '
          'feedbackOffset parameter can help align this.',
    },
  ];

  print('  Prepared ${offsetInfo.length} offset info items');

  // ============================================================
  // SECTION 6: Type Safety Patterns
  // ============================================================
  print('=== Section 6: Type Safety ===');

  final typeSafety = <Map<String, dynamic>>[
    {
      'title': 'Simple String Data',
      'icon': Icons.text_fields,
      'color': Colors.amber[700]!,
      'snippet': 'Draggable<String>(data: "task-1", ...)\n'
          'DragTarget<String>(\n'
          '  onAcceptWithDetails: (details) {\n'
          '    print(details.data); // String\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Complex Object Data',
      'icon': Icons.data_object,
      'color': Colors.brown[500]!,
      'snippet': 'class Task { String id; String title; int priority; }\n\n'
          'Draggable<Task>(data: myTask, ...)\n'
          'DragTarget<Task>(\n'
          '  onAcceptWithDetails: (details) {\n'
          '    final task = details.data; // Task\n'
          '    addToColumn(task);\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Enum Category Data',
      'icon': Icons.category,
      'color': Colors.teal[600]!,
      'snippet': 'enum Priority { high, medium, low }\n\n'
          'Draggable<Priority>(data: Priority.high, ...)\n'
          'DragTarget<Priority>(\n'
          '  onWillAcceptWithDetails: (details) {\n'
          '    return details.data != Priority.low;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Integer Index Data',
      'icon': Icons.format_list_numbered,
      'color': Colors.indigo[600]!,
      'snippet': 'Draggable<int>(data: itemIndex, ...)\n'
          'DragTarget<int>(\n'
          '  onAcceptWithDetails: (details) {\n'
          '    reorder(details.data, targetIndex);\n'
          '  },\n'
          ')',
    },
  ];

  print('  Prepared ${typeSafety.length} type safety examples');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Kanban Board',
      'icon': Icons.view_column,
      'color': Colors.blue[600]!,
      'body': 'Cards are Draggable<Task>, columns are DragTarget<Task>. '
          'When a card is dropped, onAcceptWithDetails provides the '
          'task data and the offset. The offset determines vertical '
          'position in the column for insertion order.',
    },
    {
      'title': 'File Manager',
      'icon': Icons.folder,
      'color': Colors.orange[600]!,
      'body': 'Files are Draggable<FileItem>, folders are '
          'DragTarget<FileItem>. onWillAcceptWithDetails checks '
          'if the file can go in the folder (permissions, type '
          'restrictions). onAcceptWithDetails moves the file.',
    },
    {
      'title': 'Inventory Grid',
      'icon': Icons.grid_view,
      'color': Colors.green[600]!,
      'body': 'Items are Draggable<InventoryItem>, grid cells are '
          'DragTargets. The details.offset is converted to local '
          'coordinates to compute which cell the item was dropped on. '
          'This allows precise placement in a 2D grid.',
    },
    {
      'title': 'Shopping Cart',
      'icon': Icons.shopping_bag,
      'color': Colors.red[500]!,
      'body': 'Products are Draggable<Product>, the cart area is a '
          'DragTarget<Product>. onAcceptWithDetails adds the product '
          'to the cart. The offset isn\'t needed since position '
          'within the cart doesn\'t matter — just acceptance.',
    },
    {
      'title': 'Sortable List',
      'icon': Icons.sort,
      'color': Colors.purple[600]!,
      'body': 'Each list item is both a Draggable<int> (its index) '
          'and wrapped in a DragTarget<int>. When dropped, the '
          'details provide the source index. Combined with the '
          'target index, you perform a reorder operation.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 8: Tips & Best Practices
  // ============================================================
  print('=== Section 8: Tips & Best Practices ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle_outline,
      'title': 'Always Use onAcceptWithDetails Over onAccept',
      'body': 'The older onAccept callback only provides the data, '
          'not the offset. Prefer onAcceptWithDetails, which gives '
          'you DragTargetDetails with both data and offset for '
          'complete drop information.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Type Mismatch = Silent Rejection',
      'body': 'If a Draggable<String> hovers over a '
          'DragTarget<int>, neither the onWillAcceptWithDetails '
          'nor onAcceptWithDetails will fire. The types must match. '
          'This is silent — no error is thrown.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Convert Offset in onAcceptWithDetails',
      'body': 'The offset is in global coordinates. Always convert '
          'to local if you need the position within the target. '
          'Cache the RenderBox if you do this often:\n\n'
          'final box = context.findRenderObject() as RenderBox;\n'
          'final local = box.globalToLocal(details.offset);',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Generics for Complex Payloads',
      'body': 'Rather than passing a Map or dynamic, define a proper '
          'data class for your drag payload. This gives you compile-time '
          'type checking and IDE auto-complete when accessing '
          'details.data properties.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'DragTargetDetails Is Immutable',
      'body': 'You cannot modify the data or offset on a '
          'DragTargetDetails instance. If you need modified data, '
          'read the values and create your own objects. The details '
          'are a snapshot of the drop moment.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Multi-Target Drops',
      'body': 'If DragTargets overlap, only the innermost one that '
          'accepts the data will fire. Design your layout so drop '
          'zones don\'t overlap unexpectedly — or use this behavior '
          'intentionally for nested containers.',
      'severity': 'info',
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
      title: Text('DragTargetDetails'),
      backgroundColor: Colors.amber[800],
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
                colors: [Colors.amber[800]!, Colors.brown[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.move_to_inbox, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DragTargetDetails<T>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The data envelope delivered when a Draggable is '
                  'accepted by a DragTarget. Carries the typed payload '
                  'and the global offset of the drop position.',
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
          _heading('1', 'What is DragTargetDetails?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: _accentCard(card),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _heading('2', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: prop['color'] as Color, width: 4),
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
                        Icon(prop['icon'] as IconData,
                            color: prop['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Text(prop['name'] as String,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                color: prop['color'] as Color)),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                (prop['color'] as Color).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(prop['type'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: prop['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(prop['desc'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(prop['example'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: Colors.grey[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Architecture ──
          _heading('3', 'Drag & Drop Architecture'),
          SizedBox(height: 12),
          ...architectureParts.map((part) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: part['color'] as Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(part['icon'] as IconData,
                            color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(part['title'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (part['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(part['subtitle'] as String,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: part['color'] as Color)),
                              ),
                            ]),
                            SizedBox(height: 6),
                            Text(part['body'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Callback Flow ──
          _heading('4', 'Callback Flow'),
          SizedBox(height: 12),
          ...callbackFlow.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: step['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(step['step'] as String,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(
                                color: step['color'] as Color, width: 3),
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
                            Text(step['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            SizedBox(height: 4),
                            Text(step['desc'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Offset Coordinate System ──
          _heading('5', 'Offset Coordinate System'),
          SizedBox(height: 12),
          ...offsetInfo.map((info) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: info['color'] as Color, width: 4),
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
                        Icon(info['icon'] as IconData,
                            color: info['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(info['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(info['body'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Type Safety ──
          _heading('6', 'Type Safety Patterns'),
          SizedBox(height: 12),
          ...typeSafety.map((ts) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
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
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: ts['color'] as Color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(children: [
                        Icon(ts['icon'] as IconData,
                            color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(ts['title'] as String,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ]),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      child: Text(ts['snippet'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: Colors.grey[800],
                              height: 1.5)),
                    ),
                  ]),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Real-World Patterns ──
          _heading('7', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
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
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Tips ──
          _heading('8', 'Tips & Best Practices'),
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

          // ── Footer ──
          Center(
            child: Text(
              'End of DragTargetDetails Deep Demo',
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
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.amber[800],
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
// Helper: accent card (left-border card)
// ──────────────────────────────────────────────────────────
Widget _accentCard(Map<String, dynamic> card) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(
        left: BorderSide(color: card['accent'] as Color, width: 4),
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
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
                fontSize: 13, color: Colors.grey[700], height: 1.5)),
      ],
    ),
  );
}
