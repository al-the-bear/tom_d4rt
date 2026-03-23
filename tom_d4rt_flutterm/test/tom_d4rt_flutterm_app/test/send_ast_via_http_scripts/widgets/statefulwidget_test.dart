// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StatelessWidget, StatefulWidget, State, BuildContext from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StatefulWidget test executing');

  // Test BuildContext access
  print('BuildContext from build parameter: $context');
  print('BuildContext.widget: ${context.widget}');

  // Test finding ancestors via context
  try {
    final scaffold = Scaffold.of(context);
    print('Scaffold.of(context) accessed: $scaffold');
  } catch (e) {
    print('Scaffold.of(context) not available in this context');
  }

  // Test Theme.of(context)
  try {
    final theme = Theme.of(context);
    print('Theme.of(context) accessed');
    print('Theme brightness: ${theme.brightness}');
    print('Theme primaryColor: ${theme.primaryColor}');
  } catch (e) {
    print('Theme.of(context) error: $e');
  }

  // Test MediaQuery.of(context)
  try {
    final mediaQuery = MediaQuery.of(context);
    print('MediaQuery.of(context) accessed');
    print('Screen size: ${mediaQuery.size}');
    print('Device pixel ratio: ${mediaQuery.devicePixelRatio}');
    print('Text scale factor: ${mediaQuery.textScaleFactor}');
    print('Padding: ${mediaQuery.padding}');
  } catch (e) {
    print('MediaQuery.of(context) error: $e');
  }

  // Test Navigator.of(context)
  try {
    final nav = Navigator.of(context);
    print('Navigator.of(context) accessed');
    print('Can pop: ${nav.canPop()}');
  } catch (e) {
    print('Navigator.of(context) not available');
  }

  // Test context.findAncestorWidgetOfExactType
  print('context.findAncestorWidgetOfExactType<T>() - finds ancestor widget');

  // Test context.findAncestorStateOfType
  print('context.findAncestorStateOfType<T>() - finds ancestor state');

  // Test context.findRootAncestorStateOfType
  print('context.findRootAncestorStateOfType<T>() - finds root ancestor state');

  // Test context.dependOnInheritedWidgetOfExactType
  print(
    'context.dependOnInheritedWidgetOfExactType<T>() - depend on inherited',
  );

  // Test context.getInheritedWidgetOfExactType
  print(
    'context.getInheritedWidgetOfExactType<T>() - get inherited (no dependency)',
  );

  // Test context.visitAncestorElements
  print('context.visitAncestorElements() - visit ancestor tree');

  // Test context.visitChildElements
  print('context.visitChildElements() - visit child tree');

  // Example StatelessWidget (conceptual)
  print('');
  print('StatelessWidget pattern:');
  print('class MyWidget extends StatelessWidget {');
  print('  const MyWidget({super.key});');
  print('  @override');
  print('  Widget build(BuildContext context) => Container();');
  print('}');

  // Example StatefulWidget (conceptual)
  print('');
  print('StatefulWidget pattern:');
  print('class MyStateful extends StatefulWidget {');
  print('  const MyStateful({super.key});');
  print('  @override');
  print('  State<MyStateful> createState() => _MyStatefulState();');
  print('}');
  print('');
  print('class _MyStatefulState extends State<MyStateful> {');
  print('  int _counter = 0;');
  print('  void _increment() {');
  print('    setState(() => _counter++);');
  print('  }');
  print('  @override');
  print('  Widget build(BuildContext context) => Text("\$_counter");');
  print('}');

  // State lifecycle methods
  print('');
  print('State lifecycle:');
  print('1. createState() - called once to create State');
  print('2. initState() - called once when State is inserted');
  print(
    '3. didChangeDependencies() - called after initState and when deps change',
  );
  print('4. build() - called when widget needs to rebuild');
  print('5. didUpdateWidget() - called when parent rebuilds with new widget');
  print('6. deactivate() - called when State is removed from tree');
  print('7. dispose() - called when State is permanently removed');

  // State methods
  print('');
  print('State methods:');
  print('setState(() {}) - triggers rebuild');
  print('widget - current StatefulWidget');
  print('context - current BuildContext');
  print('mounted - whether State is in tree');

  // Test demonstrating stateful behavior
  final statefulDemo = _StatefulDemo();
  print('');
  print('StatefulDemo widget created');

  // Test InheritedWidget concept
  print('');
  print('InheritedWidget pattern:');
  print('class MyInherited extends InheritedWidget {');
  print('  final int data;');
  print('  static MyInherited of(BuildContext context) =>');
  print('    context.dependOnInheritedWidgetOfExactType<MyInherited>()!;');
  print('  @override');
  print('  bool updateShouldNotify(MyInherited old) => data != old.data;');
  print('}');

  // Test widget comparison
  print('');
  print('Widget comparison:');
  print('StatelessWidget - immutable, rebuild on parent rebuild');
  print('StatefulWidget - mutable internal state, setState() triggers rebuild');
  print('InheritedWidget - efficiently shares data down the tree');

  // Test mounted property
  print('');
  print('State.mounted - true when initState called, false after dispose');

  // Test GlobalKey<State> usage
  final stateKey = GlobalKey<_StatefulDemoState>();
  print('GlobalKey<_StatefulDemoState> created for external state access: $stateKey');

  print('');
  print('StatefulWidget test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'StatefulWidget Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'BuildContext Info:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('• Widget: ${context.widget.runtimeType}'),
        Text('• Owner: ${context.owner}'),
        SizedBox(height: 16.0),

        Text(
          'StatefulWidget Demo:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        statefulDemo,
        SizedBox(height: 16.0),

        Text(
          'Widget Lifecycle:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _LifecycleItem('createState()', 'Create State instance'),
        _LifecycleItem('initState()', 'Initialize state'),
        _LifecycleItem('didChangeDependencies()', 'Dependencies changed'),
        _LifecycleItem('build()', 'Build widget tree'),
        _LifecycleItem('didUpdateWidget()', 'Widget config changed'),
        _LifecycleItem('deactivate()', 'Removed from tree'),
        _LifecycleItem('dispose()', 'Permanent removal'),
        SizedBox(height: 16.0),

        Text('Context Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• findAncestorWidgetOfExactType<T>()'),
        Text('• findAncestorStateOfType<T>()'),
        Text('• findRootAncestorStateOfType<T>()'),
        Text('• dependOnInheritedWidgetOfExactType<T>()'),
        Text('• getInheritedWidgetOfExactType<T>()'),
        Text('• visitAncestorElements()'),
        Text('• visitChildElements()'),
      ],
    ),
  );
}

// Demo StatefulWidget
class _StatefulDemo extends StatefulWidget {
  @override
  State<_StatefulDemo> createState() => _StatefulDemoState();
}

class _StatefulDemoState extends State<_StatefulDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    print('_StatefulDemoState.initState() called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('_StatefulDemoState.didChangeDependencies() called');
  }

  @override
  void didUpdateWidget(_StatefulDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_StatefulDemoState.didUpdateWidget() called');
  }

  @override
  void deactivate() {
    print('_StatefulDemoState.deactivate() called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('_StatefulDemoState.dispose() called');
    super.dispose();
  }

  void _increment() {
    setState(() {
      _counter++;
      print('Counter incremented to $_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_StatefulDemoState.build() called, counter=$_counter');
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Counter: $_counter', style: TextStyle(fontSize: 18.0)),
          ElevatedButton(onPressed: _increment, child: Text('Increment')),
        ],
      ),
    );
  }
}

// Helper widget for lifecycle display
class _LifecycleItem extends StatelessWidget {
  final String method;
  final String description;

  const _LifecycleItem(this.method, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            method,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '- $description',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
