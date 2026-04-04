// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for ScrollPositionWithSingleContext.
///
/// ScrollPositionWithSingleContext is the most commonly used concrete
/// implementation of ScrollPosition. It manages scroll behavior using
/// ScrollActivity objects.
///
/// Key features:
/// - Used by ListView, GridView, CustomScrollView
/// - Implements ScrollActivityDelegate
/// - Handles user scroll direction tracking
/// - Manages drag/hold interactions
dynamic build(BuildContext context) {
  print('=== ScrollPositionWithSingleContext Test ===');
  print('');
  
  // Class details
  print('ScrollPositionWithSingleContext:');
  print('  Extends: ScrollPosition');
  print('  Implements: ScrollActivityDelegate');
  print('  Usage: Default for most scrollables');
  print('');
  
  // Constructor parameters
  print('Constructor Parameters:');
  print('  - physics (required): ScrollPhysics for behavior');
  print('  - context (required): ScrollContext from Scrollable');
  print('  - initialPixels: Starting scroll offset (default 0.0)');
  print('  - keepScrollOffset: Save/restore with PageStorage');
  print('  - oldPosition: Position to absorb state from');
  print('  - debugLabel: Label for debugging');
  print('');
  
  // Activity delegate methods
  print('ScrollActivityDelegate Methods:');
  print('  - axisDirection: Get scroll axis direction');
  print('  - setPixels(double): Set pixel position directly');
  print('  - goIdle(): Start IdleScrollActivity');
  print('  - goBallistic(velocity): Start momentum scroll');
  print('');
  
  // User scroll direction
  print('User Scroll Direction:');
  print('  - userScrollDirection: Current scroll direction');
  print('  - Used for focus management');
  print('  - Tracks whether user is scrolling forward or reverse');
  print('');
  
  // Drag handling
  print('Drag Handling:');
  print('  - hold(): Capture scroll for potential drag');
  print('  - drag(): Start drag activity');
  print('  - _heldPreviousVelocity: Velocity transferred between activities');
  print('');
  
  // State absorption
  print('State Absorption (absorb):');
  print('  - Takes state from another ScrollPosition');
  print('  - Handles different ScrollPosition types');
  print('  - Transfers drag state when possible');
  print('  - Calls goIdle() for incompatible positions');
  print('');
  
  // Position restoration
  print('Position Restoration:');
  print('  - Uses PageStorage for persistence');
  print('  - keepScrollOffset enables auto-restore');
  print('  - Restored when Scrollable recreated');
  print('');
  
  // Related classes
  print('Related Classes:');
  print('  - ScrollController: Creates and manages positions');
  print('  - ScrollActivity: Manages scroll state');
  print('  - Scrollable: Widget that hosts the position');
  print('');
  
  print('Test completed.');
  return const SizedBox.shrink();
}
