// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for ScrollableDetails.
///
/// ScrollableDetails is an immutable class describing the properties of a
/// Scrollable widget. It's used by ScrollBehavior to decorate or enumerate
/// properties of scrollables, like TwoDimensionalScrollable.
///
/// Key properties:
/// - direction: AxisDirection of the scrollable
/// - controller: Optional ScrollController
/// - physics: Optional ScrollPhysics
/// - decorationClipBehavior: Clip for decorators
dynamic build(BuildContext context) {
  print('=== ScrollableDetails Test ===');
  print('');
  
  // Class details
  print('ScrollableDetails:');
  print('  Annotation: @immutable');
  print('  Package: flutter/src/widgets/scrollable_helpers.dart');
  print('  Purpose: Describe Scrollable properties');
  print('');
  
  // Default constructor
  print('Default Constructor:');
  print('  const ScrollableDetails({');
  print('    required AxisDirection direction,');
  print('    ScrollController? controller,');
  print('    ScrollPhysics? physics,');
  print('    Clip? decorationClipBehavior,');
  print('  })');
  print('');
  
  // Vertical convenience constructor
  print('ScrollableDetails.vertical:');
  print('  const ScrollableDetails.vertical({');
  print('    bool reverse = false,  // up vs down');
  print('    ScrollController? controller,');
  print('    ScrollPhysics? physics,');
  print('    Clip? decorationClipBehavior,');
  print('  })');
  print('  direction = reverse ? AxisDirection.up : AxisDirection.down');
  print('');
  
  // Horizontal convenience constructor
  print('ScrollableDetails.horizontal:');
  print('  const ScrollableDetails.horizontal({');
  print('    bool reverse = false,  // left vs right');
  print('    ScrollController? controller,');
  print('    ScrollPhysics? physics,');
  print('    Clip? decorationClipBehavior,');
  print('  })');
  print('  direction = reverse ? AxisDirection.left : AxisDirection.right');
  print('');
  
  // Direction property
  print('direction Property:');
  print('  - AxisDirection.up, down, left, right');
  print('  - Determines scroll direction and axis');
  print('  - Required parameter in main constructor');
  print('');
  
  // Decoration clip behavior
  print('decorationClipBehavior Property:');
  print('  - Used by scroll decorators like StretchingOverscrollIndicator');
  print('  - Does NOT affect Viewport.clipBehavior');
  print('  - Passed to decorators for proper clipping');
  print('');
  
  // Usage context
  print('Usage Context:');
  print('  - Used by ScrollBehavior.buildOverscrollIndicator');
  print('  - Used by ScrollBehavior.buildScrollbar');
  print('  - Enables consistent decorator configuration');
  print('');
  
  print('Test completed.');
  return const SizedBox.shrink();
}
