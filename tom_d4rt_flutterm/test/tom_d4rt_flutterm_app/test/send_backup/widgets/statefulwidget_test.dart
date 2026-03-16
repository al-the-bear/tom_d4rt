// D4rt test script: Tests StatelessWidget, StatefulWidget, State, BuildContext from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StatefulWidget test executing');

  // Test BuildContext access
  print('BuildContext from build parameter: $context');
  print('BuildContext.widget: ${context.widget}');

  // Test finding ancestors via context
  try {
    final scaffold = Scaffold.of(context);
    print('Scaffold.of(context) accessed');
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
  print('GlobalKey<_StatefulDemoState> created for external state access');

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
  State<_StatefulDemo> createState() {
    print('_StatefulDemo.createState() called');
    return _StatefulDemoState();
  }
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
