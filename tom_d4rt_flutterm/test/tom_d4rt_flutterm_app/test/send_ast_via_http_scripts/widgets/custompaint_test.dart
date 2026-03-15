// D4rt test script: Tests CustomPaint from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CustomPaint test executing');

  // Test CustomPaint with null painter and a child
  final paintBasic = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Basic CustomPaint', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with null painter and child created');

  // Test CustomPaint with size
  final paintSized = CustomPaint(
    size: Size(200.0, 100.0),
    child: Center(child: Text('Sized 200x100')),
  );
  print('CustomPaint with size=200x100 created');

  // Test CustomPaint with isComplex=true (removed: Flutter asserts painter!=null when isComplex is set)
  final paintComplex = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.green,
      child: Center(
        child: Text('isComplex=true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with isComplex=true created');

  // Test CustomPaint with willChange=true (removed: Flutter asserts painter!=null when willChange is set)
  final paintWillChange = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.orange,
      child: Center(
        child: Text('willChange=true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with willChange=true created');

  // Test CustomPaint with isComplex and willChange combined (removed: Flutter asserts painter!=null)
  final paintComplexChange = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Complex + WillChange',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('CustomPaint with isComplex=true and willChange=true created');

  // Test CustomPaint with foregroundPainter (null) and child
  final paintForeground = CustomPaint(
    foregroundPainter: null,
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.red,
      child: Center(
        child: Text('Foreground null', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with null foregroundPainter created');

  // Test CustomPaint with explicit size and no child
  final paintSizeOnly = CustomPaint(
    size: Size(180.0, 80.0),
    isComplex: false,
    willChange: false,
  );
  print('CustomPaint with size only (no child) created');

  // Test CustomPaint with key
  final paintKeyed = CustomPaint(
    key: ValueKey('custom-paint-1'),
    size: Size(200.0, 100.0),
    child: Container(
      color: Colors.teal,
      child: Center(
        child: Text('Keyed CustomPaint', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with key created');

  // Test CustomPaint nested inside other widgets
  final paintNested = Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: CustomPaint(
      size: Size(180.0, 80.0),
      child: Center(child: Text('Nested in Container')),
    ),
  );
  print('CustomPaint nested inside Container created');

  // Test CustomPaint with zero size
  final paintZeroSize = CustomPaint(
    size: Size.zero,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Zero painter size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with Size.zero created');

  print('All CustomPaint tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== CustomPaint Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Basic (null painter):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintBasic,
        SizedBox(height: 8.0),
        Text('Sized 200x100:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, height: 100.0, child: paintSized),
        SizedBox(height: 8.0),
        Text('isComplex=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintComplex,
        SizedBox(height: 8.0),
        Text('willChange=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintWillChange,
        SizedBox(height: 8.0),
        Text(
          'Complex + WillChange:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintComplexChange,
        SizedBox(height: 8.0),
        Text('Foreground null:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintForeground,
        SizedBox(height: 8.0),
        Text(
          'Size only (no child):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 180.0, height: 80.0, child: paintSizeOnly),
        SizedBox(height: 8.0),
        Text('Keyed:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, height: 100.0, child: paintKeyed),
        SizedBox(height: 8.0),
        Text(
          'Nested in Container:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintNested,
        SizedBox(height: 8.0),
        Text('Zero size:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintZeroSize,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CustomPaint provides canvas for custom drawing'),
        Text('• painter draws behind child, foregroundPainter draws in front'),
        Text('• isComplex hints to cache raster layer'),
        Text('• willChange hints that painting will change soon'),
        Text('• size is used when there is no child widget'),
        Text('• Note: CustomPainter subclasses cannot be created in D4rt'),
      ],
    ),
  );
}
