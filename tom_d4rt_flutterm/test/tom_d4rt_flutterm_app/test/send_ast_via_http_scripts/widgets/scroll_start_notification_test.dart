// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for ScrollStartNotification.
///
/// ScrollStartNotification is sent when a Scrollable widget has started scrolling.
/// It extends ScrollNotification and provides information about the drag start
/// if scrolling was initiated by a drag gesture.
///
/// Key properties:
/// - dragDetails: DragStartDetails if scrolling started from a drag
/// - Inherits metrics, depth, context from ScrollNotification
class FlutterWidgetPrinter {
  dynamic build(BuildContext context) {
    print('=== ScrollStartNotification Test ===');
    print('');
    
    // Notification details
    print('ScrollStartNotification:');
    print('  Extends: ScrollNotification');
    print('  Purpose: Indicates scrolling has begun');
    print('  Partner: ScrollEndNotification');
    print('');
    
    // Constructor parameters
    print('Constructor:');
    print('  ScrollStartNotification({');
    print('    required ScrollMetrics metrics,');
    print('    required BuildContext context,');
    print('    DragStartDetails? dragDetails,');
    print('  })');
    print('');
    
    // DragStartDetails
    print('DragStartDetails Property:');
    print('  - Non-null when scroll started from user drag');
    print('  - Contains globalPosition, localPosition');
    print('  - Contains sourceTimeStamp');
    print('  - Null for programmatic scrolling');
    print('');
    
    // Inherited properties
    print('Inherited from ScrollNotification:');
    print('  - metrics: ScrollMetrics snapshot');
    print('  - context: BuildContext that dispatched');
    print('  - depth: Notification nesting depth');
    print('');
    
    // Notification lifecycle
    print('Scroll Notification Lifecycle:');
    print('  1. ScrollStartNotification (scrolling begins)');
    print('  2. ScrollUpdateNotification (position changes)');
    print('  3. ScrollEndNotification (scrolling ends)');
    print('  OR: OverscrollNotification (overscroll occurs)');
    print('');
    
    // Listening to notifications
    print('Listening to ScrollStartNotification:');
    print('  NotificationListener<ScrollStartNotification>(');
    print('    onNotification: (notification) {');
    print('      // Handle scroll start');
    print('      return false; // Allow bubbling');
    print('    },');
    print('    child: scrollableWidget,');
    print('  )');
    print('');
    
    // Use cases
    print('Use Cases:');
    print('  - Track when user begins scrolling');
    print('  - Pause animations during scroll');
    print('  - Log scroll interaction analytics');
    print('  - Trigger UI state changes (e.g., hide FAB)');
    print('');
    
    // Related notifications
    print('Related Notifications:');
    print('  - ScrollEndNotification: Scrolling ended');
    print('  - ScrollUpdateNotification: Position changed');
    print('  - OverscrollNotification: Exceeded bounds');
    print('  - UserScrollNotification: Direction changed');
    print('');
    
    print('Test completed.');
    return const SizedBox.shrink();
  }
}
