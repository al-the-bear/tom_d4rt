// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderObjectToWidgetElement behavior
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RenderObjectToWidgetElement bridges the widget tree to a render tree root
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetElement test executing');

  // RenderObjectToWidgetElement is used internally by runApp to attach widgets
  // to a RenderObject tree. We test the concepts through observable behavior.

  // Test 1: Access element via context
  print('--- Element Context Tests ---');
  final testKey = GlobalKey();

  // Widget that reports its element info
  Widget buildElementInspector(String label) {
    return Builder(
      key: label == 'Primary' ? testKey : null,
      builder: (context) {
        final element = context as Element;
        print('$label Element type: ${element.runtimeType}');
        print('$label Element depth: ${element.depth}');
        print('$label Element widget: ${element.widget.runtimeType}');
        print('$label Element owner: ${element.owner?.runtimeType}');
        print('$label Element mounted: ${element.mounted}');

        // Check render object if available
        if (context is RenderObjectElement) {
          print('$label RenderObject: ${context.renderObject.runtimeType}');
        }

        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$label Element',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Type: ${element.runtimeType}'),
              Text('Depth: ${element.depth}'),
              Text('Mounted: ${element.mounted}'),
            ],
          ),
        );
      },
    );
  }

  // Test 2: Element tree traversal
  print('--- Element Tree Traversal ---');
  Widget buildTreeDemo() {
    return Builder(
      builder: (context) {
        final element = context as Element;

        // Visit ancestors
        var ancestorCount = 0;
        element.visitAncestorElements((ancestor) {
          ancestorCount++;
          if (ancestorCount <= 5) {
            print('Ancestor $ancestorCount: ${ancestor.widget.runtimeType}');
          }
          return ancestorCount < 10;
        });
        print('Total ancestors visited: $ancestorCount');

        return Container(
          padding: EdgeInsets.all(12),
          color: Colors.green.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Element Tree Demo'),
              Text('Ancestors: $ancestorCount'),
              SizedBox(height: 8),
              // Nested structure to test
              Container(
                color: Colors.green.shade100,
                padding: EdgeInsets.all(8),
                child: Builder(
                  builder: (innerContext) {
                    final innerElement = innerContext as Element;
                    print('Inner element depth: ${innerElement.depth}');
                    return Text('Inner (depth: ${innerElement.depth})');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Test 3: Finding elements by type
  print('--- Find Element Tests ---');
  Widget buildFindDemo() {
    return Builder(
      builder: (context) {
        // Find ancestor of type
        final scaffoldState = Scaffold.maybeOf(context);
        print('Scaffold found: ${scaffoldState != null}');

        // Find inherited widget
        final theme = Theme.of(context);
        print('Theme primaryColor: ${theme.primaryColor}');

        final mediaQuery = MediaQuery.of(context);
        print('MediaQuery size: ${mediaQuery.size}');

        // Directionality
        final direction = Directionality.of(context);
        print('Text direction: $direction');

        return Container(
          padding: EdgeInsets.all(12),
          color: Colors.orange.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Find Element Demo'),
              Text('Has Scaffold: ${scaffoldState != null}'),
              Text('Primary: ${theme.primaryColor}'),
              Text('Direction: $direction'),
            ],
          ),
        );
      },
    );
  }

  // Test 4: Element lifecycle via StatefulWidget
  print('--- Element Lifecycle Tests ---');
  Widget buildLifecycleDemo() {
    return StatefulBuilder(
      builder: (context, setState) {
        final element = context as StatefulElement;
        print('StatefulElement state: ${element.state.runtimeType}');
        print('StatefulElement mounted: ${element.mounted}');

        return Container(
          padding: EdgeInsets.all(12),
          color: Colors.purple.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lifecycle Demo'),
              Text('Element: ${element.runtimeType}'),
              Text('Mounted: ${element.mounted}'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => setState(() {}),
                child: Text('Trigger Rebuild'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Test 5: RenderObjectElement via Container
  print('--- RenderObjectElement Tests ---');
  Widget buildRenderObjectDemo() {
    return Builder(
      builder: (context) {
        // Access render box after layout
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (testKey.currentContext != null) {
            final renderBox =
                testKey.currentContext!.findRenderObject() as RenderBox?;
            if (renderBox != null && renderBox.hasSize) {
              print('RenderBox size: ${renderBox.size}');
              print('RenderBox constraints: ${renderBox.constraints}');
            }
          }
        });

        return Container(
          padding: EdgeInsets.all(12),
          color: Colors.cyan.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('RenderObject Demo'),
              SizedBox(
                key: GlobalKey(),
                width: 100,
                height: 50,
                child: ColoredBox(
                  color: Colors.cyan.shade200,
                  child: Center(child: Text('100x50')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  print('RenderObjectToWidgetElement test completed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
      appBar: AppBar(title: Text('RenderObjectToWidgetElement')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Element Tests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            buildElementInspector('Primary'),
            SizedBox(height: 12),
            buildTreeDemo(),
            SizedBox(height: 12),
            buildFindDemo(),
            SizedBox(height: 12),
            buildLifecycleDemo(),
            SizedBox(height: 12),
            buildRenderObjectDemo(),
          ],
        ),
      ),
    ),
  );
}
