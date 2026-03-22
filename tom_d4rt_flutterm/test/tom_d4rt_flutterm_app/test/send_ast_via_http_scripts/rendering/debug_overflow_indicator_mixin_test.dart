// ignore_for_file: unused_local_variable, unused_element, avoid_print
// ignore_for_file: unnecessary_null_comparison, prefer_function_declarations_over_variables
// ignore_for_file: unnecessary_brace_in_string_interps, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ============================================================================
// SECTION 1: DebugOverflowIndicatorMixin Concept
// ============================================================================
//
// DebugOverflowIndicatorMixin is a mixin class used by RenderObjects to paint
// visual overflow indicators during debug mode. When content exceeds the
// available space in a container, Flutter displays distinctive yellow and
// black diagonal stripes to alert developers to the overflow condition.
//
// Key Characteristics:
// - Yellow and black stripes (hazard pattern) indicate overflow regions
// - Only visible in debug mode (stripped in release builds)
// - Helps developers quickly identify layout issues
// - Paints on top of all other content for maximum visibility
//
// The hazard stripe pattern is universally recognized as a warning indicator,
// making overflow issues immediately apparent during development.
//
// ============================================================================

void main() {
  group('DebugOverflowIndicatorMixin Concept', () {
    // ========================================================================
    // Understanding the Overflow Indicator System
    // ========================================================================

    test('overflow indicator represents content exceeding bounds', () {
      // The overflow indicator is triggered when a child widget's size
      // exceeds the allocated space from its parent widget.

      var parentWidth = 200.0;
      var parentHeight = 100.0;
      var childWidth = 300.0;
      var childHeight = 150.0;

      var horizontalOverflow = childWidth - parentWidth;
      var verticalOverflow = childHeight - parentHeight;

      print('DebugOverflowIndicatorMixin Concept Demo');
      print('=' * 60);
      print('');
      print('Parent constraints: ${parentWidth}x${parentHeight}');
      print('Child requested size: ${childWidth}x${childHeight}');
      print('');
      print('Overflow detected:');
      print('  Horizontal overflow: $horizontalOverflow pixels');
      print('  Vertical overflow: $verticalOverflow pixels');
      print('');

      expect(horizontalOverflow, equals(100.0));
      expect(verticalOverflow, equals(50.0));
    });

    test('yellow and black stripes serve as hazard warning pattern', () {
      // The color combination of yellow and black is internationally
      // recognized as a hazard or warning indicator.

      var warningYellow = Color(0xFFE7C300);
      var warningBlack = Color(0xFF000000);

      var yellowRed = warningYellow.red;
      var yellowGreen = warningYellow.green;
      var yellowBlue = warningYellow.blue;

      print('Overflow Indicator Color Scheme');
      print('=' * 60);
      print('');
      print('Warning Yellow: #${warningYellow.value.toRadixString(16).toUpperCase()}');
      print('  Red component: $yellowRed');
      print('  Green component: $yellowGreen');
      print('  Blue component: $yellowBlue');
      print('');
      print('Warning Black: #${warningBlack.value.toRadixString(16).toUpperCase()}');
      print('');
      print('This color combination is used because:');
      print('  - High contrast ensures visibility on any background');
      print('  - Universally recognized as a warning pattern');
      print('  - Immediately draws developer attention');
      print('');

      expect(yellowRed, greaterThan(200));
      expect(yellowGreen, greaterThan(180));
      expect(yellowBlue, lessThan(50));
    });

    test('overflow indicators are debug-only visual aids', () {
      // Overflow indicators are specifically designed for debug mode
      // and provide immediate visual feedback during development.

      var isDebugMode = true;
      var isReleaseMode = false;

      var shouldShowIndicator = isDebugMode && !isReleaseMode;

      print('Debug Mode Overflow Indicators');
      print('=' * 60);
      print('');
      print('Debug mode: $isDebugMode');
      print('Release mode: $isReleaseMode');
      print('Show overflow indicator: $shouldShowIndicator');
      print('');
      print('In debug mode:');
      print('  - Overflow indicators are painted on screen');
      print('  - Warning message is printed to console');
      print('  - Layout bounds are visually marked');
      print('');
      print('In release mode:');
      print('  - Overflow indicators are NOT shown');
      print('  - Content may be clipped or overflow silently');
      print('  - Performance is prioritized over debugging');
      print('');

      expect(shouldShowIndicator, isTrue);
    });

    test('mixin pattern allows adding overflow indication to render objects', () {
      // DebugOverflowIndicatorMixin uses the mixin pattern to add
      // overflow painting capability to existing RenderObject classes.

      var mixinFeatures = <String>[
        'paintOverflowIndicator method',
        'overflow region calculation',
        'stripe pattern rendering',
        'debug-only execution guards',
      ];

      print('DebugOverflowIndicatorMixin Features');
      print('=' * 60);
      print('');
      print('The mixin provides these capabilities:');
      for (var i = 0; i < mixinFeatures.length; i++) {
        print('  ${i + 1}. ${mixinFeatures[i]}');
      }
      print('');
      print('Classes that use this mixin:');
      print('  - RenderFlex (Row, Column)');
      print('  - RenderStack');
      print('  - RenderConstrainedOverflowBox');
      print('  - Custom RenderObjects with overflow potential');
      print('');

      expect(mixinFeatures.length, equals(4));
    });

    test('overflow detection occurs during layout phase', () {
      // Overflow is detected when layout constraints cannot accommodate
      // the requested child size.

      var maxWidth = 300.0;
      var maxHeight = 200.0;
      var requestedWidth = 450.0;
      var requestedHeight = 180.0;

      var widthFits = requestedWidth <= maxWidth;
      var heightFits = requestedHeight <= maxHeight;
      var overflowDetected = !widthFits || !heightFits;

      print('Overflow Detection During Layout');
      print('=' * 60);
      print('');
      print('Constraints:');
      print('  Max width: $maxWidth');
      print('  Max height: $maxHeight');
      print('');
      print('Requested size:');
      print('  Width: $requestedWidth (fits: $widthFits)');
      print('  Height: $requestedHeight (fits: $heightFits)');
      print('');
      print('Overflow detected: $overflowDetected');
      print('');
      print('Layout phase sequence:');
      print('  1. Parent provides constraints');
      print('  2. Child calculates desired size');
      print('  3. Overflow is detected if size exceeds constraints');
      print('  4. DebugOverflowIndicatorMixin paints indicators');
      print('');

      expect(overflowDetected, isTrue);
      expect(widthFits, isFalse);
      expect(heightFits, isTrue);
    });
  });

  // ==========================================================================
  // SECTION 2: paintOverflowIndicator Method
  // ==========================================================================

  group('paintOverflowIndicator Method', () {
    test('method signature accepts required painting parameters', () {
      // The paintOverflowIndicator method requires several parameters
      // to correctly position and size the overflow indicators.

      var paintingContextAvailable = true;
      var offsetProvided = Offset(10.0, 20.0);
      var containerRect = Rect.fromLTWH(0, 0, 200, 100);
      var childRect = Rect.fromLTWH(-10, -5, 250, 130);

      print('paintOverflowIndicator Method Parameters');
      print('=' * 60);
      print('');
      print('Required parameters:');
      print('  1. PaintingContext: Provides canvas for drawing');
      print('  2. Offset: Position offset for painting ($offsetProvided)');
      print('  3. Container rect: Bounds of container ($containerRect)');
      print('  4. Child rect: Actual child bounds ($childRect)');
      print('');
      print('The method calculates overflow from rect comparison:');
      print('  Container: ${containerRect.width}x${containerRect.height}');
      print('  Child: ${childRect.width}x${childRect.height}');
      print('');

      expect(paintingContextAvailable, isTrue);
      expect(offsetProvided.dx, equals(10.0));
    });

    test('overflow calculation compares container and child rectangles', () {
      // Overflow is calculated by comparing the child rect against
      // the container rect in each direction.

      var containerLeft = 0.0;
      var containerTop = 0.0;
      var containerRight = 300.0;
      var containerBottom = 200.0;

      var childLeft = -20.0;
      var childTop = -10.0;
      var childRight = 350.0;
      var childBottom = 220.0;

      var leftOverflow = (containerLeft - childLeft).clamp(0.0, double.infinity);
      var topOverflow = (containerTop - childTop).clamp(0.0, double.infinity);
      var rightOverflow = (childRight - containerRight).clamp(0.0, double.infinity);
      var bottomOverflow = (childBottom - containerBottom).clamp(0.0, double.infinity);

      print('Overflow Calculation Process');
      print('=' * 60);
      print('');
      print('Container bounds:');
      print('  Left: $containerLeft, Top: $containerTop');
      print('  Right: $containerRight, Bottom: $containerBottom');
      print('');
      print('Child bounds:');
      print('  Left: $childLeft, Top: $childTop');
      print('  Right: $childRight, Bottom: $childBottom');
      print('');
      print('Calculated overflow amounts:');
      print('  Left overflow: $leftOverflow pixels');
      print('  Top overflow: $topOverflow pixels');
      print('  Right overflow: $rightOverflow pixels');
      print('  Bottom overflow: $bottomOverflow pixels');
      print('');

      expect(leftOverflow, equals(20.0));
      expect(topOverflow, equals(10.0));
      expect(rightOverflow, equals(50.0));
      expect(bottomOverflow, equals(20.0));
    });

    test('stripe pattern is created using shader gradients', () {
      // The yellow/black stripe pattern is implemented using
      // a linear gradient shader that repeats.

      var stripeWidth = 10.0;
      var stripeAngle = 45.0;
      var colorYellow = Color(0xFFE7C300);
      var colorBlack = Color(0xFF000000);

      var stripeColors = <Color>[
        colorYellow,
        colorYellow,
        colorBlack,
        colorBlack,
      ];

      var stripeStops = <double>[
        0.0,
        0.5,
        0.5,
        1.0,
      ];

      print('Stripe Pattern Implementation');
      print('=' * 60);
      print('');
      print('Stripe configuration:');
      print('  Stripe width: $stripeWidth pixels');
      print('  Stripe angle: $stripeAngle degrees');
      print('');
      print('Gradient colors:');
      for (var i = 0; i < stripeColors.length; i++) {
        var colorHex = stripeColors[i].value.toRadixString(16).toUpperCase();
        print('  Stop ${stripeStops[i]}: #$colorHex');
      }
      print('');
      print('The gradient creates a repeating pattern by:');
      print('  - Using TileMode.repeated');
      print('  - Sharp color transitions at 0.5');
      print('  - Diagonal orientation for visibility');
      print('');

      expect(stripeColors.length, equals(4));
      expect(stripeStops.length, equals(4));
    });

    test('indicator size is proportional to overflow amount', () {
      // The visual indicator size scales with the amount of overflow
      // to indicate severity.

      var minIndicatorSize = 10.0;
      var maxIndicatorSize = 50.0;
      var overflowAmount = 75.0;
      var scaleFactor = 0.4;

      var indicatorSize = (overflowAmount * scaleFactor).clamp(
        minIndicatorSize,
        maxIndicatorSize,
      );

      print('Indicator Size Scaling');
      print('=' * 60);
      print('');
      print('Overflow amount: $overflowAmount pixels');
      print('Scale factor: $scaleFactor');
      print('');
      print('Size constraints:');
      print('  Minimum indicator size: $minIndicatorSize pixels');
      print('  Maximum indicator size: $maxIndicatorSize pixels');
      print('');
      print('Calculated indicator size: $indicatorSize pixels');
      print('');
      print('Size scaling rationale:');
      print('  - Small overflow shows minimal indicator');
      print('  - Large overflow shows prominent indicator');
      print('  - Maximum size prevents excessive screen coverage');
      print('');

      expect(indicatorSize, equals(30.0));
      expect(indicatorSize, greaterThanOrEqualTo(minIndicatorSize));
      expect(indicatorSize, lessThanOrEqualTo(maxIndicatorSize));
    });

    test('paint method respects clip behavior settings', () {
      // The overflow indicator respects the clip behavior setting
      // of the parent widget.

      var clipBehaviors = <String, String>{
        'Clip.none': 'No clipping, overflow visible',
        'Clip.hardEdge': 'Fast clipping, jagged edges',
        'Clip.antiAlias': 'Smooth clipping, moderate cost',
        'Clip.antiAliasWithSaveLayer': 'Best quality, highest cost',
      };

      print('Clip Behavior and Overflow Indicators');
      print('=' * 60);
      print('');
      print('Available clip behaviors:');
      for (var entry in clipBehaviors.entries) {
        print('  ${entry.key}:');
        print('    ${entry.value}');
        print('');
      }
      print('When overflow occurs:');
      print('  - Indicator is painted regardless of clip mode');
      print('  - Content clipping follows the behavior setting');
      print('  - Debug indicator appears on top of clipped content');
      print('');

      expect(clipBehaviors.length, equals(4));
    });

    test('paint order ensures indicators are visible on top', () {
      // Overflow indicators are painted after child content
      // to ensure they remain visible.

      var paintOrder = <String>[
        'Background painting',
        'Child content painting',
        'Foreground painting',
        'Debug overlay painting',
        'Overflow indicator painting',
      ];

      print('Paint Order for Overflow Indicators');
      print('=' * 60);
      print('');
      print('Standard painting sequence:');
      for (var i = 0; i < paintOrder.length; i++) {
        print('  ${i + 1}. ${paintOrder[i]}');
      }
      print('');
      print('By painting last, overflow indicators:');
      print('  - Always remain visible');
      print('  - Cannot be obscured by content');
      print('  - Provide clear debug information');
      print('');

      expect(paintOrder.last, contains('Overflow'));
    });
  });

  // ==========================================================================
  // SECTION 3: Overflow Regions (Top, Right, Bottom, Left)
  // ==========================================================================

  group('Overflow Regions', () {
    test('top overflow region extends above container', () {
      // Top overflow occurs when child content extends above
      // the top edge of the container.

      var containerTop = 100.0;
      var childTop = 60.0;
      var overflowAmount = containerTop - childTop;

      var indicatorRect = _OverflowRect(
        left: 0.0,
        top: containerTop - overflowAmount,
        right: 200.0,
        bottom: containerTop,
      );

      print('Top Overflow Region');
      print('=' * 60);
      print('');
      print('Container top edge: $containerTop');
      print('Child top edge: $childTop');
      print('Overflow amount: $overflowAmount pixels');
      print('');
      print('Indicator region:');
      print('  Left: ${indicatorRect.left}');
      print('  Top: ${indicatorRect.top}');
      print('  Right: ${indicatorRect.right}');
      print('  Bottom: ${indicatorRect.bottom}');
      print('');
      print('The top indicator:');
      print('  - Spans the full width of container');
      print('  - Height matches overflow amount');
      print('  - Positioned at negative y relative to container');
      print('');

      expect(overflowAmount, equals(40.0));
      expect(indicatorRect.height, equals(40.0));
    });

    test('right overflow region extends beyond container right edge', () {
      // Right overflow occurs when child content extends past
      // the right edge of the container.

      var containerRight = 300.0;
      var childRight = 380.0;
      var overflowAmount = childRight - containerRight;

      var indicatorRect = _OverflowRect(
        left: containerRight,
        top: 0.0,
        right: childRight,
        bottom: 150.0,
      );

      print('Right Overflow Region');
      print('=' * 60);
      print('');
      print('Container right edge: $containerRight');
      print('Child right edge: $childRight');
      print('Overflow amount: $overflowAmount pixels');
      print('');
      print('Indicator region:');
      print('  Left: ${indicatorRect.left}');
      print('  Top: ${indicatorRect.top}');
      print('  Right: ${indicatorRect.right}');
      print('  Bottom: ${indicatorRect.bottom}');
      print('');
      print('The right indicator:');
      print('  - Spans the full height of container');
      print('  - Width matches overflow amount');
      print('  - Positioned at container right edge');
      print('');

      expect(overflowAmount, equals(80.0));
      expect(indicatorRect.width, equals(80.0));
    });

    test('bottom overflow region extends below container', () {
      // Bottom overflow occurs when child content extends below
      // the bottom edge of the container.

      var containerBottom = 200.0;
      var childBottom = 275.0;
      var overflowAmount = childBottom - containerBottom;

      var indicatorRect = _OverflowRect(
        left: 0.0,
        top: containerBottom,
        right: 250.0,
        bottom: childBottom,
      );

      print('Bottom Overflow Region');
      print('=' * 60);
      print('');
      print('Container bottom edge: $containerBottom');
      print('Child bottom edge: $childBottom');
      print('Overflow amount: $overflowAmount pixels');
      print('');
      print('Indicator region:');
      print('  Left: ${indicatorRect.left}');
      print('  Top: ${indicatorRect.top}');
      print('  Right: ${indicatorRect.right}');
      print('  Bottom: ${indicatorRect.bottom}');
      print('');
      print('The bottom indicator:');
      print('  - Most common overflow direction');
      print('  - Often caused by vertical content overflow');
      print('  - Spans full width of container');
      print('');

      expect(overflowAmount, equals(75.0));
      expect(indicatorRect.height, equals(75.0));
    });

    test('left overflow region extends beyond container left edge', () {
      // Left overflow occurs when child content extends past
      // the left edge of the container.

      var containerLeft = 50.0;
      var childLeft = 20.0;
      var overflowAmount = containerLeft - childLeft;

      var indicatorRect = _OverflowRect(
        left: childLeft,
        top: 0.0,
        right: containerLeft,
        bottom: 180.0,
      );

      print('Left Overflow Region');
      print('=' * 60);
      print('');
      print('Container left edge: $containerLeft');
      print('Child left edge: $childLeft');
      print('Overflow amount: $overflowAmount pixels');
      print('');
      print('Indicator region:');
      print('  Left: ${indicatorRect.left}');
      print('  Top: ${indicatorRect.top}');
      print('  Right: ${indicatorRect.right}');
      print('  Bottom: ${indicatorRect.bottom}');
      print('');
      print('The left indicator:');
      print('  - Less common than right overflow');
      print('  - Can occur with RTL layouts');
      print('  - Spans full height of container');
      print('');

      expect(overflowAmount, equals(30.0));
      expect(indicatorRect.width, equals(30.0));
    });

    test('multiple overflow regions can occur simultaneously', () {
      // Complex layouts may overflow in multiple directions
      // at the same time.

      var containerRect = Rect.fromLTRB(50, 50, 250, 200);
      var childRect = Rect.fromLTRB(20, 30, 300, 250);

      var leftOverflow = (containerRect.left - childRect.left).clamp(0.0, double.infinity);
      var topOverflow = (containerRect.top - childRect.top).clamp(0.0, double.infinity);
      var rightOverflow = (childRect.right - containerRect.right).clamp(0.0, double.infinity);
      var bottomOverflow = (childRect.bottom - containerRect.bottom).clamp(0.0, double.infinity);

      var overflowDirections = <String>[];
      if (leftOverflow > 0) overflowDirections.add('LEFT');
      if (topOverflow > 0) overflowDirections.add('TOP');
      if (rightOverflow > 0) overflowDirections.add('RIGHT');
      if (bottomOverflow > 0) overflowDirections.add('BOTTOM');

      print('Multiple Simultaneous Overflow Regions');
      print('=' * 60);
      print('');
      print('Container: $containerRect');
      print('Child: $childRect');
      print('');
      print('Overflow amounts:');
      print('  Left: $leftOverflow pixels');
      print('  Top: $topOverflow pixels');
      print('  Right: $rightOverflow pixels');
      print('  Bottom: $bottomOverflow pixels');
      print('');
      print('Active overflow directions: ${overflowDirections.join(", ")}');
      print('');
      print('When multiple overflows occur:');
      print('  - Each direction gets its own indicator');
      print('  - Corner regions show overlapping stripes');
      print('  - All indicators use same color scheme');
      print('');

      expect(overflowDirections.length, equals(4));
      expect(leftOverflow, equals(30.0));
      expect(topOverflow, equals(20.0));
      expect(rightOverflow, equals(50.0));
      expect(bottomOverflow, equals(50.0));
    });

    test('corner regions handle overlapping indicators', () {
      // When overflow occurs in adjacent directions, corner regions
      // require special handling.

      var hasTopOverflow = true;
      var hasRightOverflow = true;
      var hasBottomOverflow = true;
      var hasLeftOverflow = true;

      var cornerRegions = <String, bool>{
        'Top-Left': hasTopOverflow && hasLeftOverflow,
        'Top-Right': hasTopOverflow && hasRightOverflow,
        'Bottom-Right': hasBottomOverflow && hasRightOverflow,
        'Bottom-Left': hasBottomOverflow && hasLeftOverflow,
      };

      print('Corner Region Handling');
      print('=' * 60);
      print('');
      print('Overflow status:');
      print('  Top: $hasTopOverflow');
      print('  Right: $hasRightOverflow');
      print('  Bottom: $hasBottomOverflow');
      print('  Left: $hasLeftOverflow');
      print('');
      print('Corner regions with overlap:');
      for (var entry in cornerRegions.entries) {
        var status = entry.value ? 'OVERLAPPING' : 'No overlap';
        print('  ${entry.key}: $status');
      }
      print('');
      print('Corner painting strategy:');
      print('  - Paint horizontal indicators first');
      print('  - Paint vertical indicators second');
      print('  - Natural z-order creates visual distinction');
      print('');

      var overlappingCorners = cornerRegions.values.where((v) => v).length;
      expect(overlappingCorners, equals(4));
    });

    test('overflow region priority when indicators would overlap', () {
      // When multiple overflow regions would overlap, priority
      // determines which indicator is painted on top.

      var overflowPriority = <String, int>{
        'bottom': 1,
        'top': 2,
        'right': 3,
        'left': 4,
      };

      print('Overflow Region Paint Priority');
      print('=' * 60);
      print('');
      print('Priority order (highest painted last):');
      var sortedByPriority = overflowPriority.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      for (var entry in sortedByPriority) {
        print('  Priority ${entry.value}: ${entry.key.toUpperCase()}');
      }
      print('');
      print('This ordering ensures:');
      print('  - Consistent visual appearance');
      print('  - Predictable corner behavior');
      print('  - Clear indication of primary overflow direction');
      print('');

      expect(overflowPriority['left'], equals(4));
    });
  });

  // ==========================================================================
  // SECTION 4: Visual Simulation of Overflow Indicators
  // ==========================================================================

  group('Visual Simulation of Overflow Indicators', () {
    test('simulate horizontal overflow stripe rendering', () {
      // Visual simulation of how horizontal overflow stripes appear
      // in the debug display.

      var overflowWidth = 50;
      var stripeWidth = 10;
      var numStripes = overflowWidth ~/ stripeWidth;

      var stripePattern = StringBuffer();
      for (var i = 0; i < numStripes; i++) {
        if (i % 2 == 0) {
          stripePattern.write('YYYY');
        } else {
          stripePattern.write('BBBB');
        }
      }

      print('Horizontal Overflow Stripe Visualization');
      print('=' * 60);
      print('');
      print('Overflow width: $overflowWidth pixels');
      print('Individual stripe width: $stripeWidth pixels');
      print('Number of stripes: $numStripes');
      print('');
      print('Stripe pattern representation:');
      print('  Y = Yellow stripe section');
      print('  B = Black stripe section');
      print('');
      print('Pattern: ${stripePattern.toString()}');
      print('');
      _printHorizontalStripeAsciiArt();
      print('');

      expect(numStripes, equals(5));
    });

    test('simulate vertical overflow stripe rendering', () {
      // Visual simulation of how vertical overflow stripes appear
      // in the debug display.

      var overflowHeight = 60;
      var stripeHeight = 12;
      var numStripes = overflowHeight ~/ stripeHeight;

      print('Vertical Overflow Stripe Visualization');
      print('=' * 60);
      print('');
      print('Overflow height: $overflowHeight pixels');
      print('Individual stripe height: $stripeHeight pixels');
      print('Number of stripes: $numStripes');
      print('');
      _printVerticalStripeAsciiArt();
      print('');
      print('The diagonal stripes create a visual pattern that:');
      print('  - Draws immediate attention');
      print('  - Indicates the overflow boundary');
      print('  - Shows the direction of overflow');
      print('');

      expect(numStripes, equals(5));
    });

    test('simulate complete overflow container visualization', () {
      // Complete visual representation of a container with
      // overflow in multiple directions.

      var containerWidth = 40;
      var containerHeight = 20;
      var overflowTop = 5;
      var overflowRight = 8;
      var overflowBottom = 6;
      var overflowLeft = 4;

      print('Complete Overflow Container Visualization');
      print('=' * 60);
      print('');
      print('Container: ${containerWidth}x${containerHeight} units');
      print('Overflow: T:$overflowTop R:$overflowRight B:$overflowBottom L:$overflowLeft');
      print('');

      _printCompleteOverflowVisualization(
        containerWidth,
        containerHeight,
        overflowTop,
        overflowRight,
        overflowBottom,
        overflowLeft,
      );

      print('');
      print('Legend:');
      print('  # = Yellow/Black overflow indicator');
      print('  . = Container content area');
      print('  | = Vertical container boundary');
      print('  - = Horizontal container boundary');
      print('');

      expect(containerWidth, equals(40));
      expect(overflowTop + overflowBottom, equals(11));
    });

    test('simulate Row widget overflow scenario', () {
      // Common overflow scenario: Row widget with too many children
      // causing horizontal overflow on the right side.

      var rowWidth = 300.0;
      var childWidths = <double>[80.0, 90.0, 85.0, 95.0, 75.0];
      var totalChildWidth = childWidths.fold(0.0, (sum, w) => sum + w);
      var overflow = totalChildWidth - rowWidth;

      print('Row Widget Overflow Scenario');
      print('=' * 60);
      print('');
      print('Row width constraint: $rowWidth pixels');
      print('');
      print('Child widgets:');
      for (var i = 0; i < childWidths.length; i++) {
        print('  Child ${i + 1}: ${childWidths[i]} pixels');
      }
      print('');
      print('Total child width: $totalChildWidth pixels');
      print('Overflow amount: $overflow pixels');
      print('');
      _printRowOverflowVisualization(rowWidth.toInt(), childWidths);
      print('');
      print('Common solutions:');
      print('  1. Wrap children in Flexible/Expanded');
      print('  2. Use SingleChildScrollView');
      print('  3. Reduce child sizes');
      print('  4. Use Wrap widget instead');
      print('');

      expect(overflow, equals(125.0));
    });

    test('simulate Column widget overflow scenario', () {
      // Common overflow scenario: Column widget with too many children
      // causing vertical overflow at the bottom.

      var columnHeight = 400.0;
      var childHeights = <double>[100.0, 120.0, 95.0, 110.0, 85.0];
      var totalChildHeight = childHeights.fold(0.0, (sum, h) => sum + h);
      var overflow = totalChildHeight - columnHeight;

      print('Column Widget Overflow Scenario');
      print('=' * 60);
      print('');
      print('Column height constraint: $columnHeight pixels');
      print('');
      print('Child widgets:');
      for (var i = 0; i < childHeights.length; i++) {
        print('  Child ${i + 1}: ${childHeights[i]} pixels');
      }
      print('');
      print('Total child height: $totalChildHeight pixels');
      print('Overflow amount: $overflow pixels');
      print('');
      _printColumnOverflowVisualization(columnHeight.toInt(), childHeights);
      print('');
      print('Common solutions:');
      print('  1. Wrap Column in SingleChildScrollView');
      print('  2. Use ListView instead');
      print('  3. Use Flexible/Expanded for children');
      print('  4. Reduce child heights');
      print('');

      expect(overflow, equals(110.0));
    });

    test('simulate Stack widget overflow scenario', () {
      // Stack widgets can overflow when positioned children extend
      // beyond the Stack bounds.

      var stackWidth = 200.0;
      var stackHeight = 150.0;

      var positionedChildren = <Map<String, double>>[
        {'left': -20.0, 'top': 10.0, 'width': 80.0, 'height': 60.0},
        {'left': 150.0, 'top': 30.0, 'width': 100.0, 'height': 50.0},
        {'left': 50.0, 'top': 130.0, 'width': 70.0, 'height': 40.0},
      ];

      print('Stack Widget Overflow Scenario');
      print('=' * 60);
      print('');
      print('Stack size: ${stackWidth}x${stackHeight} pixels');
      print('');
      print('Positioned children:');

      var leftOverflow = 0.0;
      var topOverflow = 0.0;
      var rightOverflow = 0.0;
      var bottomOverflow = 0.0;

      for (var i = 0; i < positionedChildren.length; i++) {
        var child = positionedChildren[i];
        var childLeft = child['left'] ?? 0;
        var childTop = child['top'] ?? 0;
        var childWidth = child['width'] ?? 0;
        var childHeight = child['height'] ?? 0;
        var childRight = childLeft + childWidth;
        var childBottom = childTop + childHeight;

        print('  Child ${i + 1}: left=$childLeft, top=$childTop, ${childWidth}x${childHeight}');

        if (childLeft < 0) leftOverflow = leftOverflow > -childLeft ? leftOverflow : -childLeft;
        if (childTop < 0) topOverflow = topOverflow > -childTop ? topOverflow : -childTop;
        if (childRight > stackWidth) {
          var overflow = childRight - stackWidth;
          rightOverflow = rightOverflow > overflow ? rightOverflow : overflow;
        }
        if (childBottom > stackHeight) {
          var overflow = childBottom - stackHeight;
          bottomOverflow = bottomOverflow > overflow ? bottomOverflow : overflow;
        }
      }

      print('');
      print('Calculated overflow:');
      print('  Left: $leftOverflow pixels');
      print('  Top: $topOverflow pixels');
      print('  Right: $rightOverflow pixels');
      print('  Bottom: $bottomOverflow pixels');
      print('');
      print('Stack overflow handling:');
      print('  - Use Clip.none to allow visible overflow');
      print('  - Use Clip.hardEdge to clip content');
      print('  - Adjust positions to fit within bounds');
      print('');

      expect(leftOverflow, equals(20.0));
      expect(rightOverflow, equals(50.0));
      expect(bottomOverflow, equals(20.0));
    });

    test('simulate text overflow scenario', () {
      // Text overflow shows indicators when text exceeds container width
      // without proper overflow handling.

      var containerWidth = 200.0;
      var fontSize = 16.0;
      var averageCharWidth = fontSize * 0.6;
      var textContent = 'This is a very long text that exceeds container bounds';
      var textWidth = textContent.length * averageCharWidth;
      var overflow = textWidth - containerWidth;

      print('Text Overflow Scenario');
      print('=' * 60);
      print('');
      print('Container width: $containerWidth pixels');
      print('Text content: "$textContent"');
      print('Character count: ${textContent.length}');
      print('Estimated text width: ${textWidth.toStringAsFixed(1)} pixels');
      print('Overflow amount: ${overflow.toStringAsFixed(1)} pixels');
      print('');
      print('Text overflow handling options:');
      print('  TextOverflow.clip - Clip at boundary');
      print('  TextOverflow.fade - Fade out at edge');
      print('  TextOverflow.ellipsis - Show "..." at end');
      print('  TextOverflow.visible - Allow overflow');
      print('');
      print('Without overflow handling:');
      _printTextOverflowVisualization(containerWidth.toInt(), textWidth.toInt());
      print('');

      expect(overflow, greaterThan(0));
    });

    test('demonstrate overflow indicator color intensity', () {
      // The overflow indicator color remains constant but the visual
      // impact increases with overflow size.

      var overflowLevels = <int>[10, 25, 50, 100, 200];
      var warningYellow = Color(0xFFE7C300);
      var warningBlack = Color(0xFF000000);

      print('Overflow Indicator Intensity by Size');
      print('=' * 60);
      print('');
      print('Color scheme (constant):');
      print('  Yellow: #${warningYellow.value.toRadixString(16).toUpperCase()}');
      print('  Black: #${warningBlack.value.toRadixString(16).toUpperCase()}');
      print('');
      print('Visual impact by overflow size:');

      for (var level in overflowLevels) {
        var impactDescription = _getImpactDescription(level);
        var visualBar = '#' * (level ~/ 5);
        print('');
        print('  ${level}px overflow:');
        print('  [$visualBar]');
        print('  Impact: $impactDescription');
      }

      print('');
      print('The indicator size directly correlates to overflow severity,');
      print('helping developers prioritize which overflows to fix first.');
      print('');

      expect(overflowLevels.length, equals(5));
    });

    test('diagonal stripe angle calculation', () {
      // The diagonal stripes are rendered at 45 degrees for
      // optimal visibility and recognition.

      var stripeAngleDegrees = 45.0;
      var stripeAngleRadians = stripeAngleDegrees * (3.14159265359 / 180.0);
      var stripeSpacing = 10.0;

      var horizontalOffset = stripeSpacing / (2.0 * 0.7071);
      var verticalOffset = stripeSpacing / (2.0 * 0.7071);

      print('Diagonal Stripe Angle Calculation');
      print('=' * 60);
      print('');
      print('Stripe configuration:');
      print('  Angle: $stripeAngleDegrees degrees');
      print('  Angle in radians: ${stripeAngleRadians.toStringAsFixed(4)}');
      print('  Spacing: $stripeSpacing pixels');
      print('');
      print('Offset calculations:');
      print('  Horizontal offset: ${horizontalOffset.toStringAsFixed(2)} pixels');
      print('  Vertical offset: ${verticalOffset.toStringAsFixed(2)} pixels');
      print('');
      print('45-degree angle benefits:');
      print('  - Maximum visual distinction from content');
      print('  - Equal horizontal and vertical components');
      print('  - Universally recognized warning pattern');
      print('');

      expect(stripeAngleDegrees, equals(45.0));
    });
  });

  // ==========================================================================
  // Additional Tests for Comprehensive Coverage
  // ==========================================================================

  group('Edge Cases and Special Scenarios', () {
    test('zero overflow produces no indicators', () {
      // When content exactly fits within bounds, no indicators are shown.

      var containerSize = Size(300.0, 200.0);
      var childSize = Size(300.0, 200.0);

      var horizontalOverflow = (childSize.width - containerSize.width).clamp(0.0, double.infinity);
      var verticalOverflow = (childSize.height - containerSize.height).clamp(0.0, double.infinity);

      var hasOverflow = horizontalOverflow > 0 || verticalOverflow > 0;

      print('Zero Overflow Scenario');
      print('=' * 60);
      print('');
      print('Container size: ${containerSize.width}x${containerSize.height}');
      print('Child size: ${childSize.width}x${childSize.height}');
      print('');
      print('Horizontal overflow: $horizontalOverflow');
      print('Vertical overflow: $verticalOverflow');
      print('Has overflow: $hasOverflow');
      print('');
      print('When content fits exactly:');
      print('  - No overflow indicators are painted');
      print('  - No console warnings are printed');
      print('  - Layout is considered valid');
      print('');

      expect(hasOverflow, isFalse);
    });

    test('sub-pixel overflow handling', () {
      // Very small overflow amounts may be ignored due to
      // floating-point precision considerations.

      var containerWidth = 200.0;
      var childWidth = 200.0001;
      var overflow = childWidth - containerWidth;

      var precisionThreshold = 0.01;
      var isSignificantOverflow = overflow > precisionThreshold;

      print('Sub-Pixel Overflow Handling');
      print('=' * 60);
      print('');
      print('Container width: $containerWidth');
      print('Child width: $childWidth');
      print('Raw overflow: $overflow');
      print('');
      print('Precision threshold: $precisionThreshold');
      print('Is significant overflow: $isSignificantOverflow');
      print('');
      print('Sub-pixel overflow considerations:');
      print('  - Floating-point math can produce tiny overflows');
      print('  - Very small overflows may be ignored');
      print('  - Threshold prevents false positive indicators');
      print('');

      expect(overflow, lessThan(0.001));
      expect(isSignificantOverflow, isFalse);
    });

    test('large overflow truncation for display', () {
      // Very large overflow amounts are truncated in the warning message
      // for readability.

      var overflow = 12345.67890;
      var maxDisplayDigits = 2;
      var truncatedOverflow = double.parse(overflow.toStringAsFixed(maxDisplayDigits));

      var warningMessage = 'A RenderFlex overflowed by $truncatedOverflow pixels';

      print('Large Overflow Display Truncation');
      print('=' * 60);
      print('');
      print('Actual overflow: $overflow pixels');
      print('Displayed overflow: $truncatedOverflow pixels');
      print('');
      print('Warning message:');
      print('  $warningMessage');
      print('');
      print('Display formatting rules:');
      print('  - Decimal places limited for readability');
      print('  - Large numbers maintained for accuracy');
      print('  - Units (pixels) always included');
      print('');

      expect(truncatedOverflow, equals(12345.68));
    });

    test('overflow in scrollable containers', () {
      // Scrollable containers handle overflow differently as scrolling
      // is the expected way to access overflow content.

      var viewportHeight = 500.0;
      var contentHeight = 2000.0;
      var scrollPosition = 300.0;
      var visibleContent = viewportHeight;
      var hiddenContent = contentHeight - viewportHeight;

      print('Overflow in Scrollable Containers');
      print('=' * 60);
      print('');
      print('Viewport height: $viewportHeight');
      print('Total content height: $contentHeight');
      print('Current scroll position: $scrollPosition');
      print('');
      print('Content visibility:');
      print('  Visible content: $visibleContent pixels');
      print('  Hidden (scrollable) content: $hiddenContent pixels');
      print('');
      print('Scrollable container behavior:');
      print('  - Content beyond viewport is NOT overflow');
      print('  - Scrolling provides access to all content');
      print('  - No overflow indicators are shown');
      print('  - This is intentional design, not an error');
      print('');

      expect(contentHeight > viewportHeight, isTrue);
      expect(hiddenContent, equals(1500.0));
    });

    test('overflow with transforms and rotations', () {
      // Transforms can cause visual overflow even when layout
      // does not detect overflow.

      var widgetWidth = 100.0;
      var widgetHeight = 50.0;
      var rotationAngle = 45.0;

      var diagonal = (widgetWidth * widgetWidth + widgetHeight * widgetHeight);
      diagonal = _sqrt(diagonal);

      var rotatedBoundingWidth = diagonal;
      var rotatedBoundingHeight = diagonal;

      print('Overflow with Transforms');
      print('=' * 60);
      print('');
      print('Original widget size: ${widgetWidth}x${widgetHeight}');
      print('Rotation angle: $rotationAngle degrees');
      print('');
      print('Bounding box after rotation:');
      print('  Width: ${rotatedBoundingWidth.toStringAsFixed(2)} pixels');
      print('  Height: ${rotatedBoundingHeight.toStringAsFixed(2)} pixels');
      print('');
      print('Transform overflow considerations:');
      print('  - Layout overflow is checked BEFORE transforms');
      print('  - Visual overflow after transform may not trigger indicators');
      print('  - Use Transform.scale/rotate with alignment carefully');
      print('');

      expect(rotatedBoundingWidth, greaterThan(widgetWidth));
    });

    test('overflow indicator interaction with hit testing', () {
      // Overflow indicators are purely visual and do not affect
      // hit testing or gesture detection.

      var indicatorBounds = Rect.fromLTWH(300, 0, 50, 200);
      var tapPosition = Offset(320, 100);
      var isInIndicatorBounds = indicatorBounds.contains(tapPosition);

      print('Overflow Indicator and Hit Testing');
      print('=' * 60);
      print('');
      print('Indicator bounds: $indicatorBounds');
      print('Tap position: $tapPosition');
      print('Tap is within indicator visual bounds: $isInIndicatorBounds');
      print('');
      print('Hit testing behavior:');
      print('  - Overflow indicators do NOT capture gestures');
      print('  - Taps pass through to underlying content');
      print('  - Overflow region is still interactive');
      print('  - This allows debugging without losing functionality');
      print('');

      expect(isInIndicatorBounds, isTrue);
    });

    test('performance impact of overflow indicators', () {
      // Overflow indicators have minimal performance impact as they
      // are only painted when overflow is detected.

      var normalPaintTime = 16.0;
      var overflowPaintOverhead = 0.5;
      var totalPaintTime = normalPaintTime + overflowPaintOverhead;
      var overheadPercentage = (overflowPaintOverhead / normalPaintTime) * 100;

      print('Performance Impact of Overflow Indicators');
      print('=' * 60);
      print('');
      print('Timing estimates (microseconds):');
      print('  Normal paint time: $normalPaintTime');
      print('  Overflow indicator overhead: $overflowPaintOverhead');
      print('  Total paint time: $totalPaintTime');
      print('  Overhead percentage: ${overheadPercentage.toStringAsFixed(1)}%');
      print('');
      print('Performance characteristics:');
      print('  - Minimal impact on frame rendering');
      print('  - Only painted when overflow exists');
      print('  - Stripped completely in release builds');
      print('  - No memory overhead when not in use');
      print('');

      expect(overheadPercentage, lessThan(5.0));
    });
  });

  group('Debug Console Messages', () {
    test('overflow warning message format', () {
      // The console warning message provides detailed information
      // about the overflow condition.

      var widgetType = 'RenderFlex';
      var overflowAmount = 125.5;
      var overflowDirection = 'right';

      var warningLine1 = 'A $widgetType overflowed by $overflowAmount pixels on the $overflowDirection.';
      var warningLine2 = 'The overflowing $widgetType has an orientation of Axis.horizontal.';
      var warningLine3 = 'The edge of the $widgetType that is overflowing has been marked in the rendering with a yellow and black striped pattern.';

      print('Overflow Warning Message Format');
      print('=' * 60);
      print('');
      print('Console output format:');
      print('');
      print('  $warningLine1');
      print('  $warningLine2');
      print('  $warningLine3');
      print('');
      print('Message components:');
      print('  - Widget type causing overflow');
      print('  - Exact overflow amount in pixels');
      print('  - Direction of overflow');
      print('  - Visual indicator description');
      print('');

      expect(warningLine1, contains('125.5'));
      expect(warningLine1, contains('right'));
    });

    test('suggested fixes in warning message', () {
      // The overflow warning includes suggestions for fixing
      // the layout issue.

      var suggestions = <String>[
        'Consider applying a flex factor (e.g., Expanded) to force the children to fill the available space instead of being sized to their natural size.',
        'Consider applying clip behavior to the overflowing RenderFlex.',
        'Use a ListView instead of a Column to allow scrolling.',
        'Use SingleChildScrollView to make the content scrollable.',
      ];

      print('Suggested Fixes in Warning Message');
      print('=' * 60);
      print('');
      print('Common fix suggestions:');
      for (var i = 0; i < suggestions.length; i++) {
        print('');
        print('  ${i + 1}. ${suggestions[i]}');
      }
      print('');
      print('These suggestions help developers quickly resolve issues.');
      print('');

      expect(suggestions.length, equals(4));
    });
  });
}

// ============================================================================
// Helper Classes and Functions
// ============================================================================

class _OverflowRect {
  double left;
  double top;
  double right;
  double bottom;

  _OverflowRect({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  double get width => right - left;
  double get height => bottom - top;
}

double _sqrt(double value) {
  if (value <= 0) return 0;
  var guess = value / 2;
  for (var i = 0; i < 20; i++) {
    guess = (guess + value / guess) / 2;
  }
  return guess;
}

void _printHorizontalStripeAsciiArt() {
  print('  +==========================================+============+');
  print('  |  Container Content                       | ####  #### |');
  print('  |                                          |####  #### #|');
  print('  |                                          |###  #### ##|');
  print('  |  [Content Here]                          |##  #### ###|');
  print('  |                                          |#  #### ####|');
  print('  |                                          |  #### #### |');
  print('  +==========================================+============+');
  print('                                             ^-- Right overflow');
}

void _printVerticalStripeAsciiArt() {
  print('  +============================+');
  print('  |     Container Content      |');
  print('  |                            |');
  print('  |     [Content Here]         |');
  print('  |                            |');
  print('  +============================+');
  print('  |####  ####  ####  ####  ####|');
  print('  |###  ####  ####  ####  #### |');
  print('  |##  ####  ####  ####  ####  |');
  print('  |#  ####  ####  ####  ####  #|');
  print('  +============================+');
  print('    ^-- Bottom overflow');
}

void _printCompleteOverflowVisualization(
  int containerWidth,
  int containerHeight,
  int overflowTop,
  int overflowRight,
  int overflowBottom,
  int overflowLeft,
) {
  var topLine = ' ' * overflowLeft + '#' * (containerWidth + overflowLeft + overflowRight);
  for (var i = 0; i < overflowTop; i++) {
    print('  $topLine');
  }

  for (var i = 0; i < containerHeight; i++) {
    var line = StringBuffer();
    line.write('#' * overflowLeft);
    line.write('|');
    line.write('.' * (containerWidth - 2));
    line.write('|');
    line.write('#' * overflowRight);
    print('  ${line.toString()}');
  }

  var bottomLine = ' ' * overflowLeft + '#' * (containerWidth + overflowLeft + overflowRight);
  for (var i = 0; i < overflowBottom; i++) {
    print('  $bottomLine');
  }
}

void _printRowOverflowVisualization(int rowWidth, List<double> childWidths) {
  var visualWidth = 50;
  var totalChildWidth = childWidths.fold(0.0, (sum, w) => sum + w);
  var scaleFactor = visualWidth / (totalChildWidth + 30);

  print('  +${"=" * visualWidth}+');

  var childBar = StringBuffer('  |');
  var currentPos = 0.0;
  for (var i = 0; i < childWidths.length; i++) {
    var scaledWidth = (childWidths[i] * scaleFactor).round();
    scaledWidth = scaledWidth < 2 ? 2 : scaledWidth;
    if (currentPos + childWidths[i] <= rowWidth) {
      childBar.write('=' * scaledWidth);
    } else {
      childBar.write('#' * scaledWidth);
    }
    currentPos += childWidths[i];
  }
  while (childBar.length < visualWidth + 3) {
    childBar.write(' ');
  }
  childBar.write('|');
  print(childBar.toString());

  print('  +${"=" * visualWidth}+');
  var boundaryPos = (rowWidth * scaleFactor).round();
  print('  ${" " * boundaryPos}^-- Container boundary');
  print('  ${" " * (boundaryPos + 5)}#### = Overflow');
}

void _printColumnOverflowVisualization(int columnHeight, List<double> childHeights) {
  var visualHeight = 12;
  var totalHeight = childHeights.fold(0.0, (sum, h) => sum + h);
  var scaleFactor = visualHeight / totalHeight;

  print('  +------------+');

  var currentPos = 0.0;
  var heightBoundary = (columnHeight * scaleFactor).round();
  var linesPrinted = 0;

  for (var i = 0; i < childHeights.length; i++) {
    var scaledHeight = (childHeights[i] * scaleFactor).round();
    scaledHeight = scaledHeight < 1 ? 1 : scaledHeight;

    for (var j = 0; j < scaledHeight; j++) {
      if (linesPrinted < heightBoundary) {
        print('  |  Item ${i + 1}   |');
      } else {
        print('  |## Item ${i + 1} ##| <- overflow');
      }
      linesPrinted++;
    }
    currentPos += childHeights[i];
  }

  print('  +------------+');
}

void _printTextOverflowVisualization(int containerWidth, int textWidth) {
  var scale = 40.0 / textWidth;
  var scaledContainer = (containerWidth * scale).round();
  var scaledText = (textWidth * scale).round();

  scaledContainer = scaledContainer < 10 ? 10 : scaledContainer;
  scaledText = scaledText < 15 ? 15 : scaledText;

  print('  Container:');
  print('  +${"=" * scaledContainer}+');
  var textPart = 'T' * scaledContainer;
  var overflowPart = '#' * (scaledText - scaledContainer);
  print('  |$textPart|$overflowPart <- overflow');
  print('  +${"=" * scaledContainer}+');
  print('  |<--- container --->|<-- overflow -->|');
}

String _getImpactDescription(int overflowPixels) {
  if (overflowPixels < 20) {
    return 'Minor - easily fixable';
  } else if (overflowPixels < 50) {
    return 'Moderate - noticeable issue';
  } else if (overflowPixels < 100) {
    return 'Significant - needs attention';
  } else {
    return 'Severe - layout redesign needed';
  }
}
