// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for ScrollPositionAlignmentPolicy.
///
/// ScrollPositionAlignmentPolicy is an enum that determines how
/// ScrollPosition.ensureVisible aligns a visible object.
///
/// Values:
/// - explicit: Use the alignment parameter directly
/// - keepVisibleAtEnd: Scroll to show bottom if needed
/// - keepVisibleAtStart: Scroll to show top if needed
dynamic build(BuildContext context) {
  print('=== ScrollPositionAlignmentPolicy Test ===');
  print('');
  
  // Test all enum values
  print('ScrollPositionAlignmentPolicy Values:');
  for (final policy in ScrollPositionAlignmentPolicy.values) {
    print('  - ${policy.name}');
  }
  print('');
  
  // Explicit policy
  print('ScrollPositionAlignmentPolicy.explicit:');
  print('  Use the alignment parameter of ensureVisible directly');
  print('  alignment: 0.0 = top of viewport');
  print('  alignment: 0.5 = center of viewport');
  print('  alignment: 1.0 = bottom of viewport');
  print('');
  
  // KeepVisibleAtEnd policy
  print('ScrollPositionAlignmentPolicy.keepVisibleAtEnd:');
  print('  Find bottom edge of scroll container');
  print('  If item bottom is below container bottom:');
  print('    Scroll to show item bottom just visible');
  print('  If entire item already visible: do nothing');
  print('');
  
  // KeepVisibleAtStart policy
  print('ScrollPositionAlignmentPolicy.keepVisibleAtStart:');
  print('  Find top edge of scroll container');
  print('  If item top is above container top:');
  print('    Scroll to show item top just visible');
  print('  If entire item already visible: do nothing');
  print('');
  
  // Usage context
  print('Usage in ensureVisible:');
  print('  controller.position.ensureVisible(');
  print('    renderObject,');
  print('    alignment: 0.0,');
  print('    alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,');
  print('  );');
  print('');
  
  // Policy selection criteria
  print('Policy Selection Guide:');
  print('  explicit: Full control over alignment position');
  print('  keepVisibleAtEnd: Good for accessibility (e.g., focus navigation)');
  print('  keepVisibleAtStart: Good for keyboard navigation up');
  print('');
  
  // Duration and curve options
  print('Animation Options (with ensureVisible):');
  print('  - duration: Animation duration (default Duration.zero)');
  print('  - curve: Animation curve (default Curves.ease)');
  print('  - Can be combined with any alignment policy');
  print('');
  
  // Related APIs
  print('Related APIs:');
  print('  - ScrollPosition.ensureVisible');
  print('  - Scrollable.ensureVisible');
  print('  - RenderObject.showOnScreen');
  print('');
  
  print('Test completed.');
  return const SizedBox.shrink();
}
