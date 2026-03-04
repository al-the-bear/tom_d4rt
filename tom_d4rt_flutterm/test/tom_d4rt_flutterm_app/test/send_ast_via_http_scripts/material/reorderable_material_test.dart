// D4rt test script: Tests ReorderableListView, ReorderableDragStartListener,
// SliverReorderableList, InkWell advanced, InkResponse, InkHighlight, Material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Reorderable and material ink test executing');

  // ========== ReorderableListView ==========
  print('--- ReorderableListView Tests ---');
  final items = List.generate(10, (index) => 'Item $index');

  final reorderableList = ReorderableListView(
    onReorder: (oldIndex, newIndex) {
      print('  Reorder: $oldIndex -> $newIndex');
    },
    proxyDecorator: (child, index, animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Material(
          elevation: 4,
          child: child,
        ),
        child: child,
      );
    },
    header: Container(
      padding: EdgeInsets.all(16),
      child: Text('Reorderable Header'),
    ),
    footer: Container(
      padding: EdgeInsets.all(16),
      child: Text('Reorderable Footer'),
    ),
    padding: EdgeInsets.all(8),
    scrollDirection: Axis.vertical,
    reverse: false,
    children: items.map((item) => ListTile(
      key: ValueKey(item),
      title: Text(item),
      leading: Icon(Icons.drag_handle),
    )).toList(),
  );
  print('ReorderableListView created');

  // ========== ReorderableListView.builder ==========
  print('--- ReorderableListView.builder Tests ---');
  final reorderableBuilder = ReorderableListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(
      key: ValueKey(items[index]),
      title: Text(items[index]),
    ),
    onReorder: (oldIndex, newIndex) {
      print('  Builder reorder: $oldIndex -> $newIndex');
    },
    buildDefaultDragHandles: true,
  );
  print('ReorderableListView.builder created');

  // ========== ReorderableDragStartListener ==========
  print('--- ReorderableDragStartListener Tests ---');
  final dragListener = ReorderableDragStartListener(
    index: 0,
    child: Icon(Icons.drag_indicator),
    enabled: true,
  );
  print('ReorderableDragStartListener created: index=0');

  final delayedListener = ReorderableDelayedDragStartListener(
    index: 1,
    child: Icon(Icons.drag_indicator),
    enabled: true,
  );
  print('ReorderableDelayedDragStartListener created: index=1');

  // ========== InkWell advanced ==========
  print('--- InkWell Advanced Tests ---');
  final inkWell = InkWell(
    onTap: () => print('  Tapped'),
    onDoubleTap: () => print('  Double tapped'),
    onLongPress: () => print('  Long pressed'),
    onTapDown: (details) => print('  Tap down'),
    onTapUp: (details) => print('  Tap up'),
    onTapCancel: () => print('  Tap cancel'),
    onHighlightChanged: (highlight) => print('  Highlight: $highlight'),
    onHover: (hover) => print('  Hover: $hover'),
    onFocusChange: (focus) => print('  Focus: $focus'),
    splashColor: Colors.blue[200],
    highlightColor: Colors.blue[100],
    hoverColor: Colors.blue[50],
    focusColor: Colors.blue[300],
    overlayColor: WidgetStateProperty.all(Colors.blue[100]),
    borderRadius: BorderRadius.circular(8),
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enableFeedback: true,
    excludeFromSemantics: false,
    canRequestFocus: true,
    autofocus: false,
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text('Ink Well'),
    ),
  );
  print('InkWell advanced created');

  // ========== InkResponse ==========
  print('--- InkResponse Tests ---');
  final inkResponse = InkResponse(
    onTap: () => print('  Response tapped'),
    onLongPress: () => print('  Response long pressed'),
    splashColor: Colors.red[200],
    highlightColor: Colors.red[100],
    hoverColor: Colors.red[50],
    highlightShape: BoxShape.circle,
    radius: 24.0,
    containedInkWell: false,
    child: Container(
      width: 48,
      height: 48,
      child: Icon(Icons.circle),
    ),
  );
  print('InkResponse created');

  // ========== Material widget ==========
  print('--- Material Widget Tests ---');
  final materialWidget = Material(
    type: MaterialType.card,
    elevation: 4.0,
    color: Colors.white,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    borderRadius: BorderRadius.circular(12),
    borderOnForeground: true,
    clipBehavior: Clip.antiAlias,
    animationDuration: Duration(milliseconds: 300),
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text('Material Widget'),
    ),
  );
  print('Material widget created: type=${MaterialType.card}');

  // ========== MaterialType enum ==========
  print('--- MaterialType Tests ---');
  for (final t in MaterialType.values) {
    print('  MaterialType.$t');
  }

  print('All reorderable/material ink tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 300, child: reorderableList),
            SizedBox(height: 16),
            dragListener,
            inkWell,
            inkResponse,
            materialWidget,
          ],
        ),
      ),
    ),
  );
}
