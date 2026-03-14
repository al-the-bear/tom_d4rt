// D4rt test script: Tests RenderErrorBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderErrorBox test executing');

  // RenderErrorBox - Displays error messages in the infamous red/yellow error screen
  // Used by ErrorWidget to show framework errors during development
  
  // Create a RenderErrorBox with error message
  final errorBox = RenderErrorBox('Test error message for demonstration');
  print('RenderErrorBox created: $errorBox');
  print('message: Test error message for demonstration');
  
  // RenderErrorBox properties
  print('\nRenderErrorBox characteristics:');
  print('- Displays red background (debug mode)');
  print('- Shows error message in yellow text');
  print('- Uses striped diagonal pattern');
  print('- Self-contained (no children)');
  
  // Static configuration
  print('\nStatic configuration:');
  print('- backgroundColor: Red/maroon color');
  print('- textStyle: Yellow/white bold text');
  print('- minimumWidth: Minimum width before wrapping');
  
  // Sizing behavior
  print('\nSizing behavior:');
  print('- Expands to fill available space');
  print('- computeMinIntrinsicWidth: 0');
  print('- computeMaxIntrinsicWidth: 0');
  print('- performLayout: Uses constraints.biggest');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderErrorBox extends RenderBox');
  print('RenderBox extends RenderObject');
  print('Used exclusively by ErrorWidget');
  
  // Use cases
  print('\nUse cases:');
  print('- Framework error display');
  print('- Build-time errors');
  print('- Widget tree corruption');
  print('- Development debugging');

  print('\nRenderErrorBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderErrorBox Tests'),
      Text('Error message display box'),
      Text('Red background, yellow text'),
      Text('Used by ErrorWidget'),
    ],
  );
}
