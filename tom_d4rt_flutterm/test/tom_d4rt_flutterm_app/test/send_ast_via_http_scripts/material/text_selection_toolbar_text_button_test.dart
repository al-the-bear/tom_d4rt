// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionToolbarTextButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionToolbarTextButton test executing');
  print('=' * 50);

  // TextSelectionToolbarTextButton overview
  print('TextSelectionToolbarTextButton overview:');
  print('  - Button for selection toolbar');
  print('  - Text-only button style');
  print('  - StatelessWidget');

  // Test basic button
  print('\nTest basic button:');
  final button1 = TextSelectionToolbarTextButton(
    padding: EdgeInsets.all(8),
    onPressed: () {},
    child: Text('Copy'),
  );
  print('  padding: ${button1.padding}');
  print('  Has onPressed: ${button1.onPressed != null}');

  // Test disabled button
  print('\nTest disabled button:');
  final button2 = TextSelectionToolbarTextButton(
    padding: EdgeInsets.symmetric(horizontal: 16),
    onPressed: null,
    child: Text('Paste'),
  );
  print('  Disabled: ${button2.onPressed == null}');

  // Test with custom child
  print('\nTest with Row child:');
  final button3 = TextSelectionToolbarTextButton(
    padding: EdgeInsets.all(8),
    onPressed: () {},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(Icons.copy, size: 16), SizedBox(width: 4), Text('Copy')],
    ),
  );
  print('  Child: ${button3.child.runtimeType}');

  // Static getButtonTextStyle
  print('\nStatic getButtonTextStyle:');
  print('  Returns TextButton.styleFrom()');
  print('  Uses M3 theming');
  print('  Consistent toolbar styling');

  // Padding behavior
  print('\nPadding behavior:');
  print('  - Required padding parameter');
  print('  - EdgeInsetsGeometry type');
  print('  - Applied to button interior');

  // Alignment property
  print('\nDefault alignment:');
  print('  - alignment: Alignment.center');
  print('  - Can be customized');

  // Visual style
  print('\nVisual style:');
  print('  - TextButton underneath');
  print('  - No explicit background');
  print('  - Inherits theme colors');

  // Usage in toolbar
  print('\nUsage in toolbar:');
  print('  TextSelectionToolbar(');
  print('    children: [');
  print('      TextSelectionToolbarTextButton(...)');
  print('    ],');
  print('  )');

  print('\n' + '=' * 50);
  print('TextSelectionToolbarTextButton test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionToolbarTextButton Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatelessWidget'),
      Text('Purpose: Toolbar button'),
      button1,
    ],
  );
}
