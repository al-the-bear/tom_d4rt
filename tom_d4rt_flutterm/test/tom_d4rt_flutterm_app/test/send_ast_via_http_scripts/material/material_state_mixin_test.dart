// D4rt test script: Tests MaterialStateMixin from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialStateMixin test executing');
  print('=' * 50);

  // MaterialStateMixin for state management
  print('\nMaterialStateMixin:');
  print('Mixin for tracking Material state');
  print('Manages hovered, focused, pressed, etc.');

  // Purpose
  print('\nPurpose:');
  print('- Track interaction states');
  print('- Update widget appearance');
  print('- Handle state changes');

  // MaterialState enum
  print('\nMaterialState values:');
  print('- hovered: Mouse over (${MaterialState.hovered.index})');
  print('- focused: Has focus (${MaterialState.focused.index})');
  print('- pressed: Being pressed (${MaterialState.pressed.index})');
  print('- dragged: Being dragged (${MaterialState.dragged.index})');
  print('- selected: Currently selected (${MaterialState.selected.index})');
  print(
    '- scrolledUnder: Content scrolled under (${MaterialState.scrolledUnder.index})',
  );
  print('- disabled: Not interactive (${MaterialState.disabled.index})');
  print('- error: Error state (${MaterialState.error.index})');

  // Provides
  print('\nMixin provides:');
  print('- Set<MaterialState> materialStates');
  print('- setMaterialState(state, isSet)');
  print('- addMaterialState(state)');
  print('- removeMaterialState(state)');

  // Usage pattern
  print('\nUsage pattern:');
  print('class MyButton extends StatefulWidget {');
  print('  ...');
  print('}');
  print('');
  print('class _MyButtonState extends State<MyButton>');
  print('    with MaterialStateMixin {');
  print('  @override');
  print('  Widget build(BuildContext context) {');
  print('    final color = materialStates.contains(');
  print('      MaterialState.pressed');
  print('    ) ? Colors.blue : Colors.grey;');
  print('    ...');
  print('  }');
  print('}');

  // State resolution
  print('\nState resolution:');
  print('MaterialStateProperty.resolveWith(');
  print('  (states) {');
  print('    if (states.contains(MaterialState.pressed)) {');
  print('      return Colors.blue;');
  print('    }');
  print('    return Colors.grey;');
  print('  },');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('MaterialStateMixin (mixin)');
  print('  \u2514\u2500 Mixed into State classes');

  // Explain purpose
  print('\nMaterialStateMixin purpose:');
  print('- State tracking mixin');
  print('- materialStates set');
  print('- setMaterialState method');
  print('- Interaction state management');
  print('- Works with MaterialStateProperty');

  print('\n' + '=' * 50);
  print('MaterialStateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MaterialStateMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('States: ${MaterialState.values.length}'),
      Text('Property: materialStates'),
      Text('Purpose: State management'),
    ],
  );
}
