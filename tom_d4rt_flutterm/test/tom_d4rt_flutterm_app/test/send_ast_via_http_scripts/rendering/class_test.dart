// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: Flutter rendering package classes
// Covers RenderObject, RenderBox, Constraints, ParentData and related concepts

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

// =============================================================================
// SECTION 1: Size - Fundamental 2D Dimensions
// =============================================================================

void sizeBasicsDemo() {
  // Size represents width and height dimensions
  var size1 = Size(100.0, 200.0);
  print('Size basics:');
  print('  Width: ${size1.width}');
  print('  Height: ${size1.height}');
  print('  Aspect ratio: ${size1.aspectRatio}');
  
  // Size creation methods
  var squareSize = Size.square(50.0);
  print('  Square size: $squareSize');
  
  var fromRadius = Size.fromRadius(25.0);
  print('  From radius 25: $fromRadius');
  
  var fromWidth = Size.fromWidth(100.0);
  print('  From width (infinite height): $fromWidth');
  
  var fromHeight = Size.fromHeight(100.0);
  print('  From height (infinite width): $fromHeight');
  
  // Size special values
  var zeroSize = Size.zero;
  var infiniteSize = Size.infinite;
  print('  Zero size: $zeroSize');
  print('  Infinite size: $infiniteSize');
}

void sizeOperationsDemo() {
  var size1 = Size(100.0, 200.0);
  var size2 = Size(50.0, 75.0);
  
  print('Size operations:');
  
  // Arithmetic with offsets
  var offset = Offset(10.0, 20.0);
  var addedOffset = size1 + offset;
  print('  Size + Offset: $addedOffset');
  
  var subtractedOffset = size1 - offset;
  print('  Size - Offset: $subtractedOffset');
  
  // Multiplication and division
  var scaled = size1 * 2.0;
  print('  Size * 2: $scaled');
  
  var divided = size1 / 2.0;
  print('  Size / 2: $divided');
  
  var intDivided = size1 ~/ 2;
  print('  Size ~/ 2: $intDivided');
  
  var modulo = size1 % 30.0;
  print('  Size % 30: $modulo');
  
  // Avoid unused variable warning
  print('  size2 for reference: $size2');
}

void sizeGeometryDemo() {
  var size = Size(100.0, 200.0);
  
  print('Size geometry:');
  
  // Center and other points
  var center = size.center(Offset.zero);
  print('  Center at origin: $center');
  
  var centerOffset = size.center(Offset(50.0, 50.0));
  print('  Center at (50,50): $centerOffset');
  
  var topLeft = size.topLeft(Offset.zero);
  var topCenter = size.topCenter(Offset.zero);
  var topRight = size.topRight(Offset.zero);
  print('  Top left: $topLeft');
  print('  Top center: $topCenter');
  print('  Top right: $topRight');
  
  var centerLeft = size.centerLeft(Offset.zero);
  var centerRight = size.centerRight(Offset.zero);
  print('  Center left: $centerLeft');
  print('  Center right: $centerRight');
  
  var bottomLeft = size.bottomLeft(Offset.zero);
  var bottomCenter = size.bottomCenter(Offset.zero);
  var bottomRight = size.bottomRight(Offset.zero);
  print('  Bottom left: $bottomLeft');
  print('  Bottom center: $bottomCenter');
  print('  Bottom right: $bottomRight');
  
  // Containment check
  var containsOffset = size.contains(Offset(50.0, 100.0));
  var notContained = size.contains(Offset(150.0, 100.0));
  print('  Contains (50,100): $containsOffset');
  print('  Contains (150,100): $notContained');
  
  // Shortest and longest side
  print('  Shortest side: ${size.shortestSide}');
  print('  Longest side: ${size.longestSide}');
  
  // Flipped dimensions
  var flipped = size.flipped;
  print('  Flipped: $flipped');
}

void sizeValidityDemo() {
  print('Size validity checks:');
  
  var validSize = Size(100.0, 200.0);
  var zeroSize = Size.zero;
  var infiniteSize = Size.infinite;
  var negativeSize = Size(-10.0, 20.0);
  var nanSize = Size(double.nan, 100.0);
  
  print('  Valid size isEmpty: ${validSize.isEmpty}');
  print('  Zero size isEmpty: ${zeroSize.isEmpty}');
  print('  Infinite size isEmpty: ${infiniteSize.isEmpty}');
  
  print('  Valid size isFinite: ${validSize.isFinite}');
  print('  Infinite size isFinite: ${infiniteSize.isFinite}');
  
  print('  Valid size isInfinite: ${validSize.isInfinite}');
  print('  Infinite size isInfinite: ${infiniteSize.isInfinite}');
  
  // Use variables to avoid warnings
  print('  Negative size width: ${negativeSize.width}');
  print('  NaN size width isNaN: ${nanSize.width.isNaN}');
}

// =============================================================================
// SECTION 2: Offset - 2D Position/Vector
// =============================================================================

void offsetBasicsDemo() {
  print('Offset basics:');
  
  var offset1 = Offset(100.0, 200.0);
  print('  dx: ${offset1.dx}');
  print('  dy: ${offset1.dy}');
  
  // Special offsets
  var zero = Offset.zero;
  var infinite = Offset.infinite;
  print('  Zero offset: $zero');
  print('  Infinite offset: $infinite');
  
  // From direction (angle in radians)
  var fromDirection = Offset.fromDirection(0.785398); // ~45 degrees
  print('  From direction (45°): $fromDirection');
  
  var withMagnitude = Offset.fromDirection(0.785398, 100.0);
  print('  From direction with magnitude: $withMagnitude');
}

void offsetOperationsDemo() {
  var offset1 = Offset(100.0, 200.0);
  var offset2 = Offset(50.0, 75.0);
  
  print('Offset operations:');
  
  // Addition and subtraction
  var sum = offset1 + offset2;
  print('  offset1 + offset2: $sum');
  
  var diff = offset1 - offset2;
  print('  offset1 - offset2: $diff');
  
  // Negation
  var negated = -offset1;
  print('  Negated: $negated');
  
  // Scaling
  var scaled = offset1 * 2.0;
  print('  Scaled by 2: $scaled');
  
  var divided = offset1 / 2.0;
  print('  Divided by 2: $divided');
  
  var modulo = offset1 % 30.0;
  print('  Modulo 30: $modulo');
}

void offsetGeometryDemo() {
  var offset = Offset(30.0, 40.0);
  
  print('Offset geometry:');
  
  // Distance from origin
  print('  Distance: ${offset.distance}');
  print('  Distance squared: ${offset.distanceSquared}');
  
  // Direction (angle in radians)
  print('  Direction: ${offset.direction}');
  
  // Translate
  var translated = offset.translate(10.0, 20.0);
  print('  Translated by (10,20): $translated');
  
  // Scale independently
  var independentlyScaled = offset.scale(2.0, 0.5);
  print('  Scaled x*2, y*0.5: $independentlyScaled');
}

void offsetComparisonDemo() {
  var offset1 = Offset(100.0, 200.0);
  var offset2 = Offset(100.0, 200.0);
  var offset3 = Offset(150.0, 250.0);
  
  print('Offset comparison:');
  print('  offset1 == offset2: ${offset1 == offset2}');
  print('  offset1 == offset3: ${offset1 == offset3}');
  
  // Comparison operators (lexicographic)
  print('  offset1 < offset3: ${offset1 < offset3}');
  print('  offset1 <= offset2: ${offset1 <= offset2}');
  print('  offset3 > offset1: ${offset3 > offset1}');
  
  // Validity checks
  print('  offset1 isFinite: ${offset1.isFinite}');
  print('  offset1 isInfinite: ${offset1.isInfinite}');
}

// =============================================================================
// SECTION 3: BoxConstraints - Layout Constraints for RenderBox
// =============================================================================

void boxConstraintsBasicsDemo() {
  print('BoxConstraints basics:');
  
  // Standard constructor
  var constraints1 = BoxConstraints(
    minWidth: 0.0,
    maxWidth: 200.0,
    minHeight: 0.0,
    maxHeight: 300.0,
  );
  print('  Constraints: $constraints1');
  print('  minWidth: ${constraints1.minWidth}');
  print('  maxWidth: ${constraints1.maxWidth}');
  print('  minHeight: ${constraints1.minHeight}');
  print('  maxHeight: ${constraints1.maxHeight}');
  
  // Tight constraints (exact size)
  var tight = BoxConstraints.tight(Size(100.0, 150.0));
  print('  Tight constraints: $tight');
  print('  isTight: ${tight.isTight}');
  
  // Loose constraints (from zero to max)
  var loose = BoxConstraints.loose(Size(200.0, 300.0));
  print('  Loose constraints: $loose');
  
  // Expand (fill available space)
  var expand = BoxConstraints.expand();
  print('  Expand constraints: $expand');
  
  var expandPartial = BoxConstraints.expand(width: 100.0);
  print('  Expand with fixed width: $expandPartial');
}

void boxConstraintsTightDemo() {
  print('Tight constraints variations:');
  
  var tightWidth = BoxConstraints.tightFor(width: 100.0);
  print('  Tight for width only: $tightWidth');
  
  var tightHeight = BoxConstraints.tightFor(height: 150.0);
  print('  Tight for height only: $tightHeight');
  
  var tightBoth = BoxConstraints.tightFor(width: 100.0, height: 150.0);
  print('  Tight for both: $tightBoth');
  
  var tightFinite = BoxConstraints.tightForFinite(width: 100.0);
  print('  Tight for finite: $tightFinite');
}

void boxConstraintsQueriesDemo() {
  var constraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 75.0,
    maxHeight: 300.0,
  );
  
  print('BoxConstraints queries:');
  print('  hasBoundedWidth: ${constraints.hasBoundedWidth}');
  print('  hasBoundedHeight: ${constraints.hasBoundedHeight}');
  print('  hasInfiniteWidth: ${constraints.hasInfiniteWidth}');
  print('  hasInfiniteHeight: ${constraints.hasInfiniteHeight}');
  print('  isTight: ${constraints.isTight}');
  print('  isNormalized: ${constraints.isNormalized}');
  
  // Biggest and smallest possible sizes
  print('  biggest: ${constraints.biggest}');
  print('  smallest: ${constraints.smallest}');
  
  // Constrain a size
  var unconstrainedSize = Size(500.0, 400.0);
  var constrainedSize = constraints.constrain(unconstrainedSize);
  print('  Constrain $unconstrainedSize: $constrainedSize');
  
  var smallSize = Size(10.0, 20.0);
  var constrainedSmall = constraints.constrain(smallSize);
  print('  Constrain $smallSize: $constrainedSmall');
}

void boxConstraintsTransformationsDemo() {
  var constraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 75.0,
    maxHeight: 300.0,
  );
  
  print('BoxConstraints transformations:');
  
  // Loosen (set min to 0)
  var loosened = constraints.loosen();
  print('  Loosened: $loosened');
  
  // Tighten to specific dims
  var tightened = constraints.tighten(width: 100.0);
  print('  Tightened width to 100: $tightened');
  
  // Enforce constraints range
  var enforced = constraints.enforce(BoxConstraints(
    minWidth: 75.0,
    maxWidth: 150.0,
    minHeight: 100.0,
    maxHeight: 250.0,
  ));
  print('  Enforced more restrictive: $enforced');
  
  // Width/height constraints only
  var widthOnly = constraints.widthConstraints();
  print('  Width constraints only: $widthOnly');
  
  var heightOnly = constraints.heightConstraints();
  print('  Height constraints only: $heightOnly');
  
  // Flipped
  var flipped = constraints.flipped;
  print('  Flipped: $flipped');
  
  // Deflate (subtract insets)
  var deflated = constraints.deflate(EdgeInsets.all(10.0));
  print('  Deflated by 10 all sides: $deflated');
}

void boxConstraintsConstrainDemo() {
  var constraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 75.0,
    maxHeight: 300.0,
  );
  
  print('BoxConstraints constraining:');
  
  // Constrain width
  print('  constrainWidth(25): ${constraints.constrainWidth(25.0)}');
  print('  constrainWidth(100): ${constraints.constrainWidth(100.0)}');
  print('  constrainWidth(500): ${constraints.constrainWidth(500.0)}');
  
  // Constrain height
  print('  constrainHeight(50): ${constraints.constrainHeight(50.0)}');
  print('  constrainHeight(150): ${constraints.constrainHeight(150.0)}');
  print('  constrainHeight(500): ${constraints.constrainHeight(500.0)}');
  
  // Constrain to another set of constraints
  var size = Size(100.0, 150.0);
  var sizeInRange = constraints.constrainSizeAndAttemptToPreserveAspectRatio(size);
  print('  Constrain and preserve aspect: $sizeInRange');
}

// =============================================================================
// SECTION 4: Constraints - Abstract Base Class
// =============================================================================

void constraintsConceptDemo() {
  print('Constraints concept:');
  print('  Constraints is the abstract base class');
  print('  BoxConstraints extends Constraints');
  print('  SliverConstraints extends Constraints');
  
  // BoxConstraints as Constraints
  Constraints boxAsConstraints = BoxConstraints(
    minWidth: 0.0,
    maxWidth: 100.0,
    minHeight: 0.0,
    maxHeight: 100.0,
  );
  
  print('  BoxConstraints isTight: ${boxAsConstraints.isTight}');
  print('  BoxConstraints isNormalized: ${boxAsConstraints.isNormalized}');
}

// =============================================================================
// SECTION 5: RenderObject and RenderBox Hierarchy
// =============================================================================

void renderObjectHierarchyDemo() {
  print('RenderObject hierarchy:');
  print('  AbstractNode (base)');
  print('    └── RenderObject');
  print('          ├── RenderBox (2D layout)');
  print('          │     ├── RenderProxyBox');
  print('          │     ├── RenderShiftedBox');
  print('          │     ├── RenderDecoratedBox');
  print('          │     └── RenderFlex');
  print('          └── RenderSliver (sliver layout)');
  print('                ├── RenderSliverList');
  print('                └── RenderSliverGrid');
}

void renderBoxBasicsDemo() {
  print('RenderBox basics:');
  print('  RenderBox uses BoxConstraints');
  print('  RenderBox has a Size after layout');
  print('  RenderBox uses Offset for positioning');
  print('');
  print('  Key properties:');
  print('    - size: Size after layout');
  print('    - constraints: BoxConstraints during layout');
  print('    - parentData: Data stored by parent');
  print('');
  print('  Key methods:');
  print('    - performLayout(): Calculate size');
  print('    - paint(context, offset): Draw content');
  print('    - hitTest(result, position): Handle touches');
}

// =============================================================================
// SECTION 6: Layout Process Demonstration
// =============================================================================

void layoutProcessConceptsDemo() {
  print('Layout process concepts:');
  print('');
  print('  1. Constraints go DOWN the tree');
  print('     Parent tells child: "You can be between X and Y"');
  print('');
  print('  2. Sizes go UP the tree');
  print('     Child tells parent: "I am this size"');
  print('');
  print('  3. Parent positions children');
  print('     Parent sets child.parentData.offset');
  print('');
  print('  Layout phases:');
  print('    a) layout() called with constraints');
  print('    b) performLayout() calculates size');
  print('    c) size is set');
  print('    d) Parent reads child.size');
  print('    e) Parent sets child position via parentData');
}

void constraintsFlowDemo() {
  print('Constraints flow example:');
  print('');
  print('  Screen: 400x800');
  print('    └── Container (expand)');
  print('          Receives: tight(400x800)');
  print('          └── Padding (all: 20)');
  print('                Receives: tight(360x760)');
  print('                └── Center');
  print('                      Receives: loose(360x760)');
  print('                      └── Box(100x50)');
  print('                            Receives: loose(360x760)');
  print('                            Returns: 100x50');
  
  // Demonstrate with actual constraints
  var screenConstraints = BoxConstraints.tight(Size(400.0, 800.0));
  print('');
  print('  Actual constraint values:');
  print('    Screen constraints: $screenConstraints');
  
  var paddedConstraints = screenConstraints.deflate(EdgeInsets.all(20.0));
  print('    After padding: $paddedConstraints');
  
  var looseConstraints = paddedConstraints.loosen();
  print('    After Center (loosened): $looseConstraints');
  
  var childSize = Size(100.0, 50.0);
  var constrainedChild = looseConstraints.constrain(childSize);
  print('    Child constrained size: $constrainedChild');
}

// =============================================================================
// SECTION 7: Paint Process Demonstration
// =============================================================================

void paintProcessConceptsDemo() {
  print('Paint process concepts:');
  print('');
  print('  Paint happens AFTER layout');
  print('  paint(PaintingContext context, Offset offset)');
  print('');
  print('  Key aspects:');
  print('    - offset: Position relative to parent');
  print('    - context.canvas: Drawing surface');
  print('    - context.paintChild(): Paint child with offset');
  print('');
  print('  Paint order:');
  print('    1. Paint self (background)');
  print('    2. Paint children');
  print('    3. Paint self (foreground)');
}

void paintingContextDemo() {
  print('PaintingContext operations:');
  print('');
  print('  Drawing operations:');
  print('    - canvas.drawRect()');
  print('    - canvas.drawCircle()');
  print('    - canvas.drawPath()');
  print('    - canvas.drawImage()');
  print('');
  print('  Child painting:');
  print('    - paintChild(child, offset)');
  print('');
  print('  Layers for effects:');
  print('    - pushOpacity(offset, opacity, painter)');
  print('    - pushClipRect(bounds, clipBehavior, painter)');
  print('    - pushTransform(transform, painter)');
}

void canvasOperationsDemo() {
  print('Canvas operations reference:');
  print('');
  print('  Shapes:');
  print('    - drawLine(p1, p2, paint)');
  print('    - drawRect(rect, paint)');
  print('    - drawRRect(rrect, paint)');
  print('    - drawOval(rect, paint)');
  print('    - drawCircle(center, radius, paint)');
  print('    - drawArc(rect, startAngle, sweepAngle, useCenter, paint)');
  print('    - drawPath(path, paint)');
  print('');
  print('  Images:');
  print('    - drawImage(image, offset, paint)');
  print('    - drawImageRect(image, src, dst, paint)');
  print('');
  print('  Text and paragraphs:');
  print('    - drawParagraph(paragraph, offset)');
}

// =============================================================================
// SECTION 8: Hit Testing Basics
// =============================================================================

void hitTestingConceptsDemo() {
  print('Hit testing concepts:');
  print('');
  print('  Purpose: Determine which render objects are at a point');
  print('  Used for: Touch/click handling, gesture recognition');
  print('');
  print('  hitTest(BoxHitTestResult result, Offset position)');
  print('    Returns: bool (whether this or children were hit)');
  print('');
  print('  Process:');
  print('    1. Check if position is within bounds');
  print('    2. Hit test children (back to front)');
  print('    3. Add self to result if needed');
}

void hitTestResultDemo() {
  print('HitTestResult structure:');
  print('');
  print('  BoxHitTestResult contains HitTestEntry objects');
  print('  Each entry has:');
  print('    - target: The RenderObject that was hit');
  print('    - transform: Matrix to convert to local coords');
  print('');
  print('  Result is a path from leaf to root');
  print('  Events bubble up through this path');
  
  // Create a result
  var result = BoxHitTestResult();
  print('');
  print('  Empty hit test result path length: ${result.path.length}');
}

void hitTestBoundsDemo() {
  print('Hit test bounds checking:');
  print('');
  print('  For RenderBox:');
  print('    - Check if position.dx >= 0 && position.dx < size.width');
  print('    - Check if position.dy >= 0 && position.dy < size.height');
  print('');
  
  var size = Size(100.0, 200.0);
  var insidePoint = Offset(50.0, 100.0);
  var outsidePoint = Offset(150.0, 100.0);
  var edgePoint = Offset(100.0, 0.0);
  
  bool isInside(Offset point, Size bounds) {
    return point.dx >= 0.0 &&
           point.dx < bounds.width &&
           point.dy >= 0.0 &&
           point.dy < bounds.height;
  }
  
  print('  Box size: $size');
  print('  Inside point $insidePoint: ${isInside(insidePoint, size)}');
  print('  Outside point $outsidePoint: ${isInside(outsidePoint, size)}');
  print('  Edge point $edgePoint: ${isInside(edgePoint, size)}');
}

void hitTestTransformsDemo() {
  print('Hit test coordinate transforms:');
  print('');
  print('  When child has offset from parent:');
  print('    childLocalPosition = position - childOffset');
  print('');
  print('  When child has transform (rotation, scale):');
  print('    childLocalPosition = transform.inverse * position');
  print('');
  
  var parentPosition = Offset(150.0, 200.0);
  var childOffset = Offset(50.0, 75.0);
  var childLocalPosition = parentPosition - childOffset;
  
  print('  Example:');
  print('    Parent position: $parentPosition');
  print('    Child offset: $childOffset');
  print('    Child local position: $childLocalPosition');
}

// =============================================================================
// SECTION 9: ParentData Concepts
// =============================================================================

void parentDataConceptsDemo() {
  print('ParentData concepts:');
  print('');
  print('  ParentData is stored on child, managed by parent');
  print('  Contains layout info specific to parent type');
  print('');
  print('  Common ParentData types:');
  print('    - BoxParentData: Has offset field');
  print('    - ContainerBoxParentData: Has previous/next siblings');
  print('    - FlexParentData: Has flex, fit fields');
  print('    - StackParentData: Has top/left/right/bottom');
}

void boxParentDataDemo() {
  print('BoxParentData usage:');
  print('');
  print('  class BoxParentData extends ParentData {');
  print('    Offset offset = Offset.zero;');
  print('  }');
  print('');
  print('  Parent sets child position:');
  print('    child.parentData.offset = Offset(10, 20);');
  print('');
  print('  During paint:');
  print('    context.paintChild(child, child.parentData.offset);');
  
  var parentData = BoxParentData();
  print('');
  print('  Default offset: ${parentData.offset}');
  
  parentData.offset = Offset(100.0, 50.0);
  print('  After setting offset: ${parentData.offset}');
}

void flexParentDataDemo() {
  print('FlexParentData for Row/Column:');
  print('');
  print('  class FlexParentData extends BoxParentData {');
  print('    int? flex;');
  print('    FlexFit fit = FlexFit.tight;');
  print('  }');
  print('');
  print('  flex: How much of remaining space to take');
  print('  fit: Whether to fill (tight) or just take needed (loose)');
  
  var flexData = FlexParentData();
  print('');
  print('  Default flex: ${flexData.flex}');
  print('  Default fit: ${flexData.fit}');
  
  flexData.flex = 2;
  flexData.fit = FlexFit.loose;
  print('  After modification:');
  print('    flex: ${flexData.flex}');
  print('    fit: ${flexData.fit}');
}

// =============================================================================
// SECTION 10: RenderObject Lifecycle
// =============================================================================

void renderObjectLifecycleDemo() {
  print('RenderObject lifecycle:');
  print('');
  print('  Creation and attachment:');
  print('    1. Constructor called');
  print('    2. attach(owner) - Connect to render tree');
  print('    3. adoptChild() - Child added');
  print('');
  print('  Layout phase:');
  print('    4. markNeedsLayout() - Schedule layout');
  print('    5. layout(constraints) - Perform layout');
  print('    6. performLayout() - Calculate size');
  print('');
  print('  Paint phase:');
  print('    7. markNeedsPaint() - Schedule paint');
  print('    8. paint(context, offset) - Draw content');
  print('');
  print('  Removal:');
  print('    9. dropChild() - Child removed');
  print('    10. detach() - Disconnect from render tree');
}

void renderObjectFlagsDemo() {
  print('RenderObject dirty flags:');
  print('');
  print('  needsLayout: Layout needs to be recalculated');
  print('    - Set by markNeedsLayout()');
  print('    - Cleared after performLayout()');
  print('');
  print('  needsPaint: Paint needs to be redone');
  print('    - Set by markNeedsPaint()');
  print('    - Cleared after paint()');
  print('');
  print('  needsCompositing: Layer tree needs update');
  print('    - Set when isRepaintBoundary changes');
  print('    - Affects layer creation');
}

void repaintBoundaryDemo() {
  print('RepaintBoundary concept:');
  print('');
  print('  isRepaintBoundary = true:');
  print('    - Creates own compositing layer');
  print('    - Repaints independently of ancestors');
  print('    - Good for frequently updating content');
  print('');
  print('  Use cases:');
  print('    - Animations');
  print('    - Scrolling content');
  print('    - Expensive painting operations');
  print('');
  print('  Trade-offs:');
  print('    - Extra memory for layer');
  print('    - More compositing work');
  print('    - But faster incremental repaints');
}

// =============================================================================
// SECTION 11: Rect and EdgeInsets
// =============================================================================

void rectDemo() {
  print('Rect (rectangle) basics:');
  
  // Creation methods
  var fromLTWH = Rect.fromLTWH(10.0, 20.0, 100.0, 50.0);
  print('  fromLTWH(10, 20, 100, 50): $fromLTWH');
  
  var fromLTRB = Rect.fromLTRB(10.0, 20.0, 110.0, 70.0);
  print('  fromLTRB(10, 20, 110, 70): $fromLTRB');
  
  var fromCenter = Rect.fromCenter(
    center: Offset(50.0, 50.0),
    width: 100.0,
    height: 60.0,
  );
  print('  fromCenter: $fromCenter');
  
  var fromCircle = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 25.0);
  print('  fromCircle: $fromCircle');
  
  var fromPoints = Rect.fromPoints(Offset(10.0, 20.0), Offset(110.0, 70.0));
  print('  fromPoints: $fromPoints');
  
  // Properties
  print('');
  print('  Properties of $fromLTWH:');
  print('    left: ${fromLTWH.left}');
  print('    top: ${fromLTWH.top}');
  print('    right: ${fromLTWH.right}');
  print('    bottom: ${fromLTWH.bottom}');
  print('    width: ${fromLTWH.width}');
  print('    height: ${fromLTWH.height}');
  print('    size: ${fromLTWH.size}');
  print('    center: ${fromLTWH.center}');
}

void rectOperationsDemo() {
  var rect = Rect.fromLTWH(10.0, 20.0, 100.0, 50.0);
  
  print('Rect operations:');
  
  // Translation
  var shifted = rect.shift(Offset(5.0, 10.0));
  print('  Shifted by (5, 10): $shifted');
  
  var translated = rect.translate(5.0, 10.0);
  print('  Translated: $translated');
  
  // Inflation/deflation
  var inflated = rect.inflate(10.0);
  print('  Inflated by 10: $inflated');
  
  var deflated = rect.deflate(5.0);
  print('  Deflated by 5: $deflated');
  
  // Intersection and union
  var other = Rect.fromLTWH(50.0, 40.0, 100.0, 50.0);
  var intersection = rect.intersect(other);
  print('  Intersection with $other: $intersection');
  
  var union = rect.expandToInclude(other);
  print('  Union with other: $union');
  
  // Contains checks
  var containsPoint = rect.contains(Offset(50.0, 40.0));
  print('  Contains (50, 40): $containsPoint');
  
  var overlaps = rect.overlaps(other);
  print('  Overlaps other: $overlaps');
}

void edgeInsetsDemo() {
  print('EdgeInsets basics:');
  
  // Creation methods
  var all = EdgeInsets.all(20.0);
  print('  EdgeInsets.all(20): ${all.left}, ${all.top}, ${all.right}, ${all.bottom}');
  
  var symmetric = EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0);
  print('  symmetric(h:10, v:20): ${symmetric.left}, ${symmetric.top}');
  
  var only = EdgeInsets.only(left: 10.0, top: 20.0);
  print('  only(left:10, top:20): $only');
  
  var fromLTRB = EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0);
  print('  fromLTRB(10,20,30,40): $fromLTRB');
  
  // Operations
  print('');
  print('  EdgeInsets operations:');
  
  var horizontal = fromLTRB.horizontal;
  var vertical = fromLTRB.vertical;
  print('    horizontal (left+right): $horizontal');
  print('    vertical (top+bottom): $vertical');
  
  var collapsed = fromLTRB.collapsedSize;
  print('    collapsedSize: $collapsed');
  
  var flippedH = fromLTRB.flipped;
  print('    flipped: $flippedH');
  
  // Inflate a rect
  var rect = Rect.fromLTWH(50.0, 50.0, 100.0, 100.0);
  var inflatedRect = all.inflateRect(rect);
  print('    Rect $rect inflated by all(20): $inflatedRect');
  
  var deflatedRect = all.deflateRect(rect);
  print('    Rect deflated: $deflatedRect');
}

// =============================================================================
// SECTION 12: Matrix4 Transforms for Rendering
// =============================================================================

void matrix4TransformDemo() {
  print('Matrix4 transforms for rendering:');
  print('');
  print('  Used in:');
  print('    - Transform widget');
  print('    - CustomPaint canvas transforms');
  print('    - Hit test coordinate conversion');
  print('');
  
  // Identity matrix
  var identity = Matrix4.identity();
  print('  Identity matrix (no transform):');
  print('    $identity');
  
  // Translation
  var translation = Matrix4.translationValues(100.0, 50.0, 0.0);
  print('  Translation (100, 50, 0):');
  print('    storage[12]: ${translation.storage[12]}');
  print('    storage[13]: ${translation.storage[13]}');
  
  // Rotation around Z axis (2D rotation)
  var rotation = Matrix4.rotationZ(0.785398); // 45 degrees
  print('  Rotation Z (45 degrees):');
  print('    storage[0]: ${rotation.storage[0].toStringAsFixed(4)}');
  
  // Scale
  var scale = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  print('  Scale (2x, 2x, 1x):');
  print('    storage[0]: ${scale.storage[0]}');
  print('    storage[5]: ${scale.storage[5]}');
}

void transformPointDemo() {
  print('Transforming points with Matrix4:');
  print('');
  
  var point = Offset(100.0, 50.0);
  print('  Original point: $point');
  
  // Apply translation
  var translateMatrix = Matrix4.translationValues(20.0, 30.0, 0.0);
  var vector3 = translateMatrix.transform3(
    Vector3(point.dx, point.dy, 0.0),
  );
  var translatedPoint = Offset(vector3.x, vector3.y);
  print('  After translation (20, 30): $translatedPoint');
  
  // Apply scale
  var scaleMatrix = Matrix4.diagonal3Values(2.0, 0.5, 1.0);
  var scaledVector = scaleMatrix.transform3(
    Vector3(point.dx, point.dy, 0.0),
  );
  var scaledPoint = Offset(scaledVector.x, scaledVector.y);
  print('  After scale (2x, 0.5x): $scaledPoint');
}

// =============================================================================
// SECTION 13: Paint and Decoration
// =============================================================================

void paintStyleDemo() {
  print('Paint style options:');
  print('');
  print('  PaintingStyle:');
  print('    - fill: Fill the shape');
  print('    - stroke: Outline only');
  print('');
  print('  StrokeCap (line endings):');
  print('    - butt: Flat end at exact point');
  print('    - round: Rounded end');
  print('    - square: Square end extending past point');
  print('');
  print('  StrokeJoin (corner style):');
  print('    - miter: Sharp corners');
  print('    - round: Rounded corners');
  print('    - bevel: Flat corners');
  
  // Create paint objects
  var fillPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;
  print('');
  print('  Fill paint color: ${fillPaint.color}');
  print('  Fill paint style: ${fillPaint.style}');
  
  var strokePaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..strokeCap = StrokeCap.round;
  print('');
  print('  Stroke paint width: ${strokePaint.strokeWidth}');
  print('  Stroke paint cap: ${strokePaint.strokeCap}');
}

void boxDecorationDemo() {
  print('BoxDecoration for rendering:');
  print('');
  print('  Properties:');
  print('    - color: Background fill');
  print('    - border: Border around box');
  print('    - borderRadius: Rounded corners');
  print('    - boxShadow: Drop shadow');
  print('    - gradient: Gradient fill');
  print('    - image: Background image');
  print('    - shape: BoxShape.rectangle or circle');
  
  // Create decoration
  var decoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
  
  print('');
  print('  Decoration color: ${decoration.color}');
  print('  Decoration borderRadius: ${decoration.borderRadius}');
  print('  Decoration shadow count: ${decoration.boxShadow?.length}');
}

// =============================================================================
// Test Wrapper
// =============================================================================

void main() {
  group('Deep Demo - Flutter Rendering Package Classes', () {
    test('Section 1: Size basics', () {
      sizeBasicsDemo();
    });
    
    test('Section 1: Size operations', () {
      sizeOperationsDemo();
    });
    
    test('Section 1: Size geometry', () {
      sizeGeometryDemo();
    });
    
    test('Section 1: Size validity', () {
      sizeValidityDemo();
    });
    
    test('Section 2: Offset basics', () {
      offsetBasicsDemo();
    });
    
    test('Section 2: Offset operations', () {
      offsetOperationsDemo();
    });
    
    test('Section 2: Offset geometry', () {
      offsetGeometryDemo();
    });
    
    test('Section 2: Offset comparison', () {
      offsetComparisonDemo();
    });
    
    test('Section 3: BoxConstraints basics', () {
      boxConstraintsBasicsDemo();
    });
    
    test('Section 3: BoxConstraints tight variations', () {
      boxConstraintsTightDemo();
    });
    
    test('Section 3: BoxConstraints queries', () {
      boxConstraintsQueriesDemo();
    });
    
    test('Section 3: BoxConstraints transformations', () {
      boxConstraintsTransformationsDemo();
    });
    
    test('Section 3: BoxConstraints constraining', () {
      boxConstraintsConstrainDemo();
    });
    
    test('Section 4: Constraints concept', () {
      constraintsConceptDemo();
    });
    
    test('Section 5: RenderObject hierarchy', () {
      renderObjectHierarchyDemo();
    });
    
    test('Section 5: RenderBox basics', () {
      renderBoxBasicsDemo();
    });
    
    test('Section 6: Layout process concepts', () {
      layoutProcessConceptsDemo();
    });
    
    test('Section 6: Constraints flow', () {
      constraintsFlowDemo();
    });
    
    test('Section 7: Paint process concepts', () {
      paintProcessConceptsDemo();
    });
    
    test('Section 7: PaintingContext demo', () {
      paintingContextDemo();
    });
    
    test('Section 7: Canvas operations', () {
      canvasOperationsDemo();
    });
    
    test('Section 8: Hit testing concepts', () {
      hitTestingConceptsDemo();
    });
    
    test('Section 8: HitTestResult demo', () {
      hitTestResultDemo();
    });
    
    test('Section 8: Hit test bounds', () {
      hitTestBoundsDemo();
    });
    
    test('Section 8: Hit test transforms', () {
      hitTestTransformsDemo();
    });
    
    test('Section 9: ParentData concepts', () {
      parentDataConceptsDemo();
    });
    
    test('Section 9: BoxParentData demo', () {
      boxParentDataDemo();
    });
    
    test('Section 9: FlexParentData demo', () {
      flexParentDataDemo();
    });
    
    test('Section 10: RenderObject lifecycle', () {
      renderObjectLifecycleDemo();
    });
    
    test('Section 10: RenderObject flags', () {
      renderObjectFlagsDemo();
    });
    
    test('Section 10: RepaintBoundary', () {
      repaintBoundaryDemo();
    });
    
    test('Section 11: Rect demo', () {
      rectDemo();
    });
    
    test('Section 11: Rect operations', () {
      rectOperationsDemo();
    });
    
    test('Section 11: EdgeInsets demo', () {
      edgeInsetsDemo();
    });
    
    test('Section 12: Matrix4 transforms', () {
      matrix4TransformDemo();
    });
    
    test('Section 12: Transform points', () {
      transformPointDemo();
    });
    
    test('Section 13: Paint style', () {
      paintStyleDemo();
    });
    
    test('Section 13: BoxDecoration', () {
      boxDecorationDemo();
    });
  });
}
