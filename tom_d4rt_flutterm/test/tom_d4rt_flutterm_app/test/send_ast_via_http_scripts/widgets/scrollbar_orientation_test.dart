// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for ScrollbarOrientation.
///
/// ScrollbarOrientation is an enum specifying where a scrollbar should be
/// positioned relative to the scrollable content.
///
/// Values:
/// - left: Place on left side
/// - right: Place on right side
/// - top: Place at top
/// - bottom: Place at bottom
class FlutterWidgetPrinter {
  dynamic build(BuildContext context) {
    print('=== ScrollbarOrientation Test ===');
    print('');
    
    // Enum details
    print('ScrollbarOrientation:');
    print('  Type: enum');
    print('  Package: flutter/src/widgets/scrollbar.dart');
    print('  Purpose: Position scrollbar relative to content');
    print('');
    
    // All values
    print('Enum Values:');
    for (final orientation in ScrollbarOrientation.values) {
      print('  - ${orientation.name}');
    }
    print('');
    
    // Left orientation
    print('ScrollbarOrientation.left:');
    print('  - Place scrollbar towards left of screen');
    print('  - Common for RTL layouts');
    print('  - Horizontal scrollbar on left edge');
    print('');
    
    // Right orientation
    print('ScrollbarOrientation.right:');
    print('  - Place scrollbar towards right of screen');
    print('  - Default for LTR vertical scrolling');
    print('  - Most common scrollbar position');
    print('');
    
    // Top orientation
    print('ScrollbarOrientation.top:');
    print('  - Place scrollbar at top of screen');
    print('  - Used for horizontal scrollables');
    print('  - Less common configuration');
    print('');
    
    // Bottom orientation
    print('ScrollbarOrientation.bottom:');
    print('  - Place scrollbar at bottom of screen');
    print('  - Used for horizontal scrollables');
    print('  - Common for horizontal lists');
    print('');
    
    // Usage with RawScrollbar
    print('Usage with RawScrollbar:');
    print('  RawScrollbar(');
    print('    scrollbarOrientation: ScrollbarOrientation.left,');
    print('    controller: scrollController,');
    print('    child: ListView(...),');
    print('  )');
    print('');
    
    // Automatic orientation
    print('Automatic Orientation:');
    print('  - When unset, determined by scroll direction');
    print('  - Vertical scroll: left or right');
    print('  - Horizontal scroll: top or bottom');
    print('  - RTL/LTR affects default side');
    print('');
    
    // Related classes
    print('Related Classes:');
    print('  - RawScrollbar: Base scrollbar widget');
    print('  - Scrollbar: Material scrollbar');
    print('  - CupertinoScrollbar: iOS-style scrollbar');
    print('  - ScrollbarPainter: Paints scrollbar track/thumb');
    print('');
    
    print('Test completed.');
    return const SizedBox.shrink();
  }
}
