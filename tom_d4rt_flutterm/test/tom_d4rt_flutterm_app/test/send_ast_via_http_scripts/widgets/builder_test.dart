// D4rt test script: Tests Builder from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Builder test executing');

  // Test Builder with simple builder function returning Container
  final simpleBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Container');
      return Container(
        color: Colors.blue,
        height: 60.0,
        child: Center(
          child: Text('Simple Builder', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('Builder with Container child created');

  // Test Builder returning Text widget
  final textBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Text');
      return Text(
        'Builder returns Text',
        style: TextStyle(fontSize: 18.0, color: Colors.green),
      );
    },
  );
  print('Builder returning Text created');

  // Test Builder returning Column
  final columnBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Column');
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('Item 1'), Text('Item 2'), Text('Item 3')],
      );
    },
  );
  print('Builder returning Column created');

  // Test Builder accessing Theme from context
  final themeBuilder = Builder(
    builder: (BuildContext ctx) {
      final theme = Theme.of(ctx);
      print('Builder accessing Theme: ${theme.primaryColor}');
      return Container(
        color: theme.primaryColor,
        height: 60.0,
        child: Center(
          child: Text('Theme color', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('Builder accessing Theme.of(context) created');

  // Test Builder accessing MediaQuery from context
  final mediaBuilder = Builder(
    builder: (BuildContext ctx) {
      final media = MediaQuery.of(ctx);
      print('Builder accessing MediaQuery: size=${media.size}');
      return Container(
        color: Colors.orange,
        height: 60.0,
        child: Center(
          child: Text(
            'Screen: ${media.size.width.toInt()}x${media.size.height.toInt()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('Builder accessing MediaQuery created');

  // Test Builder returning Card
  final cardBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Card');
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Card from Builder'),
        ),
      );
    },
  );
  print('Builder returning Card created');

  // Test nested Builders
  final nestedBuilder = Builder(
    builder: (BuildContext outerCtx) {
      print('Outer Builder invoked');
      return Container(
        color: Colors.grey,
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (BuildContext innerCtx) {
            print('Inner Builder invoked');
            return Container(
              color: Colors.indigo,
              height: 40.0,
              child: Center(
                child: Text(
                  'Nested Builder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      );
    },
  );
  print('Nested Builder created');

  // --- StatefulBuilder tests ---
  
  // Test StatefulBuilder with basic state
  final statefulBasic = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder basic builder invoked');
      return Container(
        color: Colors.teal,
        height: 60.0,
        child: Center(
          child: Text('StatefulBuilder Basic', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('StatefulBuilder basic created');

  // Test StatefulBuilder with counter-like state
  final statefulCounter = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder counter builder invoked');
      return Container(
        color: Colors.deepPurple,
        height: 60.0,
        child: Center(
          child: Text('Counter: 0', style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ),
      );
    },
  );
  print('StatefulBuilder counter created');

  // Test StatefulBuilder with toggle pattern
  final statefulToggle = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder toggle builder invoked');
      return Container(
        color: Colors.amber,
        height: 60.0,
        child: Center(
          child: Text('Toggle: OFF', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    },
  );
  print('StatefulBuilder toggle created');

  print('Builder test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Builder Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Simple Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        simpleBuilder,
        SizedBox(height: 8.0),
        Text('Text Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        textBuilder,
        SizedBox(height: 8.0),
        Text('Column Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        columnBuilder,
        SizedBox(height: 8.0),
        Text('Theme Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        themeBuilder,
        SizedBox(height: 8.0),
        Text(
          'MediaQuery Builder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        mediaBuilder,
        SizedBox(height: 8.0),
        Text('Card Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        cardBuilder,
        SizedBox(height: 8.0),
        Text('Nested Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        nestedBuilder,
        SizedBox(height: 16.0),
        Text('StatefulBuilder Tests:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        statefulBasic,
        SizedBox(height: 8.0),
        statefulCounter,
        SizedBox(height: 8.0),
        statefulToggle,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Builder provides a new BuildContext'),
        Text('• Useful for accessing inherited widgets'),
        Text('• Builder function runs during build phase'),
        Text('• Can return any widget type'),
        Text('• StatefulBuilder provides a setState callback'),
        Text('• StatefulBuilder enables local state in build()'),
      ],
    ),
  );
}
