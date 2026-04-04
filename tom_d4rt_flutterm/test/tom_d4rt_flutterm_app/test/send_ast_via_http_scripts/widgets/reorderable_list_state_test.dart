// Generated print-only test for ReorderableListState
// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/widgets.dart';

/// Print-only test for ReorderableListState
/// This test prints class structure and API information.
dynamic build(BuildContext context) {
print('=' * 50);
print('ReorderableListState PRINT-ONLY TEST');
print('=' * 50);

// Class definition
print('\n--- ReorderableListState class ---');
print('class ReorderableListState extends State<ReorderableList>');
print('Purpose: State for drag-reorderable list');

// Internal key
print('\n--- Internal state ---');
print('_sliverReorderableListKey: GlobalKey<SliverReorderableListState>');
print('Delegates to SliverReorderableList');

// startItemDragReorder method
print('\n--- startItemDragReorder() ---');
print('void startItemDragReorder({');
print('  required int index,');
print('  required PointerDownEvent event,');
print('  required MultiDragGestureRecognizer recognizer,');
print('})');
print('Initiates drag reorder for item');
print('Takes ownership of recognizer');

// cancelReorder method
print('\n--- cancelReorder() ---');
print('void cancelReorder()');
print('Cancels any active drag');
print('Call before major list changes');
print('Safe to call when no drag active');

// build method
print('\n--- build() implementation ---');
print('Returns CustomScrollView with:');
print('  - scrollDirection from widget');
print('  - reverse from widget');
print('  - controller from widget');
print('  - SliverPadding with padding');
print('  - SliverReorderableList (key: _sliverKey)');

// Accessing state
print('\n--- Accessing state ---');
print('Use GlobalKey<ReorderableListState>');
print('listKey.currentState!.startItemDragReorder(...)');
print('listKey.currentState!.cancelReorder()');

// Drag start widgets
print('\n--- Drag start helpers ---');
print('ReorderableDragStartListener');
print('ReorderableDelayedDragStartListener');
print('These call startItemDragReorder');

// Integration
print('\n--- SliverReorderableList integration ---');
print('Delegates all reorder logic');
print('State tracks via GlobalKey');
print('Properties passed through');


// Drag callbacks
print('\n--- Widget callbacks ---');
print('onReorder: (oldIndex, newIndex) {}');
print('onReorderStart: (index) {}');
print('onReorderEnd: (index) {}');

// Proxy decorator
print('\n--- Proxy decorator ---');
print('Widget proxyDecorator(child, index, animation)');
print('Customize dragged item appearance');

print('\n' + '=' * 50);
print('END ReorderableListState PRINT-ONLY TEST');
print('=' * 50);
return const SizedBox.shrink();
}
