// D4rt test script: Tests InteractiveViewer from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InteractiveViewer test executing');

  // Test InteractiveViewer with default settings
  final viewerDefault = InteractiveViewer(
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Default InteractiveViewer',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with defaults created');

  // Test InteractiveViewer with panEnabled=false
  final viewerNoPan = InteractiveViewer(
    panEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.green,
      child: Center(
        child: Text(
          'No panning',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer panEnabled=false created');

  // Test InteractiveViewer with scaleEnabled=false
  final viewerNoScale = InteractiveViewer(
    scaleEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          'No scaling',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer scaleEnabled=false created');

  // Test InteractiveViewer with custom min/max scale
  final viewerScaleRange = InteractiveViewer(
    minScale: 0.5,
    maxScale: 4.0,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Scale 0.5-4.0',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer minScale=0.5, maxScale=4.0 created');

  // Test InteractiveViewer with boundaryMargin
  final viewerBoundary = InteractiveViewer(
    boundaryMargin: EdgeInsets.all(20.0),
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.red,
      child: Center(
        child: Text(
          'Boundary 20px',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with boundaryMargin=20 created');

  // Test InteractiveViewer with constrained=false
  final viewerUnconstrained = InteractiveViewer(
    constrained: false,
    boundaryMargin: EdgeInsets.all(100.0),
    minScale: 0.1,
    maxScale: 5.0,
    child: Container(
      width: 600.0,
      height: 400.0,
      decoration: BoxDecoration(
        color: Colors.teal,
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(
        child: Text(
          'Unconstrained 600x400',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer constrained=false created');

  // Test InteractiveViewer with both pan and scale disabled
  final viewerLocked = InteractiveViewer(
    panEnabled: false,
    scaleEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.brown,
      child: Center(
        child: Text(
          'Locked (no pan/scale)',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer locked (no pan, no scale) created');

  // Test InteractiveViewer with large boundary margin
  final viewerLargeBoundary = InteractiveViewer(
    boundaryMargin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
    minScale: 0.25,
    maxScale: 3.0,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.indigo,
      child: Center(
        child: Text(
          'Large boundary',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with large boundary margin created');

  // Test InteractiveViewer with onInteractionStart/End callbacks
  final viewerCallbacks = InteractiveViewer(
    onInteractionStart: (details) {
      print('Interaction started');
    },
    onInteractionEnd: (details) {
      print('Interaction ended');
    },
    onInteractionUpdate: (details) {
      print('Interaction update');
    },
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.amber,
      child: Center(
        child: Text(
          'With callbacks',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with interaction callbacks created');

  // Test InteractiveViewer with complex child
  final viewerComplex = InteractiveViewer(
    minScale: 0.5,
    maxScale: 3.0,
    boundaryMargin: EdgeInsets.all(40.0),
    child: Column(
      children: [
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.blue,
          child: Center(
            child: Text('Row 1', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.green,
          child: Center(
            child: Text('Row 2', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.red,
          child: Center(
            child: Text('Row 3', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
  print('InteractiveViewer with complex child created');

  print('All InteractiveViewer tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== InteractiveViewer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Default:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerDefault),
        SizedBox(height: 8.0),
        Text('No panning:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerNoPan),
        SizedBox(height: 8.0),
        Text('No scaling:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerNoScale),
        SizedBox(height: 8.0),
        Text('Scale 0.5-4.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerScaleRange),
        SizedBox(height: 8.0),
        Text('Boundary margin:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerBoundary),
        SizedBox(height: 8.0),
        Text('Unconstrained:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: viewerUnconstrained),
        SizedBox(height: 8.0),
        Text('Locked:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerLocked),
        SizedBox(height: 8.0),
        Text('Large boundary:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerLargeBoundary),
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerCallbacks),
        SizedBox(height: 8.0),
        Text('Complex child:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: viewerComplex),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• InteractiveViewer allows pan and zoom gestures'),
        Text('• panEnabled/scaleEnabled control gesture types'),
        Text('• minScale/maxScale set zoom limits'),
        Text('• boundaryMargin controls how far content can be panned'),
        Text('• constrained=false allows child to exceed viewer bounds'),
      ],
    ),
  );
}
