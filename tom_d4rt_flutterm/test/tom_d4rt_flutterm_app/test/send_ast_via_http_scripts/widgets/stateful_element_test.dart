// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StatefulElement from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Test StatefulWidget
class TestStatefulWidget extends StatefulWidget {
  const TestStatefulWidget({super.key});
  
  @override
  State<TestStatefulWidget> createState() => _TestStatefulWidgetState();
}

class _TestStatefulWidgetState extends State<TestStatefulWidget> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return Text('Counter: $counter');
  }
}

dynamic build(BuildContext context) {
  print('StatefulElement test executing');
  print('=' * 50);

  // StatefulElement overview
  print('StatefulElement overview:');
  print('  - Element class for StatefulWidget');
  print('  - Extends ComponentElement');
  print('  - Manages State object lifecycle');
  print('  - Calls createState on StatefulWidget');

  // Create widget to inspect element
  print('\nStatefulElement creation:');
  final widget = TestStatefulWidget();
  print('  TestStatefulWidget created');
  print('  Widget runtimeType: ${widget.runtimeType}');

  // Key methods
  print('\nKey methods:');
  print('  - build(): Calls state.build(this)');
  print('  - reassemble(): Calls state.reassemble()');
  print('  - _firstBuild(): Calls initState and didChangeDependencies');
  print('  - performRebuild(): Calls didChangeDependencies if needed');
  print('  - update(): Updates widget and calls didUpdateWidget');

  // State lifecycle
  print('\nState lifecycle managed by StatefulElement:');
  print('  1. createState() called in constructor');
  print('  2. state._element = this');
  print('  3. state._widget = widget');
  print('  4. initState() in _firstBuild');
  print('  5. didChangeDependencies() in _firstBuild');
  print('  6. build() for widget tree');
  print('  7. didUpdateWidget(oldWidget) on update');
  print('  8. deactivate() when removed');
  print('  9. dispose() when unmounted');

  // State property
  print('\nState property:');
  print('  - state getter returns State<StatefulWidget>');
  print('  - Protected by null assertion');
  print('  - One-to-one relationship with Element');

  // Update behavior
  print('\nUpdate behavior:');
  print('  - Preserves State across widget rebuilds');
  print('  - State.widget updated to new widget');
  print('  - didUpdateWidget called with old widget');
  print('  - Force rebuild after update');

  // Error handling
  print('\nError handling:');
  print('  - Validates State type matches Widget type');
  print('  - Checks initState does not return Future');
  print('  - Checks didUpdateWidget does not return Future');

  print('\n' + '=' * 50);
  print('StatefulElement test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StatefulElement Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: ComponentElement'),
      Text('Purpose: Manages StatefulWidget lifecycle'),
      Text('Key property: state'),
    ],
  );
}
