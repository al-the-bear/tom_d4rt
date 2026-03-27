// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RootElementMixin from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootElementMixin test executing');
  print('=' * 50);

  // RootElementMixin is for root elements
  print('RootElementMixin:');
  print('Purpose: Mixin for elements at the tree root');
  print('Mixin on: Element');
  print('');

  // Why root elements are special
  print('Why root elements are special:');
  print('  - Only root can have owner set explicitly');
  print('  - Other elements inherit owner from parent');
  print('  - Root has no parent element');
  print('');

  // assignOwner method
  print('assignOwner(BuildOwner owner):');
  print('  - Sets the BuildOwner for the element tree');
  print('  - Also creates root _parentBuildScope');
  print('  - Called by WidgetsBinding.runApp');
  print('');

  // Mount override
  print('mount(Element? parent, Object? newSlot):');
  print('  - Asserts parent is null (root has no parent)');
  print('  - Asserts newSlot is null');
  print('  - Calls super.mount');
  print('');

  // BuildOwner relationship
  print('BuildOwner relationship:');
  print('  - WidgetsBinding.buildOwner is primary owner');
  print('  - Owner manages dirty elements list');
  print('  - Drives build pipeline via buildScope');
  print('');

  // Where it is used
  print('Where RootElementMixin is used:');
  print('  - RootRenderObjectElement uses this mixin');
  print('  - RenderObjectToWidgetElement (via RootRenderObjectElement)');
  print('  - First element created by runApp');
  print('');

  // Element tree structure
  print('Element tree structure:');
  print('  [RootElement + RootElementMixin]');
  print('       |');
  print('    [WidgetsApp element]');
  print('       |');
  print('    [MaterialApp, etc.]');
  print('');

  // Cannot test directly
  print('Testing limitations:');
  print('  - Mixin requires Element base');
  print('  - Root element created internally');
  print('  - Test via runApp behavior');
  print('');

  print('Type check via hierarchy:');
  final element = context as Element;
  print('Current context is Element: ${element is Element}');
  print('Root element created by framework');

  print('\n' + '=' * 50);
  print('RootElementMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RootElementMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Mixin on Element'),
      Text('For tree root elements only'),
      Text('Manages BuildOwner assignment'),
    ],
  );
}
